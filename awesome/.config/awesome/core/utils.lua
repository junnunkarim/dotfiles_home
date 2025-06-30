-- This is used later as the default terminal and editor to run.
terminal = "kitty"
editor = os.getenv("EDITOR") or "vi"
editor_cmd = terminal .. " start " .. editor

SUPER = "Mod4"
ALT = "Mod1"
