local custom_zen = {
  enter = true,
  fixbuf = false,
  minimal = false,
  width = 120,
  height = 0,
  backdrop = { transparent = false, blend = 99 },
  keys = { q = false },
  zindex = 40,
  wo = {
    winhighlight = "NormalFloat:Normal",
  },
  w = {
    snacks_main = true,
  },
}

return {
  enabled = true,
  toggles = {
    dim = true,
    git_signs = true,
    mini_diff_signs = true,
  },
  win = {
    style = custom_zen,
  },
}
