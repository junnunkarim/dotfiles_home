import sys
import os

from subprocess import check_output

# enables importing from parent directories
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), "..")))

from class__base.menu.base import Menu


class Dmenu(Menu):
    def __init__(
        self,
        main_prompt=["dmenu", "-l", "15"],
        width: int = 500,
        height: int = 45,
        line: int = 12,
        dmenu_run: bool = False,
        fuzzy: bool = True,
        case_insensitive: bool = True,
        original_dmenu: bool = False,
    ) -> None:
        if not original_dmenu:
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

    def _get_screen_resolution(self):
        command = ["xrandr"]
        output = check_output(command).decode()

        for line in output.splitlines():
            if "current" in line:
                resolution = (
                    line.split("current ")[1].split(",")[0].strip().split(" x ")
                )
                break
        else:
            resolution = None

        return resolution
