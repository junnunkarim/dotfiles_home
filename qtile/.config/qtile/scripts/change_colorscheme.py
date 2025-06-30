#!/usr/bin/env python

import random
import os
import json
import subprocess

from fileinput import FileInput
from pathlib import Path as path


# helper functions
# --------------------------------
def wallpapers(colorscheme: str) -> list:
    wallpaper_dict = {
        "catppuccin_macchiato": [
            "scenery_bridge_river_city.jpg",
            "pixelart_evening_trees_pole_wires_makrustic.png",
            "pixelart_night_stars_clouds_trees_cozy_PixelArtJourney_catppuccin.png",
            "pixelart_pokemon_rayquaza_forest_16x9.png",
            "pixelart_seabeach_evening.png",
            "pixelart_sky_clouds_stars_moon_16x9.jpg",
        ],
        "dracula": [
            "pixelart_winter_hut_deer_man_dog_hunt_PixelArtJourney.png",
            # "pixelart_arabian_palace_princess_snakepixel.png",
            "floating_flower_dracula.jpg",
        ],
        "everforest": [
            "everforest-walls_fog_forest_1.jpg",
            "everforest-walls_foggy_valley_1.png",
            "forest_stairs.jpg",
        ],
        "gruvbox": [
            "pixelart_house_inside_girl_book_dog_jmw327.png",
            "pixelart_house_chibi_person_game_jmw327.png",
            "pixelart_forest_spirits_girl_adventure_updated.png",
        ],
        "matugen": [
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
        ],
        "nord": [
            "mist_forest_nord.jpg",
            "pixelart_night_train_cozy_gas_RoyalNaym_nord.png",
        ],
        "rose_pine": [
            "pixelart_pokemon_rayquaza_forest_16x9.png",
            "pixelart_night_stars_clouds_trees_cozy_PixelArtJourney.png",
            "pixelart_evening_trees_pole_wires_makrustic.png",
        ],
    }

    return wallpaper_dict[colorscheme]


# core string replacement function
# --------------------------------
def replace_string(
    replace: str, start_concatenate: str, end_concatenate: str, file_path: str
) -> None:
    file = path(file_path).expanduser()

    with FileInput(file, inplace=True) as file:
        for line in file:
            if line.startswith(start_concatenate):
                # Replace the string within quotes
                line = start_concatenate + replace + end_concatenate + "\n"
            print(line, end="")


# functions for changing gui/cli application colorsechemes/themes
# ---------------------------------------------------------------
def alacritty_color(replace: str) -> None:
    start_concatenate = 'import = ["/home/dragoonfx/.config/alacritty/colorschemes/'
    end_concatenate = '.toml"]'
    file_path = "~/.config/alacritty/colors.toml"

    replace_string(replace, start_concatenate, end_concatenate, file_path)


def btop_color(replace: str) -> None:
    start_concatenate = 'color_theme = "'
    end_concatenate = '"'
    file_path = "~/.config/btop/btop.conf"

    replace_string(replace, start_concatenate, end_concatenate, file_path)


def gtk_color(replace: str) -> None:
    start_concatenate = "gtk-theme-name="
    end_concatenate = ""
    file_path = "~/.config/gtk-3.0/settings.ini"

    replace_string(replace, start_concatenate, end_concatenate, file_path)


def helix_color(replace: str) -> None:
    start_concatenate = 'theme = "'
    end_concatenate = '"'
    file_path = "~/.config/helix/config.toml"

    replace_string(replace, start_concatenate, end_concatenate, file_path)


def kitty_color(replace: str) -> None:
    start_concatenate = "include ~/.config/kitty/colorschemes/"
    end_concatenate = ".conf"
    file_path = "~/.config/kitty/kitty.conf"

    replace_string(replace, start_concatenate, end_concatenate, file_path)


def konsole_color(replace: str) -> None:
    start_concatenate = "ColorScheme="
    end_concatenate = ""
    file_path = "~/.local/share/konsole/main.profile"

    replace_string(replace, start_concatenate, end_concatenate, file_path)


def nvim_color(replace: str) -> None:
    start_concatenate = 'local color = "'
    end_concatenate = '"'
    file_path = "~/.config/nvim/lua/core/colorscheme.lua"

    replace_string(replace, start_concatenate, end_concatenate, file_path)


def qtile_color(replace: str) -> None:
    start_concatenate = 'default_colorscheme = "'
    end_concatenate = '"'
    file_path = "~/.config/qtile/options.py"

    replace_string(replace, start_concatenate, end_concatenate, file_path)


def rofi_color(replace: str) -> None:
    start_concatenate = '@import "~/.config/qtile/external_configs/rofi/colorschemes/'
    end_concatenate = '.rasi"'
    file_path = "~/.config/qtile/external_configs/rofi/colors.rasi"

    replace_string(replace, start_concatenate, end_concatenate, file_path)


def zathura_color(replace: str) -> None:
    start_concatenate = "include colorschemes/"
    end_concatenate = ""
    file_path = "~/.config/zathura/zathurarc"

    replace_string(replace, start_concatenate, end_concatenate, file_path)


# functions for hot reloading programs
# ------------------------------------
def reload_kitty() -> None:
    # kitty process ids
    get_process_id = [
        "pgrep",
        "kitty",
    ]

    select = subprocess.run(get_process_id, text=True, capture_output=True, check=False)

    if select.returncode == 0:
        # split the string into separate process ids
        process_ids = select.stdout.replace("\n", " ").split()

        command = ["kill", "-SIGUSR1"] + process_ids

        subprocess.run(command, text=True, check=False)


