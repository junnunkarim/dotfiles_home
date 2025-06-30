import os
import json
import random

# Set the seed value
# seed_value = 41
# random.seed(seed_value)

wallpapers = [
    "pixelart_pokemon_rayquaza_forest_16x9.png",
    "pixelart_night_stars_clouds_trees_cozy_PixelArtJourney.png",
    "pixelart_night_stars_shooting-star_river_boat_couple_relaxing.png",
    "scenery_bridge_river_city.jpg",
    "pixelart_evening_trees_pole_wires_makrustic.png",
    "afternoon_light_philip_straub.jpg",
    "anime_Sunset.jpg",
    "mist_forest_nord.jpg",
    "pixelart_mountains_forest_grassland_dreamlike_star_night.jpg",
    "pixelart_night_cozy_fireflies_stars_dog.png",
    "pixelart_thron_dark_someone.png",
    "forest_stairs.jpg",
    "floating_flower.jpg",
    "forest_hut.jpg",
    "home_at_the_end_of_the_world.jpg",
    "pixelart_dock-no4_house_destroyed_warm-color.png",
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
