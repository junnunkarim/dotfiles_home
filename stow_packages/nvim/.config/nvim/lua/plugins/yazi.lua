local options = {
  open_for_directories = false,
  keymaps = {
    show_help = "<f1>",
  }
}

local keys = {
  {
    "<leader>_",
    mode = { "n", "v" },
    "<cmd>Yazi<cr>",
    desc = "Open file picker at current buf dir (yazi)",
  },
}

return {
  "mikavilpas/yazi.nvim",
  dependencies = {
    { "nvim-lua/plenary.nvim", lazy = true },
  },
  keys = keys,
  opts = options,
  cmd = "Yazi",
  lazy = true,
}
