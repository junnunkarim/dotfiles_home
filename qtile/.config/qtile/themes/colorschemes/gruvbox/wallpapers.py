import os
import json
import random

wallpapers = [
    "pixelart_house_inside_girl_book_dog_jmw327.png",
    "pixelart_house_chibi_person_game_jmw327.png",
    "pixelart_forest_spirits_girl_adventure_updated.png",
    # "floating_flower_gruvbox.jpg",
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
