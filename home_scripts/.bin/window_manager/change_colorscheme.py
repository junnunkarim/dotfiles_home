#!/usr/bin/env python

from sys import argv
from argparse import ArgumentParser

from helper.class_dmenu import Dmenu
from helper.class_fuzzel import Fuzzel
# from helper.class_rofi import Rofi

# from helper.class_qtile import Qtile
from helper.class_dwm import Dwm
from helper.class_hyprland import Hyprland

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
            # "pixelart_arabian_palace_princess_snakepixel.png",
            "pixelart_winter_hut_deer_man_dog_hunt_PixelArtJourney.png",
        ],
        "everblush": [
            "pixelart_forest_flower.png",
            # "pixelart_forest_ruins_castle.png",
        ],
        "everforest": [
            "scenery_forest_stairs.jpg",
            "scenery_deep_forest_pathway.jpg",
            "everforest-walls_fog_forest_1.jpg",
            "everforest-walls_foggy_valley_1.png",
        ],
        "gruvbox": [
            "pixelart_house_chibi_person_game_jmw327.png",
            "pixelart_house_inside_girl_book_dog_jmw327.png",
            "scenery_astronaut_space_moon_flowers.jpg",
            "scenery_solar_system.jpg",
            "pixelart_farm_farmer_warm_color_jmw327.png",
            # "pixelart_flower_clouds_castle.png",
            "pixelart_forest_camp_children_maolow-paoPao.jpg",
            # "pixelart_forest_spirits_girl_adventure_updated.png",
        ],
        "matugen": [
            "pixelart_clouds_backroads_final.png",
            "pixelart_dock_no4_house_destroyed_warm_color.png",
            "pixelart_evening_trees_pole_wires_makrustic.png",
            "pixelart_grassland_flowers_field_clouds.png",
            "pixelart_mountains_dark_sky.png",
            "pixelart_mountains_forest_grassland_dreamlike_star_night.png",
            "pixelart_mountains_unknown-object_trees.jpg",
            "pixelart_night_boat_duck_lanturn_man__tonbo.png",
            "pixelart_night_cozy_fireflies_stars_dog.png",
            "pixelart_night_fireplace_comfy.png",
            "pixelart_night_stars_clouds_trees_cozy_PixelArtJourney.png",
            "pixelart_pokemon_rayquaza_forest_16x9.png",
            "pixelart_sky_clouds_dog_girl__toyoi_yuuta.png",
            # "pixelart_sunset_evening_constellation_coulds_forest_rail.png",
            # "pixelart_sunset_sunflower_dark_horizon.png",
            "pixelart_thron_dark_someone.png",
            "scenery_astronaut_space_moon_flowers.jpg",
            "scenery_bench_abandoned__home_nobi.jpg",
            "scenery_blue_sea_beach_summer.jpg",
            "scenery_botw_link_castle.jpg",
            "scenery_bridge_river_city.jpg",
            "scenery_comets_clouds_sky_blaze.jpg",
            "scenery_dark_forest_trees__jr_korpa.jpg",
            "scenery_dark_night_forest_snow_person__winter_in_the_forest__somartist.jpg",
            "scenery_deep_forest_foggy_misty.png",
            "scenery_deep_forest_pathway.jpg",
            "scenery_eclipse__aenamiart.jpg",
            "scenery_evening_building_road_purple.jpg",
            "scenery_evening_girl_city_sky_coulds_someday__aenamiart.jpg",
            "scenery_evening_sky_clouds_river__uomi__ai.jpg",
            "scenery_field_farmland_wheat_clouds.jpg",
            "scenery_floating_flower.jpg",
            "scenery_flowers_hill_clouds_colorful_dmitryalexander.jpg",
            "scenery_flower_white_bloom_dark.png",
            "scenery_forest_hut.jpg",
            "scenery_forest_stairs.jpg",
            "scenery_forest_road_light_ray__john_towner.jpg",
            "scenery_green_grass_aesthetic_relaxing.jpg",
            "scenery_japanese_pedestrian_street.jpg",
            "scenery_japanese_store_walls.jpg",
            "scenery_juanjuan_journey__hw6523.jpg",
            "scenery_lake_forest_evening_sky_clouds_around_us__aenamiart.jpg",
            "scenery_lake_trees_mountain_rock.jpg",
            "scenery_mist_forest_nord.jpg",
            "scenery_mountain_ice__inno_squirrel__ai.png",
            "scenery_mountain_path_fields__claudio_testa.jpg",
            "scenery_night_forest_fairy.jpg",
            "scenery_pastel_clouds_dreamlike.jpg",
            "scenery_pokemon_akari_hisuian_growlithe_snorunt_wyrdeer__pixiescout.jpg",
            "scenery_river_boat_mountain_chinese_architecture__unknownno3__ai.jpg",
            "scenery_river_tree_forest_evening__inno_squirrel__ai.jpg",
            "scenery_shooting_star_sky_person_evening__uomi__ai.jpg",
            "scenery_sky_clouds_telephone_towers_timeless__aenamiart.jpg",
            "scenery_sky_swored_tower_cloaked_man__uomi.jpg",
            "scenery_snow_forest_lake_serenity__aenamiart.jpg",
            "scenery_solar_system.jpg",
            "scenery_space_portal_galaxy.jpg",
            "scenery_star_sky_galaxy.jpg",
            "scenery_tower_sky_landscape.jpg",
            "scenery_village_cottege_boat__dmitryalexander.jpg",
            # "scenery_walls_japanese_store__everforest.jpg",
            "scenery_white_flowers_closeup.jpg",
        ],
        "nord": [
            "pixelart_night_train_cozy_gas_RoyalNaym_nord.png",
            "scenery_mist_forest_nord.jpg",
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
    elif menu == "fuzzel":
        menu_obj = Fuzzel(
            width=50,
            line=10,
        )
    else:
        fail_exit(error=f"Menu - '{menu}' is not recognized!")
        return  # for supressing warnings

    if wm == "dwm":
        wm_obj = Dwm(
            menu=menu_obj,
            wallpaper_dict=wallpaper_dict,
            colorscheme_dict=colorschemes,
        )
    elif wm == "hyprland":
        wm_obj = Hyprland(
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
    wms = ["dwm", "hyprland"]
    menus = ["dmenu", "fuzzel"]

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
