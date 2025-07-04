local options = {
  columns = {
    "icon",
    -- "permissions",
    -- "size",
    -- "mtime",
  },
  delete_to_trash = true,
  view_options = {
    show_hidden = true,
  },
  float = {
    -- Padding around the floating window
    padding = 4,
  },
}

local keys = {
  {
    "<leader>-",
    mode = { "n", "v" },
    '<cmd>lua require("oil").toggle_float()<cr>',
    desc = "Open Oil",
  }
}

return {
  'stevearc/oil.nvim',
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  opts = options,
  keys = keys,
  -- lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false,
}
