from libqtile import layout
from libqtile.config import Match

from core.helper import load_module
from options import default_colorscheme, default_options

colorscheme_module_path = f"themes.colorschemes.{default_colorscheme}.colors"
colors = load_module(colorscheme_module_path)


gaps_size = default_options["gaps_size"]

layouts = [
    layout.Max(
        border_normal=colors.client_colors["border"],
        border_focus=colors.client_colors["border_focus"],
        border_width=3,
        margin=gaps_size,
    ),
    layout.Tile(
        add_after_last=True,
        border_normal=colors.client_colors["border"],
        border_focus=colors.client_colors["border_focus"],
        border_width=3,
        margin=gaps_size,
        max_ratio=0.50,
        ratio=0.50,
    ),
]

floating_layout = layout.Floating(
    border_focus=colors.client_colors["border_floating"],
    border_normal=colors.client_colors["border"],
    border_width=2,
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="blueman-manager"),
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="gpick"),
        Match(wm_class="lxappearance"),
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="protonvpn"),
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(wm_class="xfce4-about"),
        Match(wm_class="PacketTracer"),
        Match(wm_class="xfce4-power-manager-settings"),
        Match(title="branchdialog"),  # gitk
        Match(title="GNU Image Manipulation Program"),  # gimp
        Match(title="pinentry"),  # GPG key password entry
    ],
)
