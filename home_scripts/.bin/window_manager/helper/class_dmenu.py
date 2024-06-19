from .class_menu import Menu


class Dmenu(Menu):
    def __init__(
        self,
        width: int = 500,
        height: int = 45 * 10,
        line: int = 10,
    ) -> None:
        screen_res = self._get_screen_resolution()

        if screen_res:
            # calculate screen dimensions to
            # display the menu at the center of the screen
            res_x, res_y = int(screen_res[0]), int(screen_res[1])
            # 'x' is the x-position of the window's upper left corner
            # 'y' is the y-position of the window's upper left corner
            x = (res_x // 2) - (width // 2)
            y = (res_y // 2) - (height // 2)

            # main prompt
            main_prompt = [
                "dmenu",
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
        else:
            # if can't get screen resolution, use the default prompt
            # main prompt
            main_prompt = ["dmenu", "-h", "40", "-l", "12"]

        super().__init__(main_prompt)