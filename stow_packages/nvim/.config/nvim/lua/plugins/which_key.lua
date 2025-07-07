local options = {
  -- classic, modern, helix
  preset = "helix",
  icons = {
    breadcrumb = "", -- symbol used in the command line area that shows your active key combo
    separator = "  |", -- symbol used between a key and it's label
    group = " ", -- symbol prepended to a group
    ellipsis = "…",
    -- keymapping icons
    mappings = false,
    colors = false,
  },
  -- keymaps without group -> groups -> special keys
  sort = { "alphanum", "group", "mod", "order" },
}

return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  -- opts = options,
  config = function()
    local wk = require("which-key")

    wk.add({
      { "<leader>d", group = "Diagnostics" },
      { "<leader>e", group = "Error/Debug" },
      { "<leader>g", group = "Git" },
      { "<leader>m", group = "Misc" },
      { "<leader>s", group = "System" },
      { "<leader>t", group = "Terminal" },
      { "<leader>u", group = "Utilities" },
      { "<leader>w", group = "UI" },
    })

    wk.setup(options)
  end,
}
