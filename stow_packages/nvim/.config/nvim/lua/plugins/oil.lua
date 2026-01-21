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
    border = "rounded",
    get_win_title = function(winid)
      local cwd = vim.fn.getcwd()
      local buf = vim.api.nvim_win_get_buf(winid)

      local oil_file_path = vim.api.nvim_buf_get_name(buf)
      local file_path = string.gsub(oil_file_path, "oil://", "")
      local relative_path = string.gsub(file_path, cwd, "")

      -- return "  " .. file_path
      return "  " .. ".." .. relative_path
    end,
  },
  keymaps = {
    ["<C-s>"] = { "actions.select", opts = { horizontal = true } },
    ["<C-v>"] = { "actions.select", opts = { vertical = true } },
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
  opts = options,
  keys = keys,
  cmd = "Oil",
  event = { "VimEnter */*,.*" },
  lazy = true,
}
