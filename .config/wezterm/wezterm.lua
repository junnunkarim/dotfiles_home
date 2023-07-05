local wezterm = require 'wezterm'

local rose_pine = require('colorscheme/rose-pine').colors()
local rose_pine_window = require('colorscheme/rose-pine').window_frame()

return{
  font = wezterm.font 'Iosevka Nerd Font Mono',
  font_size = 14.0,
  colors = rose_pine,
  --color_scheme = "Gruvbox Dark",
  window_frame = rose_pine_window,
  hide_tab_bar_if_only_one_tab = true,
  check_for_updates = false,
}
