local keys = {
  {
    "<leader>gb",
    mode = { "n" },
    "<cmd>Gitsigns blame<cr>",
    desc = "Open git blame of current buffer",
  },
  {
    "<leader>gB",
    mode = { "n" },
    function()
      require("gitsigns").blame_line({ full = true })
    end,
    desc = "Show git blame in a popup",
  },
  {
    "<leader>gh",
    mode = { "n" },
    "<cmd>Gitsigns preview_hunk_inline<cr>",
    desc = "Show git hunk",
  },
  {
    "<leader>gH",
    mode = { "n" },
    "<cmd>Gitsigns setqflist<cr>",
    desc = "Open git hunk list",
  },
  -- {
  --   "<leader>gs",
  --   mode = { "n" },
  --   '<cmd>Gitsigns toggle_linehl<cr>',
  --   desc = "Highlight git changes",
  -- },
}

local options = {
  current_line_blame = true,
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    use_focus = true,
  },
  preview_config = {
    col = 1,
    relative = "cursor",
    row = 0,
    style = "minimal",
    border = "single",
  },
}

return {
  "lewis6991/gitsigns.nvim",
  opts = options,
  keys = keys,
  event = { "BufReadPre", "BufNewFile" },
  lazy = true,
}
