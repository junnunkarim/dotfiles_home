import os
import sys
import json
import re

from subprocess import check_output, run

# enables importing from parent directories
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), "../..")))

from class__base.menu.base import Menu
