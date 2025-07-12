local options = {
  formatters_by_ft = {
    c = { "clang-format" },
    cpp = { "clang-format" },
    css = { "biome", "deno_fmt", stop_after_first = true },
    html = { "biome", "deno_fmt", stop_after_first = true },
    graphql = { "biome" },
    java = { "clang-format" },
    javascript = { "biome", "deno_fmt", stop_after_first = true },
    javascriptreact = { "biome", "deno_fmt", stop_after_first = true },
    json = { "biome", "deno_fmt", stop_after_first = true },
    jsonc = { "biome", "deno_fmt", stop_after_first = true },
    lua = { "stylua" },
    markdown = { "deno_fmt" },
    python = { "ruff_format" },
    scss = { "deno_fmt" },
    toml = { "taplo" },
    typescript = { "biome", "deno_fmt", stop_after_first = true },
    typescriptreact = { "biome", "deno_fmt", stop_after_first = true },
    svelte = { "deno_fmt" },
    sql = { "pg_format" },
    vue = { "biome" },
    yaml = { "deno_fmt" },
  },
  default_format_opts = {
    lsp_format = "fallback",
  },
  -- disable format on save
  format_on_save = nil,
  log_level = nil,
}

local keys = {
  -- use keymap to format buffer
  {
    "<leader>=",
    mode = { "n" },
    function()
      if vim.bo.buftype == "" then
        local status = require("conform").format({
          timeout_ms = 1000,
          lsp_format = "fallback",
        })
        if status then
          vim.notify("[INFO] Formatted current buffer.", vim.log.levels.INFO)
        else
          vim.notify(
            "[ERROR] Failed to format current buffer.",
            vim.log.levels.ERROR
          )
        end
      else
        vim.notify(
          "[ERROR] This is not a file buffer. Formatting skipped.",
          vim.log.levels.ERROR
        )
      end
    end,
    desc = "Format buffer (conform)",
  },
  {
    "<leader>ef",
    mode = { "n" },
    "<cmd>ConformInfo<cr>",
    desc = "Show formatter information (conform)",
  },
}

return {
  "stevearc/conform.nvim",
  opts = options,
  lazy = true,
  keys = keys,
  cmd = "ConformInfo",
}
