import os
import json
import random

wallpapers = [
    "scenery_bridge_river_city.jpg",
    "pixelart_evening_trees_pole_wires_makrustic.png",
    "pixelart_night_stars_clouds_trees_cozy_PixelArtJourney_catppuccin.png",
    "pixelart_pokemon_rayquaza_forest_16x9.png",
    "pixelart_seabeach_evening.png",
    # "pixelart_france_house_police-car.jpg",
    # "pixelart_sky_clouds_stars_moon_16x9.jpg",
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
            "test": "test",
        },
        json_file,
        indent=4,
    )
