local available, lsp_colors = pcall(require, "lsp-colors")
if not available then
  return
end

local options = {
  Error = "#db4b4b",
  Warning = "#e0af68",
  Information = "#0db9d7",
  Hint = "#10B981"
}

lsp_colors.setup(options)
