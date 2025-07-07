-- local mason_ensure_installed = {
--   --[ lsp
--   "bashls",
--   -- "clangd",
--   "cssls",
--   -- "denols",
--   "html",
--   "hyprls",
--   "ltex",
--   "lua_ls",
--   -- "intelephense",
--   -- "marksman",
--   -- "pico8-ls",
--   "pyright",
--   "rust_analyzer",
--   "svelte",
--   "tailwindcss",
--   "taplo",
--   -- "texlab",
--   -- "ts_ls",
--   --
--   --]
--
--   --[ formatter
--   --
--   "ruff",
--   -- "shfmt",
--   -- "stylua",
--   --
--   --]
-- }

local mason__keys = {
  { "<leader>sm", mode = { "n" }, '<cmd>Mason<cr>', desc = "Open Mason", }
}

return {
  {
    "williamboman/mason.nvim",
    opts = {},
    keys = mason__keys,
    event = { "BufReadPre", "BufNewFile" },
  },
}
