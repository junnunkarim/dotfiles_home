import os
import sys
import json
import re

from subprocess import check_output, run

# enables importing from parent directories
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), "../..")))

from class__base.menu.base import Menu


class HyprClientManager:
    menu: Menu
    clients_info: list = []
    selected_client_dict: dict = {}
    only_minimize: bool = False

    def __init__(self, menu: Menu, only_minimize: bool) -> None:
        self.menu = menu
        self.only_minimize = only_minimize

    def _format_workspace_name(self, workspace_name: str, width: int) -> str:
        if "special:" in workspace_name:
            workspace_name = workspace_name.replace("special", "s").replace("s_", "")
        else:
            workspace_name = workspace_name

        ws_len = len(workspace_name)

        if ws_len > width:
            return workspace_name[: width - 1]
        else:
            return workspace_name + (" " * (width - ws_len))

    def _format_client(self, client):
        title = client.get("title", "").strip()
        # client_class = client.get("class", "").strip()
        address = client.get("address", "").strip()
        workspace_name = client.get("workspace", {}).get("name", "null")
        fullscreen = client.get("fullscreen", 0)
        floating = client.get("floating", False)

        # Check for each state.
        # If the client is fullscreen, use "󰘖", else pad with a space.
        fullscreen_sym = "󰘖" if fullscreen == 2 else " "
        # If the client is floating, use "", else pad with a space.
        floating_sym = "" if floating else " "
        # For minimized, we check either a boolean or a substring in the workspace name.
        minimized_sym = "-" if ("special:s_minimize" in workspace_name) else " "

        # Build the state string; always showing three comma-separated symbols.
        state_str = f"{fullscreen_sym} {floating_sym} {minimized_sym}"

        ws_name = self._format_workspace_name(workspace_name, 10)

        # construct the final formatted string
        # return f"{state_str} {title} [{client_class}] [{address}]"
        return f"{state_str}    {ws_name}    {title} [{address}]"

    def fetch_client_info(self) -> None:
        clients_json = check_output(["hyprctl", "clients", "-j"], text=True)

        self.clients_info = json.loads(clients_json)

    def get_client_list(self) -> list:
        return [
            f"{client['title'].strip()} [{client['class'].strip()}]"
            for client in self.clients_info
        ]

    def focus_client(self):
        if self.selected_client_dict:
            batch_command = (
                f"dispatch focuswindow address:{self.selected_client_dict['address']} ; "
                f"notify 2 3000 0 fontsize:25 Focused on '{self.selected_client_dict['title']}'"
            )

            run(["hyprctl", "--batch", batch_command])

    def minimize_client(self):
        batch_command = (
            f"dispatch movetoworkspacesilent special:s_minimize,address:{self.selected_client_dict['address']} ; "
            f"notify 2 3000 0 fontsize:25 Minimized Client '{self.selected_client_dict['title']}'"
        )

        run(["hyprctl", "--batch", batch_command], capture_output=True)

    def close_client(self, forcekill: bool = False):
        if self.selected_client_dict:
            if forcekill:
                close_command = "killwindow"
            else:
                close_command = "closewindow"

            batch_command = (
                f"dispatch {close_command} address:{self.selected_client_dict['address']} ; "
                f"notify 2 3000 0 fontsize:25 Closed Client/Window '{self.selected_client_dict['title']}'"
            )

            run(["hyprctl", "--batch", batch_command])

    def kill_client(self):
        self.close_client(forcekill=True)

    def show_options(self):
        options: dict = {
            "Focus": self.focus_client,
            "Minimize": self.minimize_client,
            "Close": self.close_client,
            "Kill": self.kill_client,
        }

        option_selected = self.menu.get_selection(
            "\n".join(options.keys()),
            prompt_name="Actions ",
        )

        if option_selected in options:
            options[option_selected]()

    def run(self):
        self.fetch_client_info()

        client_list: list = [
            self._format_client(client) for client in self.clients_info
        ]

        selection = self.menu.get_selection(
            entries="\n".join(client_list),
            prompt_name=f"Clients ({len(self.clients_info)}) ",
        )

        match = re.search(r"\[(0x[0-9a-f]+)\]", selection, re.IGNORECASE)
        if match:
            selected_client_address = match.group(1)
            print(selected_client_address)
        else:
            sys.exit("Error extracting address from selected entry!")

        selected_client_dict = next(
            (
                client
                for client in self.clients_info
                if client.get("address").strip() == selected_client_address.strip()
            ),
            {},
        )
        self.selected_client_dict = selected_client_dict

        if self.only_minimize:
            self.minimize_client()
        else:
            self.show_options()
