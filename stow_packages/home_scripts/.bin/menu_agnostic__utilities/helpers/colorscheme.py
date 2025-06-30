import sys

from pathlib import Path
from subprocess import run


# ------------------------------
# functions for color generation
# ------------------------------
def matugen_gen_color(wallpaper: str, scheme: str | None = None) -> str:
    schemes = [
        "scheme-tonal-spot",
        "scheme-neutral",
        "scheme-fidelity",
        "scheme-content",
        "scheme-rainbow",
        "scheme-monochrome",
        "scheme-expressive",
        "scheme-fruit-salad",
    ]

    wallpaper_path = Path("~/.config/wallpaper/" + wallpaper).expanduser()

    command = [
        "matugen",
        "image",
        "-j",
        "hex",
    ]

    if (scheme is not None) and (scheme in schemes):
        command.append("-t")
        command.append(scheme)

    command.append(str(wallpaper_path))

    # run the command
    output = run(command, start_new_session=True, text=True, check=True)

    # return output.returncode

    if output.returncode:
        sys.exit(
            f"return_code: {output.returncode}\n"
            + f"stderr: {output.stderr}\n"
            + f"error: failed to generate colorscheme using 'matugen'\n"
        )

    return output.stdout
