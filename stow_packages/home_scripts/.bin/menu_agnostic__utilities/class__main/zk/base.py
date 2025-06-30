import os
import sys
import json
import subprocess

# enables importing from parent directories
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), "..")))

from class__base.menu.base import Menu


class ZkMenu:
    def __init__(
        self,
        menu: Menu,
        notebook_dir: str = "/mnt/main/work/notebook/",
        editor_type: str = "gui",
        terminal: str = "kitty",
        editor: str = "nvim",
        gui_editor: str = "code",
        fixed_args: list[str] = ["--no-input", "-P", "--quiet"],
        max_str_len: int = 150,
        return_str: str = " Return",
        icon_menu: str = "󰍜",
        icon_tips: str = "󰔨",
        icon_enter: str = "",
    ):
        if not (editor_type in ["cli", "gui"]):
            sys.exit("'editor_type' must be either 'cli' or 'gui'!")
        else:
            self._editor_type = editor_type

        self._menu = menu
        self._notebook_dir = notebook_dir

        self._terminal = terminal
        self._editor = editor
        self._gui_editor = gui_editor

        self._fixed_args = fixed_args + [f"--notebook-dir={notebook_dir}"]
        self._max_str_len = max_str_len
        self._return_str = return_str

        self._icon_menu = icon_menu
        self._icon_tips = icon_tips
        self._icon_enter = icon_enter

    def _copy_to_clipboard(self, text: str):
        wayland = os.environ.get("WAYLAND_DISPLAY", None)

        if wayland:
            # print(wayland)
            command = ["wl-copy"]
        else:
            command = ["xclip", "-selection", "'clipboard'"]

        subprocess.run(
            command,
            input=text,
            encoding="utf-8",
            start_new_session=True,
        )

    def _truncate_str(
        self,
        string: str,
        max_limit: int,
    ):
        if len(string) > max_limit:
            return string[: max_limit - 3] + "..."

        return string

    def _format_output(
        self,
        title: str,
        tags: str,
        full_path: str,
        sep_space_count: int = 4,
    ) -> str:
        formatted_str = ""
        separator = ""
        for _ in range(sep_space_count):
            separator += " "

        attr_count = 2

        max_attr_str_len = (
            self._max_str_len - (attr_count * sep_space_count)
        ) // attr_count

        # title
        title = self._truncate_str(title, max_attr_str_len)
        formatted_str += title.ljust(max_attr_str_len, " ")

        # tags
        tags = self._truncate_str(tags, max_attr_str_len)
        formatted_str += separator + tags.ljust(max_attr_str_len, " ")

        # filename
        formatted_str += separator + full_path

        return formatted_str

    def get_notes_by_tags(
        self,
        tags: str,
    ) -> str:
        formatted_str = ""

        cmd = ["zk", "list", "--tag", f"{tags}", "-f", "json"] + self._fixed_args
        # cmd = f"zk list --tag {tags} -f json " + " ".join(self._fixed_args)

        output = subprocess.run(
            cmd,
            capture_output=True,
            encoding="utf-8",
        )

        if output.returncode != 0:
            return ""

        if not output.stdout.strip():
            return ""

        json_list = json.loads(output.stdout.strip())

        for entry in json_list:
            title = entry["title"].strip()
            tags = ""
            full_path = f"({entry['absPath'].strip()}"

            for tag in entry["tags"]:
                tags += f"#{tag} "

            tags = "(" + tags.strip() + ")"

            formatted_str += (
                self._format_output(
                    title=title,
                    tags=tags,
                    full_path=full_path,
                )
                + "\n"
            )

        return formatted_str

    def get_all_tags(
        self,
    ) -> str:
        cmd = ["zk", "tag", "list"] + self._fixed_args

        output = subprocess.run(
            cmd,
            capture_output=True,
            encoding="utf-8",
        )

        if output.returncode != 0:
            return ""

        return output.stdout.strip()

    def open_note(self, file_path: str) -> None:
        if self._editor_type == "cli":
            command = [
                self._terminal,
                "-e",
                self._editor,
                file_path,
            ]
            # command = f"{self._terminal} -e zk edit {file_path} -n 1 --notebook-dir={self._notebook_dir}"
        else:  # gui
            if self._gui_editor == "emacsclient -nc":
                command = [
                    "emacsclient",
                    "-nc",
                    file_path,
                ]
            else:
                command = [
                    self._gui_editor,
                    file_path,
                ]

        subprocess.run(command)

    def create_new_note(self, note_type: str):
        if note_type != "new":
            if note_type == "fleeting":
                dir = "fleeting_notes"
            elif note_type == "daily":
                dir = "journal/daily"
            elif note_type == "monthly":
                dir = "journal/monthly"
            else:
                return False

            get_filepath_cmd = f"zk new --no-input {self._notebook_dir}/{dir} --notebook-dir={self._notebook_dir} --print-path"

        elif note_type == "new":
            menu_entries = [
                self._return_str,
                "",
            ]
            menu_entries_str = "\n".join(menu_entries)

            title = self._menu.get_selection(
                entries=menu_entries_str,
                prompt_name="New note title: ",
            )

            if title == menu_entries[0]:
                return False

            get_filepath_cmd = f'zk new --no-input --title "{title}" --working-dir={self._notebook_dir} --print-path'

        file_path = subprocess.run(get_filepath_cmd, shell=True, capture_output=True)

        if file_path.returncode != 0:
            sys.exit("Could not create new note!")

        print(file_path)

        if self._editor_type == "cli":
            command = [
                self._terminal,
                "-e",
                self._editor,
                f"{file_path.stdout.strip()}",
            ]
        else:
            command = self._gui_editor.split(" ") + [file_path.stdout.strip()]

        subprocess.run(command)

        return True

    def show_notes(self, tags: str) -> bool:
        menu_entries = [
            self._return_str,
            "",
        ]
        notes = self.get_notes_by_tags(tags=tags)
        menu_entries_str = "\n".join(menu_entries) + "\n" + notes

        while True:
            selected_note = self._menu.get_selection(
                entries=menu_entries_str,
                prompt_name="Notes: ",
            )

            if selected_note == menu_entries[0]:
                return False
            elif not (selected_note in menu_entries):
                print(f"'{selected_note}'\n")
                file_path = selected_note.split("(")[-1].strip()
                print(f"'{file_path}'")

                self.open_note(file_path=file_path)
                return True

    def show_all_notes(self):
        status = self.show_notes(tags="")

        if status:
            return True
        else:
            return False

    def show_fleeting_notes(self):
        self.show_notes(tags="fleeting_note")

    def show_daily_notes(self):
        self.show_notes(tags="journal, daily")

    def show_monthly_notes(self):
        self.show_notes(tags="journal, monthly")

    def delete_notes(self) -> bool:
        menu_entries = [
            self._return_str,
            "",
        ]

        while True:
            notes = self.get_notes_by_tags(tags="")
            menu_entries_str = "\n".join(menu_entries) + "\n" + notes

            selected_note = self._menu.get_selection(
                entries=menu_entries_str,
                prompt_name="Delete Notes: ",
            )

            if selected_note == menu_entries[0]:
                return False
            elif not (selected_note in menu_entries):
                file_path = selected_note.split("(")[-1].strip()

                confirmation = self._menu.get_confirmation()

                if not confirmation:
                    return False

                output = subprocess.run(
                    ["rm", "-rf", f"{file_path}"], capture_output=True, text=True
                )
                if output.returncode != 0:
                    self._menu.show_message(
                        "Something went wrong!\nCould not delete the selected note!"
                    )

                    return True
                else:
                    self._menu.show_message(
                        "Successfully deleted note!",
                        prompt_name="Success: ",
                    )

                    return False

    def show_tags(self) -> bool:
        menu_entries = [
            self._return_str,
            "",
        ]
        tags = self.get_all_tags()
        menu_entries_str = "\n".join(menu_entries) + "\n" + tags

        while True:
            selected_tag = self._menu.get_selection(
                entries=menu_entries_str,
                prompt_name="Tags: ",
            )

            if selected_tag == menu_entries[0]:
                return False
            elif not (selected_tag in menu_entries):
                tag = selected_tag.split("(")[0].strip()
                bookmarks = self.get_notes_by_tags(tags=tag)
                new_entries_str = "\n".join(menu_entries) + "\n" + bookmarks

                selected_note = self._menu.get_selection(
                    entries=new_entries_str,
                    prompt_name=f"Notes Tagged with '{tag}': ",
                )

                if not (selected_note in menu_entries):
                    file_path = selected_note.split("(")[-1].strip()

                    self.open_note(file_path=file_path)
                    return True

    def search_by_tags(self) -> bool:
        menu_entries = [
            self._return_str,
            "",
        ]

        m_entries = "\n".join(menu_entries)

        tags = self._menu.get_selection(
            entries=m_entries,
            prompt_name="Tags to search for: ",
        )

        if tags == menu_entries[0]:
            return False

        notes = self.get_notes_by_tags(tags=tags)
        menu_entries_str = "\n".join(menu_entries) + "\n" + notes

        while True:
            selected_note = self._menu.get_selection(
                entries=menu_entries_str,
                prompt_name="Notes: ",
            )

            if selected_note == menu_entries[0]:
                return False
            elif not (selected_note in menu_entries):
                file_path = selected_note.split("(")[-1].strip()

                self.open_note(file_path=file_path)
                return True
