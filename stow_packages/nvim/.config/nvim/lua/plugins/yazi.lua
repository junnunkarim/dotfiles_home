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
    desc = "Open yazi at the current file",
  },
  -- {
  --   "<c-up>",
  --   "<cmd>Yazi toggle<cr>",
  --   desc = "Resume the last yazi session",
  -- },
}

return {
  "mikavilpas/yazi.nvim",
  event = "VeryLazy",
  dependencies = {
    { "nvim-lua/plenary.nvim", lazy = true },
  },
  keys = keys,
  opts = options,
}
