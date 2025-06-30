require("visual.colorschemes")

local colors = EVERFOREST

other_colors = {
  light = colors.white,
  gray = colors.gray1,
  dark = colors.black,
  too_dark = colors.black0,

  font = colors.white,
  bg = colors.black,
  border = colors.black,
}

---{{{ Widget Colors
app_launcher_colors = {
  fg = colors.black,
  fg_icon = other_colors.dark,
  bg = colors.red1,
  border = colors.red1,
}

battery_colors = {
  fg = colors.black,
  fg_icon = colors.black,
  bg = colors.blue1,
  bg_icon = colors.blue2,
  border = colors.blue2,
}

time_colors = {
  fg = colors.black,
  fg_icon = colors.black,
  bg = colors.aqua1,
  bg_icon = colors.aqua2,
  border = colors.aqua2,
}

date_colors = {
  fg = colors.black,
  fg_icon = colors.black,
  bg = colors.yellow1,
  bg_icon = colors.yellow2,
  border = colors.yellow2,
}

tray_colors = {
  fg = colors.black,
  fg_icon = colors.black,
  bg = colors.red1,
  border = colors.red2,
}
---}}}

taglist_colors = {
  fg = colors.gray1,
  bg = colors.green1,
  bg_focus = colors.black,
  bg_urgent = colors.black,
  fg_focus = colors.green1,
  fg_occupied = colors.black,
  fg_urgent = colors.red1,
  border = colors.green1,
  hover = colors.aqua1,
}

tasklist_colors = {
  fg = colors.gray,
  fg_focus = colors.black0,
  fg_minimize = colors.red1,
  bg = colors.black,
  bg_focus = colors.gray1,
  bg_minimize = colors.red1,
  border = colors.black,
}

titlebar_colors = {
  border = colors.black,
  border_focus = colors.green1,
}

bar_colors = {
  bg = colors.black,
  border = colors.black,
}
