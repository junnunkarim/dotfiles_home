import sys
import os

# enables importing from parent directories
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), "..")))

from class__base.menu.base import Menu


class Tofi(Menu):
    def __init__(
        self,
        main_prompt=["tofi"],
    ) -> None:
        # main_prompt += [
        #     "--lines",
        #     f"{line}",
        #     "--width",
        #     f"{width}",
        # ]

        super().__init__(main_prompt, prompt_flag="--prompt-text")
