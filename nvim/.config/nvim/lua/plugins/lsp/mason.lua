local mason_ensure_installed = {
  --[ lsp
  "bashls",
  -- "clangd",
  "cssls",
  -- "denols",
  "html",
  "hyprls",
  "ltex",
  "lua_ls",
  -- "intelephense",
  -- "marksman",
  -- "pico8-ls",
  "pyright",
  "rust_analyzer",
  "svelte",
  "tailwindcss",
  "taplo",
  -- "texlab",
  -- "ts_ls",
  --
  --]

  --[ formatter
  --
  "ruff",
  -- "shfmt",
  -- "stylua",
  --
  --]
}

return {
  -- the following order is important
  {
    "williamboman/mason.nvim",
    cmd = 'Mason',
    config = function()
      require("mason").setup()

      local util = require("util")
      util.set_keymap("n", "<leader>sm", "<cmd>Mason<cr>", { desc = "Open Mason" })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
    },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = mason_ensure_installed,
      })
    end,
  },
}
