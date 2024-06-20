from .class_menu import Menu


class Dmenu(Menu):
    def __init__(
        self,
        main_prompt=["dmenu", "-h", "40", "-l", "12"],
        width: int = 500,
        height: int = 45,
        line: int = 12,
        dmenu_run: bool = False,
        fuzzy: bool = True,
        case_insensitive: bool = True,
    ) -> None:
        screen_res = self._get_screen_resolution()

        if screen_res:
            # calculate screen dimensions to
            # display the menu at the center of the screen
            res_x, res_y = int(screen_res[0]), int(screen_res[1])
            # 'x' is the x-position of the window's upper left corner
            # 'y' is the y-position of the window's upper left corner
            x = (res_x // 2) - (width // 2)
            y = (res_y // 2) - (height * line // 2)  # - 20

            if not dmenu_run:
                main_prompt = ["dmenu"]
            else:
                main_prompt = ["dmenu_run"]

            # main prompt
            main_prompt += [
                "-h",
                "45",
                "-l",
                # "0",
                f"{line}",
                "-W",
                f"{width}",
                "-X",
                f"{x}",
                "-Y",
                f"{y}",
            ]

            if case_insensitive:
                main_prompt += ["-i"]

            if not fuzzy:
                main_prompt += ["-F"]

        super().__init__(main_prompt)
