from libqtile.backend.wayland import InputConfig

import core.autostart
from ui.screens import screens

from core.keymaps import keys, mouse
from core.layouts import *
from core.rules import *
from options import default_font

widget_defaults = dict(
    font=default_font,
    fontsize=16,
    padding=0,
)
extension_defaults = widget_defaults.copy()
dgroups_key_binder = None
dgroups_app_rules = []
follow_mouse_focus = True
bring_front_click = False
floats_kept_above = True
cursor_warp = False
auto_fullscreen = True
focus_on_window_activation = "urgent"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = {
    "1267:12448:ELAN0723:00 04F3:30A0 Touchpad": InputConfig(tap=True),
    "*": InputConfig(pointer_accel=True),
    "type:keyboard": InputConfig(
        kb_options="caps:escape,grp:shifts_toggle,grp_led:caps",
        kb_layout="us,us",
        kb_variant="dvorak,",
    ),
}

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
