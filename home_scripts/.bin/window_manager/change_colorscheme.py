#!/usr/bin/env python

from sys import argv
from argparse import ArgumentParser

from helper.class_dmenu import Dmenu
from helper.class_rofi import Rofi
from helper.class_dwm import Dwm
from helper.class_qtile import Qtile
from helper.functions import fail_exit


def apply_colorscheme(menu: str, wm: str) -> None:
    wallpaper_dict = {
        "catppuccin_macchiato": [
            "pixelart_evening_trees_pole_wires_makrustic.png",
            # "pixelart_night_stars_clouds_trees_cozy_PixelArtJourney_catppuccin.png",
            "pixelart_pokemon_rayquaza_forest_16x9.png",
            "pixelart_seabeach_evening.png",
            # "pixelart_sky_clouds_stars_moon_16x9.jpg",
            "scenery_bridge_river_city.jpg",
        ],
        "dracula": [
            "floating_flower_dracula.jpg",
            # "pixelart_arabian_palace_princess_snakepixel.png",
            "pixelart_winter_hut_deer_man_dog_hunt_PixelArtJourney.png",
        ],
        "everblush": [
            "pixelart_forest_flower.png",
            # "pixelart_forest_ruins_castle.png",
        ],
        "everforest": [
            "everforest-walls_fog_forest_1.jpg",
            "everforest-walls_foggy_valley_1.png",
            "forest_stairs.jpg",
        ],
        "gruvbox": [
            "pixelart_house_chibi_person_game_jmw327.png",
            "pixelart_house_inside_girl_book_dog_jmw327.png",
            "pixelart_farm_farmer_warm-color_jmw327.png",
            # "pixelart_flower_clouds_castle.png",
            "pixelart_forest_camp_children_maolow-paoPao.jpg",
            # "pixelart_forest_spirits_girl_adventure_updated.png",
        ],
        "matugen": [
            "afternoon_light_philip_straub.jpg",
            "anime_Sunset.jpg",
            "floating_flower.jpg",
            "forest_hut.jpg",
            "forest_stairs.jpg",
            "home_at_the_end_of_the_world.jpg",
            "mist_forest_nord.jpg",
            "pixelart_dock-no4_house_destroyed_warm-color.png",
            "pixelart_evening_trees_pole_wires_makrustic.png",
            "pixelart_mountains_forest_grassland_dreamlike_star_night.jpg",
            "pixelart_night_cozy_fireflies_stars_dog.png",
            "pixelart_night_stars_clouds_trees_cozy_PixelArtJourney.png",
            "pixelart_night_stars_shooting-star_river_boat_couple_relaxing.png",
            "pixelart_pokemon_rayquaza_forest_16x9.png",
            "pixelart_thron_dark_someone.png",
            "scenery_blue_sea_beach_summer.jpg",
            "scenery_bridge_river_city.jpg",
            "scenery_field_farmland_wheat_clouds.jpg",
            "scenery_flowers_hill_clouds_colorful_dmitryalexander.jpg",
            "scenery_green_grass_aesthetic_relaxing.jpg",
            "scenery_night_forest_fairy.jpg",
            "scenery_pastel_clouds_dreamlike.jpg",
            "scenery_pokemon_akari_hisuian_growlithe_snorunt_wyrdeer__pixiescout.jpg",
            "scenery_space_portal_galaxy.jpg",
            "scenery_star_sky_galaxy.jpg",
            "scenery_tower_sky_landscape.jpg",
        ],
        "nord": [
            "mist_forest_nord.jpg",
            "pixelart_night_train_cozy_gas_RoyalNaym_nord.png",
            "scenery_pokemon_akari_hisuian_growlithe_snorunt_wyrdeer__pixiescout.jpg",
        ],
        "rose_pine": [
            "pixelart_evening_trees_pole_wires_makrustic.png",
            "pixelart_night_stars_clouds_trees_cozy_PixelArtJourney.png",
            "pixelart_pokemon_rayquaza_forest_16x9.png",
        ],
    }

    colorschemes = {
        "cancel": " Cancel",
        "catppuccin_macchiato": " Catppuccin (Macchiato)",
        "dracula": " Dracula",
        "everblush": " Everblush",
        "everforest": " Everforest",
        "gruvbox": " Gruvbox",
        "matugen": " Matugen (Material-You Color Generator)",
        "nord": " Nord",
        "rose_pine": " Rose Pine",
    }

    if menu == "dmenu":
        menu_obj = Dmenu(
            width=600,
            line=len(colorschemes),
        )
    # elif menu == "rofi":
    #     menu_obj = Rofi()
    else:
        fail_exit(error=f"Menu - '{menu}' is not recognized!")
        return  # for supressing warnings

    if wm == "dwm":
        wm_obj = Dwm(
            menu=menu_obj,
            wallpaper_dict=wallpaper_dict,
            colorscheme_dict=colorschemes,
        )
    # elif wm == "qtile":
    #     wm_obj = Qtile(menu_obj)

    else:
        fail_exit(error=f"Window manager - '{wm}' is not recognized!")
        return  # for supressing warnings

    wm_obj.apply(choose_wallpaper=True)


def main():
    wms = ["dwm"]
    menus = ["dmenu"]

    arg_parser = ArgumentParser(description="change colorscheme")
    # define necessary cli arguments
    arg_parser.add_argument(
        "-m",
        "--menu",
        help="specify the menu launcher",
        choices=menus,
        required=True,
    )
    arg_parser.add_argument(
        "-w",
        "--window-manager",
        help="specify the window manager",
        choices=wms,
        required=True,
    )

    # if no cli arguments are provided, show the help message and exit
    if len(argv) <= 1:
        arg_parser.print_help()
        fail_exit()

    # parse all cli arguments
    args = arg_parser.parse_args()

    # 'window-manager' is accessed by 'window_manager'
    if args.menu and args.window_manager:
        apply_colorscheme(menu=args.menu, wm=args.window_manager)
    else:
        arg_parser.print_help()
        fail_exit()


if __name__ == "__main__":
    main()
