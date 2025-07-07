local keys = {
  {
    "<leader>gb",
    mode = { "n" },
    '<cmd>Gitsigns blame<cr>',
    desc = "Open git blame",
  },
  {
    "<leader>gB",
    mode = { "n" },
    '<cmd>Gitsigns blame_line<cr>',
    desc = "Show git blame in a popup",
  },
  {
    "<leader>gh",
    mode = { "n" },
    '<cmd>Gitsigns preview_hunk_inline<cr>',
    desc = "Show git hunk",
  },
  {
    "<leader>gl",
    mode = { "n" },
    '<cmd>Gitsigns setqflist<cr>',
    desc = "Open git hunk list",
  },
  {
    "<leader>gs",
    mode = { "n" },
    '<cmd>Gitsigns toggle_linehl<cr>',
    desc = "Highlight git changes",
  },
}

local options = {
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
