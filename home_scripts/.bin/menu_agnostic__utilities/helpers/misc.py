import os

from subprocess import run


def copy_to_clipboard(text: str):
    wayland = os.environ.get("WAYLAND_DISPLAY", None)

    if wayland:
        command = ["wl-copy"]
    else:
        command = ["xclip", "-selection", "'clipboard'"]

    run(
        command,
        input=text,
        encoding="utf-8",
        start_new_session=True,
    )
