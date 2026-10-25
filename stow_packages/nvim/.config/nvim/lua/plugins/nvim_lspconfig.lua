return {
  "neovim/nvim-lspconfig",
  config = function()
    local capabilities = {
      textDocument = {
        foldingRange = {
          dynamicRegistration = false,
          lineFoldingOnly = true,
        },
      },
    }

    -- https://cmp.saghen.dev/installation#merging-lsp-capabilities
    capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

    vim.lsp.config("*", {
      capabilities = capabilities,
      root_markers = { ".git" },
    })

    vim.lsp.config("qmlls", {
      cmd = { "qmlls6" },
    })

    vim.lsp.enable({
      "basedpyright",
      "ccls",
      "cssls",
      "dartls",
      "gopls",
      "html",
      "hyprls",
      "kotlin_lsp",
      "lua_ls",
      "nim_langserver",
      "ocamllsp",
      "oxfmt", -- web
      "oxlint", -- web
      "qmlls",
      -- "qml_language_server",
      "rust_analyzer",
      "racket_langserver",
      "slint_lsp",
      "svelte",
      "sourcekit", -- swift
      "tailwindcss",
      "ts_ls",
    })
  end,
}
