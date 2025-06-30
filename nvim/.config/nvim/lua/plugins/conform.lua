local options = {
  formatters_by_ft = {
    -- c = { "clang-format" },
    -- cpp = { "clang-format" },
    -- css = { "biome" },
    -- html = { "biome" },
    java = { "clang-format" },
    -- javascript = { "biome" },
    -- javascriptreact = { "biome" },
    -- json = { "biome" },
    lua = { "stylua" },
    -- markdown = { "deno_fmt" },
    -- php = { "pretty-php" },
    -- php = { "php-cs-fixer" },
    python = { "ruff_format" },
    -- scss = { "deno_fmt" },
    toml = { "taplo" },
    -- typescript = { "biome" },
    -- typescriptreact = { "biome" },
    svelte = { "deno_fmt" },
    yaml = { "deno_fmt" },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_format = "fallback",
  },
}

return {
  'stevearc/conform.nvim',
  opts = options,
  lazy = true,
  event = { "BufReadPre", "BufNewFile" },
  cmd = "ConformInfo",
}
