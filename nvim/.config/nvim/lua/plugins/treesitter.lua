local options = {
  -- A list of parser names, or "all"
  ensure_installed = {
    "bash",
    "c",
    "css",
    "html",
    "javascript",
    "latex",
    "lua",
    "markdown",
    "markdown_inline",
    "python",
    "query",
    "r",
    "rust",
    "vim",
    "vimdoc",
    "yaml",
  },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  highlight = {
    enable = true,
    -- disable = { "markdown" }, -- list of language that will be disabled
    -- additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
  },
}

return {
  "nvim-treesitter/nvim-treesitter",
  lazy = true,
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  build = ":TSUpdate",
  config = function()
    local configs = require("nvim-treesitter.configs")

    configs.setup(options)
  end
}
