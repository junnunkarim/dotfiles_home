import sys

from fileinput import FileInput
from pathlib import Path


class ProgramColor:
    file_path: Path
    start_concat: str
    end_concat: str
    colorscheme_map: dict

    def __init__(
        self,
        file: str,
        start_concat: str,
        end_concat: str,
        colorscheme_map: dict = {},
    ) -> None:
        file_path = Path(file).expanduser()

        if not file_path.is_file():
            # sys.exit(f"error: file path - '{file_path}' is not found!\n")
            print(f"error: file path - '{file_path}' is not found!\n")
            return

        self.file_path = file_path
        self.start_concat = start_concat
        self.end_concat = end_concat
        self.colorscheme_map = colorscheme_map

    # core string replacement function
    # --------------------------------
    def replace_string(
        self,
        replace: str,
        start_concatenate: str,
        end_concatenate: str,
        file_path: Path,
    ) -> None:
        file_path = Path(file_path).expanduser()

        with FileInput(file_path, inplace=True) as file_content:
            for line in file_content:
                if line.startswith(start_concatenate):
                    # replace the string within quotes
                    line = start_concatenate + replace + end_concatenate + "\n"

                print(line, end="")

    def apply(self, colorscheme: str) -> None:
        if self.colorscheme_map:
            colorscheme = self.colorscheme_map[colorscheme]

        self.replace_string(
            colorscheme, self.start_concat, self.end_concat, self.file_path
        )
