local options = {
  formatters_by_ft = {
    -- c = { "clang-format" },
    -- cpp = { "clang-format" },
    -- css = { "biome" },
    -- html = { "biome" },
    -- java = { "clang-format" },
    -- javascript = { "biome" },
    -- javascriptreact = { "biome" },
    -- json = { "biome" },
    lua = { "stylua" },
    -- markdown = { "deno_fmt" },
    -- php = { "pretty-php" },
    -- php = { "php-cs-fixer" },
    python = { "ruff_format" },
    -- scss = { "deno_fmt" },
    -- toml = { "taplo" },
    -- typescript = { "biome" },
    -- typescriptreact = { "biome" },
    -- svelte = { "deno_fmt" },
    -- yaml = { "deno_fmt" },
  },
  -- format_on_save = {
  --   timeout_ms = 500,
  --   lsp_format = "fallback",
  -- },
  -- disable format on save
  format_on_save = nil,
}

local keys = {
  -- use keymap to format buffer
  {
    "<leader>=",
    mode = { "n" },
    function()
      if vim.bo.buftype == "" then
        require("conform").format({ timeout_ms = 1000, lsp_format = "fallback" })
        vim.notify("[INFO] Formatted current buffer.", vim.log.levels.INFO)
      else
        vim.notify(
          "[ERROR] This is not a file buffer. Formatting skipped.",
          vim.log.levels.WARN
        )
      end
    end,
    desc = "Format buffer (conform)",
  },
}

return {
  "stevearc/conform.nvim",
  opts = options,
  lazy = true,
  keys = keys,
  event = { "BufReadPre", "BufNewFile" },
  cmd = "ConformInfo",
}
