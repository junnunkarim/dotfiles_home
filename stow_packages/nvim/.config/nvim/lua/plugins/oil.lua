local options = {
  columns = {
    -- { "icon" },
    -- { "permissions" },
    -- { "type", highlight = "CursorLine" },
    -- { "mtime" },
    { "size", highlight = "Directory" },
  },
  delete_to_trash = true,
  view_options = {
    show_hidden = true,
  },
  float = {
    padding = 4,
  },
  keymaps = {
    ["q"] = { "actions.close", mode = "n" },
    ["gd"] = {
      callback = function()
        detail = not detail

        if detail then
          require("oil").set_columns({
            { "type", highlight = "Directory" },
            { "permissions" },
            { "mtime" },
            { "size", highlight = "Directory" },
          })
        else
          require("oil").set_columns({ { "size", highlight = "Directory" } })
        end
      end,
      desc = "Toggle file detail view",
    },
  },
}

local keys = {
  -- {
  --   "<leader>F",
  --   mode = { "n" },
  --   '<cmd>lua require("oil").toggle_float()<cr>',
  --   desc = "Open file picker at current buf dir (oil)",
  -- },
  {
    "<leader>-",
    mode = { "n" },
    '<cmd>lua require("oil").toggle_float()<cr>',
    desc = "Open file picker at current buf dir (oil)",
  },
}

return {
  "stevearc/oil.nvim",
  -- dependencies = { { "echasnovski/mini.icons", opts = {} } },
  opts = options,
  keys = keys,
  -- lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  cmd = "Oil",
  event = { "VimEnter */*,.*", "BufNew */*,.*" },
  lazy = true,
}
