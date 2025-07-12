local options = {
  keymap = {
    preset = "cmdline",

    ["<CR>"] = { "accept", "fallback" },
    ["<Esc>"] = { "fallback" },
    ['<Tab>'] = { "select_next", "fallback" },
    ['<S-Tab>'] = { "select_prev", "fallback" },

    ["<A-n>"] = { "scroll_documentation_down", "fallback" },
    ["<A-p>"] = { "scroll_documentation_up", "fallback" },
  },

  appearance = {
    -- Sets the fallback highlight groups to nvim-cmp's highlight groups
    -- Useful for when your theme doesn't support blink.cmp
    -- Will be removed in a future release
    use_nvim_cmp_as_default = true,
    nerd_font_variant = "mono",
  },

  completion = {
    accept = {
      auto_brackets = {
        enabled = true,
      },
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 100,
      window = {
        border = "rounded",
      },
    },
    list = {
      selection = {
        preselect = false,
        auto_insert = false,
      },
    },
    ghost_text = {
      enabled = false,
    },
    menu = {
      border = "rounded",
      draw = {
        columns = {
          { "kind_icon", "label",       "label_description", gap = 1 },
          { "kind",      "source_name", gap = 1 },
        },
        treesitter = { "lsp" },
      },
    },
  },
  signature = {
    enabled = true,
    triger = {
      enabled = true,
      show_on_insert = false,
    },
    window = {
      border = "single",
      show_documentation = true,
    },
  },

  cmdline = {
    keymap = {
      preset = "cmdline",

      ["<CR>"] = { "accept", "fallback" },
      ["<Esc>"] = { "fallback" },
    },
    completion = {
      list = {
        selection = {
          preselect = false,
          auto_insert = false,
        },
      },
      menu = {
        auto_show = true,
        draw = {
          columns = {
            { "kind_icon", "label", "label_description", gap = 1 },
          },
        },
      },
    },
  },

  -- Default list of enabled providers defined so that you can extend it
  -- elsewhere in your config, without redefining it, due to `opts_extend`
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
  },

  -- Blink.cmp uses a Rust fuzzy matcher by default for typo resistance and significantly better performance
  -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
  -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
  --
  -- See the fuzzy documentation for more information
  fuzzy = { implementation = "prefer_rust" },
}

return {
  "saghen/blink.cmp",
  -- optional: provides snippets for the snippet source
  -- `luasnip` not needed for me I guess
  -- specifications: https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#snippet_syntax
  dependencies = { "rafamadriz/friendly-snippets" },

  -- use a release tag to download pre-built binaries
  version = "*",

  opts = options,
  opts_extend = { "sources.default" },
}
