import os
import json
import random

wallpapers = [
    "pixelart_winter_hut_deer_man_dog_hunt_PixelArtJourney.png",
    # "pixelart_arabian_palace_princess_snakepixel.png",
    "floating_flower_dracula.jpg",
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
