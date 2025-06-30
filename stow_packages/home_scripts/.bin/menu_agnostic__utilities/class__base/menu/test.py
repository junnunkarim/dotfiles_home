import os
import sys

# enables importing from parent directories
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), "..")))

from menu.base import Menu

menu = Menu(main_prompt=["fuzzel", "-d"])

confirmation = menu.get_confirmation()

print(confirmation)
