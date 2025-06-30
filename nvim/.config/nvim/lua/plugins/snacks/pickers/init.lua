local sources = {
  buffers = require("plugins.snacks.pickers.buffers"),
  colorschemes = require("plugins.snacks.pickers.colorschemes"),
  diagnostics = require("plugins.snacks.pickers.diagnostics"),
  diagnostics_buffer = require("plugins.snacks.pickers.diagnostics_buffer"),
  explorer = require("plugins.snacks.pickers.explorer"),
  files = require("plugins.snacks.pickers.files"),
  git_diff = require("plugins.snacks.pickers.git_diff"),
  grep = require("plugins.snacks.pickers.grep"),
  help = require("plugins.snacks.pickers.help"),
  lsp_symbols = require("plugins.snacks.pickers.lsp_symbols"),
  lsp_workspace_symbols = require("plugins.snacks.pickers.lsp_workspace_symbols"),
  pickers = require("plugins.snacks.pickers.pickers"),
  undo = require("plugins.snacks.pickers.undo"),
}

return sources
