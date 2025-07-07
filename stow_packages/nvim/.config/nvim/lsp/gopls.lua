return {
  cmd = { "gopls" },
  filetypes = { "go", "gotempl", "gowork", "gomod" },
  root_markers = { ".git", "go.mod", "go.work", vim.uv.cwd() },
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
      },
      ["ui.inlayhint.hints"] = {
        compositeLiteralFields = true,
        constantValues = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
    },
  },
}
