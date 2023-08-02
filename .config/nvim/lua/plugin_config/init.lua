--{{{ LSP
require("plugin_config.mason")
require("plugin_config.mason-lspconfig")
require("plugin_config.lsp-colors")
--require("plugin_config.lspsaga")
--require("plugin_config.lsp")

-- autocomplete
require("plugin_config.nvim-cmp")
require("plugin_config.nvim-cmp-lsp")

require("plugin_config.clangd_extensions")
require("plugin_config.rust-tools")
--require("plugin_config.jdtls")

require("plugin_config.diagnostics")

--require("plugin_config.trouble")
--}}}


--{{{ Functional
require("plugin_config.glow")
require("plugin_config.autopairs")
--require("plugin_config.undotree")

-- Telescope
require("plugin_config.telescope")

-- Treesitter
require("plugin_config.treesitter")
require("plugin_config.treesitter-context")
--}}}


--{{{ Functional and Aesthetics
require("plugin_config.toggleterm")
require("plugin_config.lualine")
require("plugin_config.alpha")
require("plugin_config.colorizer")
--require("plugin_config.colortils")
require("plugin_config.color-picker")
require("plugin_config.nvimtree")
--require("plugin_config.neotree")
require("plugin_config.gitsigns")
require("plugin_config.which-key")
require("plugin_config.indent-blankline")
--}}}

--{{{ Aesthetics
--require("plugin_config.noice")
require("plugin_config.neoscroll")
require("plugin_config.nvim-web-devicons")
