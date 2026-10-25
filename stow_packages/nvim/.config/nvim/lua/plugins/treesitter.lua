return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  -- event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  build = ":TSUpdate",
  init = function()
    local ensure_installed = {
      "bash",
      "c",
      "c3",
      "cpp",
      "cmake",
      "css",
      "csv",
      "desktop",
      "dart",
      "editorconfig",
      "fish",
      "git_config",
      "gitcommit",
      "gitignore",
      "go",
      "html",
      "hyprlang",
      "ini",
      "javascript",
      "json",
      "kdl",
      "kotlin",
      -- "jsonc",
      "latex",
      "lua",
      "make",
      "markdown",
      "markdown_inline",
      "nim",
      "python",
      "qmljs",
      "query",
      "r",
      "racket",
      "rust",
      "scss",
      "sql",
      "svelte",
      "swift",
      "toml",
      "tsx",
      "typescript",
      "vim",
      "vimdoc",
      "xml",
      "yaml",
    }

    vim.api.nvim_create_autocmd("FileType", {
      pattern = ensure_installed,
      callback = function()
        -- highlighting
        vim.treesitter.start()
        -- folds
        vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
        vim.wo.foldmethod = "expr"
        -- indentation
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })

    local already_installed = require("nvim-treesitter.config").get_installed()
    local parsers_to_install = vim
      .iter(ensure_installed)
      :filter(
        function(parser) return not vim.tbl_contains(already_installed, parser) end
      )
      :totable()

    require("nvim-treesitter").install(parsers_to_install)
  end,
}
