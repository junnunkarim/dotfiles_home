import os
import sys

from subprocess import run, check_output

# enables importing from parent directories
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), "..")))

from class__base.clipboard.base import Clipboard


class ClipboardX11(Clipboard):
    def __init__(self, menu: str, prompt_name: str = "Clipboard: ") -> None:
        super().__init__(menu, prompt_name)

    def run(self):
        # get clipboard history from greenclip
        history = check_output(["greenclip", "print"])

        # user selected history
        selection = self.menu_obj.get_selection(
            entries=history.decode(),
            prompt_name=self.prompt_name,
        )

        run(
            ["greenclip", "print", selection],
            text=True,
        )
