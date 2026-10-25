local options = {
  formatters_by_ft = {
    c = { "clang-format" },
    cpp = { "clang-format" },
    dart = { "dart_format" },
    fish = { "fish_indent" },
    java = { "clang-format" },
    lua = { "stylua" },
    markdown = { "deno_fmt" },
    nim = { "nimpretty" },
    ocaml = { "ocamlformat" },
    python = { "ruff_format" },
    sql = { "pg_format" },
    toml = { "taplo" },
    yaml = { "deno_fmt" },

    -- web
    css = { "oxfmt", "deno_fmt", stop_after_first = true },
    html = { "oxfmt", "deno_fmt", stop_after_first = true },
    javascript = { "oxfmt", "deno_fmt", stop_after_first = true },
    javascriptreact = { "oxfmt", "deno_fmt", stop_after_first = true },
    json = { "oxfmt", "deno_fmt", stop_after_first = true },
    jsonc = { "oxfmt", "deno_fmt", stop_after_first = true },
    scss = { "oxfmt", "deno_fmt", stop_after_first = true },
    svelte = { "deno_fmt" },
    typescript = { "oxfmt", "deno_fmt", stop_after_first = true },
    typescriptreact = { "oxfmt", "deno_fmt", stop_after_first = true },
    vue = { "oxfmt" },
  },
  formatters = {
    ["clang-format"] = {
      prepend_args = {
        "--style={AlwaysBreakAfterReturnType: All, AllowShortFunctionsOnASingleLine: None}",
      },
    },
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
