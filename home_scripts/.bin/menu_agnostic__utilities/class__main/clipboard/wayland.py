import os
import sys

from subprocess import run, check_output

# enables importing from parent directories
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), "..")))

from class__base.clipboard.base import Clipboard


class ClipboardWayland(Clipboard):
    def __init__(self, menu: str, prompt_name: str = "Clipboard: ") -> None:
        super().__init__(menu, prompt_name)

    def parse_histories(self, raw_history: str) -> dict:
        history = {}

        for line in raw_history.strip().splitlines():
            parts = line.split("\t", 1)

            if len(parts) != 2:
                continue  # skip lines not matching the expected format

            id, title = parts
            title = title.strip()

            # only add the entry if the title is not already in the dict
            if title not in history:
                history[title] = id.strip()

        return history

    def run(self):
        # get clipboard history from cliphist
        raw_history = check_output(["cliphist", "list"]).decode()

        history: dict = self.parse_histories(raw_history)

        # user selected history
        selection = self.menu_obj.get_selection(
            entries="\n".join(history.keys()),
            prompt_name=self.prompt_name,
        )

        full_selection_str = check_output(
            ["cliphist", "decode", history[selection]]
        ).decode()

        run(
            # `--` make coping entries with dashes possible
            ["wl-copy", "--", full_selection_str],
            text=True,
        )
