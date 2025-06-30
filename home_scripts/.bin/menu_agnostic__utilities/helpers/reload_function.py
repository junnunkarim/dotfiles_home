import time

from pathlib import Path
from subprocess import run, Popen, check_output


def reload_dwm(
    xresource_path: Path = Path("~/.Xresources").expanduser(),
) -> None:
    xrdb_command = [
        "xrdb",
        "-merge",
        f"-I'$HOME'",
        f"{xresource_path}",
    ]

    run(xrdb_command)

    xsetroot_command = [
        "xsetroot",
        "-name",
        "fsignal:2",
    ]

    run(xsetroot_command)

    restart_luastatus = [
        f"{Path('~/.config/dwm/scripts/dwm_statusbar').expanduser()}",
    ]
    Popen(restart_luastatus, start_new_session=True)


# ------------------------------------
# functions for hot reloading programs
# ------------------------------------
def reload_kitty():
    command = ["pkill", "-SIGUSR1", "-x", "kitty"]

    Popen(command, start_new_session=True)


def reload_konsole(
    change_colors_to: str,
    main_profile: str,
    dummy_profile: str = "dummy",
    delay: float = 0.05,
):
    # get all konsole instances
    konsole_instances = check_output(["qdbus"], text=True).splitlines()
    konsole_instances = [i for i in konsole_instances if "org.kde.konsole" in i]

    # `dummy` must be at the start
    profiles = [dummy_profile, main_profile]

    for instance in konsole_instances:
        # aet all sessions for the instance
        sessions = check_output(
            ["qdbus", f"{instance.strip()}"], text=True
        ).splitlines()
        sessions = [s for s in sessions if s.startswith("/Sessions/")]

        for session in sessions:
            for profile in profiles:
                command_1 = [
                    "qdbus",
                    f"{instance.strip()}",
                    f"{session.strip()}",
                    "org.kde.konsole.Session.setProfile",
                    f"{profile}",
                ]
                run(command_1, start_new_session=True, check=True)

                time.sleep(delay)

            # inserts the cammond into all open konsole clients
            # creates issues
            # set_colors = [
            #     "qdbus",
            #     f"{instance.strip()}",
            #     f"{session.strip()}",
            #     "org.kde.konsole.Session.runCommand",
            #     f"konsoleprofile colors={change_colors_to}",
            # _]
            # run(set_colors, start_new_session=True, check=True)
            #
            # time.sleep(delay)

    # print(f"Successfully applied color profiles: {colors}")
