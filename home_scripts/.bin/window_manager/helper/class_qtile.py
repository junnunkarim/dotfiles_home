from subprocess import run, Popen

from .class_window_manager import Window_manager
from .class_menu import Menu


class Qtile(Window_manager):
    # ------------------------------------
    # functions for hot reloading programs
    # ------------------------------------
    def reload_kitty(self) -> None:
        # kitty process ids
        get_process_id = [
            "pgrep",
            "kitty",
        ]

        select = run(get_process_id, text=True, capture_output=True, check=False)

        if select.returncode == 0:
            # split the string into separate process ids
            process_ids = select.stdout.replace("\n", " ").split()

            command = ["kill", "-SIGUSR1"] + process_ids

            Popen(command, start_new_session=True)

    def reload_qtile(self) -> None:
        command = [
            "qtile",
            "cmd-obj",
            "-o",
            "cmd",
            "-f",
            "reload_config",
        ]

        Popen(command, start_new_session=True)
