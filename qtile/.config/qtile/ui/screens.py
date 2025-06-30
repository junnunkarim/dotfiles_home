import os
import json

from libqtile.config import Screen

from options import default_colorscheme
from .bar import top_bar
from core.helper import load_module


home = os.path.expanduser("~")
prefix = home + "/.config/wallpaper/"
json_path = home + "/.config/qtile/themes/colorschemes/wallpaper.json"

# if os.path.exists(json_path):
#     with open(json_path, "r") as json_file:
#         data = json.load(json_file)
#
#         wall = prefix + data["wallpaper"]
# else:
wallpaper_module_path = f"themes.colorschemes.{default_colorscheme}.wallpapers"
wall_mod = load_module(wallpaper_module_path)

wall = wall_mod.wall

screens = [
    Screen(top=top_bar, wallpaper=wall, wallpaper_mode="fill"),
]