def reload_qtile() -> None:
    command = [
        "qtile",
        "cmd-obj",
        "-o",
        "cmd",
        "-f",
        "reload_config",
    ]

    subprocess.run(command, text=True, check=False)


# functions for changing lockscreen wallpapers
# ---------------------------------------------------------------
def change_lockscreen(colorscheme: str) -> None:
    home = os.path.expanduser("~")
    prefix = home + "/.config/wallpaper/"
    json_path = home + "/.config/qtile/themes/colorschemes/wallpaper.json"

    # if os.path.exists(json_path):
    #     with open(json_path, "r") as json_file:
    #         data = json.load(json_file)
    #
    #         wall = prefix + data["wallpaper"]
    # else:
    wallpaper_list = wallpapers(colorscheme=colorscheme)

    # select a random wallpaper
    wall = prefix + random.choice(wallpaper_list)

    print(wall)

    command = ["betterlockscreen", "--fx", " ", "-u", wall]

    subprocess.run(command, text=True, check=False)


# all colorscheme switcher function
# ---------------------------------
def change_colorscheme(colorscheme: str) -> None:
    if colorscheme == "catppuccin_macchiato":
        alacritty_color(colorscheme)
        btop_color(colorscheme)
        gtk_color(colorscheme)
        kitty_color(colorscheme)
        konsole_color(colorscheme)
        nvim_color("base16-catppuccin-macchiato")
        qtile_color(colorscheme)
        rofi_color(colorscheme)
        zathura_color(colorscheme)
    elif colorscheme == "dracula":
        alacritty_color(colorscheme)
        btop_color(colorscheme)
        gtk_color(colorscheme)
        kitty_color(colorscheme)
        konsole_color(colorscheme)
        nvim_color("base16-dracula")
        qtile_color(colorscheme)
        rofi_color(colorscheme)
        zathura_color(colorscheme)
    elif colorscheme == "everblush":
        alacritty_color(colorscheme)
        btop_color(colorscheme)
        gtk_color(colorscheme)
        kitty_color(colorscheme)
        konsole_color(colorscheme)
        nvim_color("everblush")
        qtile_color(colorscheme)
        rofi_color(colorscheme)
        zathura_color(colorscheme)
    elif colorscheme == "everforest":
        alacritty_color(colorscheme)
        btop_color(colorscheme)
        gtk_color(colorscheme)
        kitty_color(colorscheme)
        konsole_color(colorscheme)
        nvim_color("base16-everforest")
        qtile_color(colorscheme)
        rofi_color(colorscheme)
        zathura_color(colorscheme)
    elif colorscheme == "gruvbox":
        alacritty_color(colorscheme)
        btop_color(colorscheme)
        gtk_color(colorscheme)
        kitty_color(colorscheme)
        konsole_color(colorscheme)
        nvim_color("base16-gruvbox-dark-medium")
        qtile_color(colorscheme)
        rofi_color(colorscheme)
        zathura_color(colorscheme)
    elif colorscheme == "matugen":
        # alacritty_color(colorscheme)
        # btop_color(colorscheme)
        # gtk_color(colorscheme)
        kitty_color(colorscheme)
        # konsole_color(colorscheme)
        # nvim_color("base16-rose-pine")
        qtile_color(colorscheme)
        rofi_color(colorscheme)
        # zathura_color(colorscheme)
    elif colorscheme == "nord":
        alacritty_color(colorscheme)
        btop_color(colorscheme)
        gtk_color(colorscheme)
        kitty_color(colorscheme)
        konsole_color(colorscheme)
        nvim_color("base16-nord")
        qtile_color(colorscheme)
        rofi_color(colorscheme)
        zathura_color(colorscheme)
    elif colorscheme == "rose_pine":
        alacritty_color(colorscheme)
        btop_color(colorscheme)
        gtk_color(colorscheme)
        kitty_color(colorscheme)
        konsole_color(colorscheme)
        nvim_color("base16-rose-pine")
        qtile_color(colorscheme)
        rofi_color(colorscheme)
        zathura_color(colorscheme)
    else:
        pass


# main function
# --------------------------------
def main() -> None:
    prompt = [
        "rofi",
        "-dmenu",
        "-i",
        "-p",
        "Choose a colorscheme",
        "-theme",
        f"{path('~/.config/qtile/external_configs/rofi/script_menu.rasi').expanduser()}",
    ]
    # prompt = [
    #     "dmenu",
    #     "-l",
    #     "12",
    # ]

    colorschemes = {
        "cancel": " Cancel",
        "catppuccin_macchiato": " Catppuccin (Macchiato)",
        "dracula": " Dracula",
        # "everblush": " Everblush",
        "everforest": " Everforest",
        "gruvbox": " Gruvbox",
        "matugen": " Matugen (Material-You Color Generator)",
        "nord": " Nord",
        "rose_pine": " Rose Pine",
    }

    # variable to pass to dmenu or rofi
    option = "\n".join(colorschemes.values())

    select = subprocess.run(
        prompt, input=option, text=True, capture_output=True, check=True
    ).stdout.strip()

    choice = next((key for key, value in colorschemes.items() if value == select), "")

    change_colorscheme(choice)

    reload_qtile()
    reload_kitty()

    # since betterlockscreen takes time to cache a wallpaper,
    # it needs to be executed last
    change_lockscreen(colorscheme=choice)


if __name__ == "__main__":
    main()
