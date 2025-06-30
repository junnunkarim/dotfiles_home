require("visual.colorschemes")

local colors = NORD

other_colors = {
  light = colors.white,
  gray = colors.black2,
  dark = colors.black,
  too_dark = colors.black0,

  font = colors.white,
  bg = colors.black0,
  border = colors.black,
}

---{{{ Widget Colors
app_launcher_colors = {
  fg = colors.black0,
  fg_icon = colors.black0,
  bg = colors.red1,
  border = colors.red1,
}

battery_colors = {
  fg = colors.black0,
  fg_icon = colors.green1,
  bg = colors.green1,
  bg_icon = colors.black1,
  border = colors.black1,
}

time_colors = {
  fg = colors.black0,
  fg_icon = colors.blue1,
  bg = colors.blue1,
  bg_icon = colors.black1,
  border = colors.black1,
}

date_colors = {
  fg = colors.black,
  fg_icon = colors.yellow1,
  bg = colors.yellow1,
  bg_icon = colors.black1,
  border = colors.black1,
}

tray_colors = {
  fg = colors.black,
  fg_icon = colors.black,
  bg = colors.red1,
  border = colors.red1,
}
---}}}

taglist_colors = {
  fg = colors.white,
  bg = colors.blue3,
  bg_focus = colors.black0,
  bg_urgent = colors.black0,
  fg_focus = colors.blue3,
  fg_occupied = colors.black0,
  fg_urgent = colors.red1,
  border = colors.blue4,
  hover = colors.white,
}

tasklist_colors = {
  fg = colors.blue4,
  fg_focus = colors.white,
  fg_minimize = colors.red1,
  bg = colors.black0,
  bg_focus = colors.blue4,
  bg_minimize = colors.red1,
  border = colors.black0,
}

titlebar_colors = {
  border = colors.black,
  border_focus = colors.green1,
}

bar_colors = {
  bg = colors.black0,
  border = colors.black0,
}
