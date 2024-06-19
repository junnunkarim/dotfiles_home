from pathlib import Path

from .class_menu import Menu


class Rofi(Menu):
    def __init__(
        self,
        line: int = 10,
        config_path: Path = Path(),
    ) -> None:
        if config_path.is_file():
            # if config is found at specific directory, use it
            main_prompt = [
                "rofi",
                "-dmenu",
                "-i",
                "-l",
                f"{line}",
                "-theme",
                f"{config_path}",
            ]
        else:
            # if window-manager name is not given,
            # use default 'rofi' theme
            main_prompt = [
                "rofi",
                "-dmenu",
                "-i",
                "-l",
                f"{line}",
            ]

        super().__init__(main_prompt)
