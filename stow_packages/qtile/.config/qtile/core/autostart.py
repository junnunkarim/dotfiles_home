import os
import subprocess

from libqtile import hook, qtile


@hook.subscribe.startup_once
def autostart():
    if qtile.core.name == "x11":
        autostart_script = os.path.expanduser("~/.config/qtile/core/autostart.sh")
    elif qtile.core.name == "wayland":
        autostart_script = os.path.expanduser("~/.config/qtile/core/autostart_wl.sh")

    subprocess.Popen([autostart_script])
