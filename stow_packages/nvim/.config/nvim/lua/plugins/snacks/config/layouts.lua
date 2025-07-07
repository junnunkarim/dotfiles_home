-- border = { "🭽", "▔", "🭾", "▕", "🭿", "▁", "🭼", "▏" },

-- custom layouts
return {
  custom_dropdown = {
    filter = { cwd = true },
    layout = {
      backdrop = true,
      row = 1,
      width = 0.8,
      min_width = 80,
      height = 0.8,
      border = "",
      box = "vertical",
      {
        box = "vertical",
        border = { " ", " ", " ", " ", " ", " ", " ", " " },
        title = "{title} {live} {flags}",
        title_pos = "center",
        { win = "input", height = 1, border = "bottom" },
        { win = "list",  border = "none" },
      },
      {
        win = "preview",
        title = "{preview}",
        height = 0.5,
        border = "rounded",
      },
    },
  },
}

