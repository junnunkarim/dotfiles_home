from .class_menu import Menu


class Fuzzel(Menu):
    def __init__(
        self,
        main_prompt=["fuzzel", "-d"],
        width: int = 80,
        # height: int = 45,
        line: int = 15,
        # fuzzy: bool = True,
        # case_insensitive: bool = True,
        # original_dmenu: bool = False,
    ) -> None:
        main_prompt += [
            "--lines",
            f"{line}",
            "--width",
            f"{width}",
            # "--no-sort",
        ]

        super().__init__(main_prompt)
