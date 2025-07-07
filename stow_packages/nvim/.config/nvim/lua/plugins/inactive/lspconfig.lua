local lsp_configs = {
  bashls = {},
  -- biome = {},
  cssls = {},
  html = {
    init_options = {
      configurationSection = { "html", "css", "javascript" },
      embeddedLanguages = {
        css = true,
        javascript = true,
      },
    },
  },
  hyprls = {},
  lua_ls = {
    settings = {
      Lua = {
        completion = {
          callSnippet = "Replace",
        },
        format = {
          enable = true,
          -- Put format options here
          -- NOTE: the value should be String!
          defaultConfig = {
            indent_style = "space",
            indent_size = "2",
          },
        },
        runtime = {
          version = "LuaJIT",
        },
        diagnostics = {
          globals = {
            "vim",
            "quarto",
            "pandoc",
            "io",
            "string",
            "print",
            "require",
            "table",
            "awesome",
            "screen",
            "client",
          },
          disable = { "trailing-space" },
        },
        workspace = {
          checkThirdParty = false,
          library = {
            unpack(vim.api.nvim_get_runtime_file("", true)),
          },
        },
        telemetry = {
          enable = false,
        },
      },
    },
  },
  marksman = {
    filetypes = { "markdown", "quarto" },
  },
  pyright = {
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
          diagnosticMode = "openFilesOnly",
        },
      },
    },
  },
  rust_analyzer = {
    settings = {
      ["rust-analyzer"] = {
        diagnostics = {
          enable = false,
        },
      },
    },
  },
  texlab = {},
  -- svelte = {
  --   filetypes = { "*.js", "*.ts", "svelte" },
  -- },
  -- vtsls = {},
}

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "saghen/blink.cmp",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",

  },
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  opts = {
    servers = lsp_configs,
  },
  config = function(_, opts)
    local lspconfig = require("lspconfig")
    for server, config in pairs(opts.servers) do
      -- passing config.capabilities to blink.cmp merges with the capabilities in your
      -- `opts[server].capabilities, if you've defined it
      config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
      lspconfig[server].setup(config)
    end
  end,
}
