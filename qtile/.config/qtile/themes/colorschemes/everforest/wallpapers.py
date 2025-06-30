import os
import json
import random

wallpapers = [
    "everforest-walls_fog_forest_1.jpg",
    "everforest-walls_foggy_valley_1.png",
    "forest_stairs.jpg",
]


home = os.path.expanduser("~")
prefix = home + "/.config/wallpaper/"

choice = random.choice(wallpapers)
wall = prefix + choice
# wall = wallpapers[0]


# dump the chosen wallpaper in a json so that `change_colorscheme`
# script can use to set lockscreen wallpaper
json_path = home + "/.config/qtile/themes/colorschemes/wallpaper.json"

with open(json_path, "w") as json_file:
    json.dump(
        {
            "wallpaper": choice,
        },
        json_file,
        indent=4,
    )
