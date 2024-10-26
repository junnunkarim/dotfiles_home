from .class_menu import Menu


class Tofi(Menu):
    def __init__(
        self,
        main_prompt=["tofi"],
        prompt_flag="--prompt-text",
        # width: int = 80,
        # height: int = 45,
        # line: int = 15,
        # dmenu_run: bool = False,
        # fuzzy: bool = True,
        # case_insensitive: bool = True,
        # original_dmenu: bool = False,
    ) -> None:
        # main_prompt += [
        #     "--lines",
        #     f"{line}",
        #     "--width",
        #     f"{width}",
        #     # "--no-sort",
        # ]

        super().__init__(main_prompt, prompt_flag)
