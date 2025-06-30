from libqtile import qtile
from libqtile.config import DropDown, Key, ScratchPad
from libqtile.lazy import lazy

from .keymaps import keys, mod

if qtile.core.name == "x11":
    drop_terminal = "konsole --name scratch_term"
# wayland
else:
    drop_terminal = "konsole"

dropdowns = [
    DropDown(
        "term",
        drop_terminal,
        width=0.7,
        height=0.7,
        x=0.165,
        y=0.1,
        on_focus_lost_hide=False,
    ),
    DropDown(
        "password_manager",
        "keepassxc",
        width=0.8,
        height=0.8,
        x=0.1,
        y=0.1,
        on_focus_lost_hide=False,
    ),
    DropDown(
        "task_manager",
        "kitty btop",
        width=0.8,
        height=0.8,
        x=0.1,
        y=0.1,
        on_focus_lost_hide=False,
    ),
]

keys.extend(
    [
        Key(
            [mod, "shift"],
            "Return",
            lazy.group["scratchpad"].dropdown_toggle("term"),
            desc="Terminal (dropdown)",
        ),
        Key(
            [mod, "shift"],
            "BackSpace",
            lazy.group["scratchpad"].dropdown_toggle("password_manager"),
            desc="Password manager (dropdown)",
        ),
        Key(
            [mod, "shift"],
            "h",
            lazy.group["scratchpad"].dropdown_toggle("task_manager"),
            desc="Task manager (btop) (dropdown)",
        ),
    ]
)

scratchpad = ScratchPad("scratchpad", dropdowns)
