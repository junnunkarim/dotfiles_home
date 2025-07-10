-- create autocommand
local create_autocmd = vim.api.nvim_create_autocmd

-- QoL
-- ----------------------------------------------------------------------------

-- save cursor position of a file
create_autocmd("BufReadPost", {
  pattern = "*",
  command = 'silent! normal! g`"zv',
  desc = "Open file at the last position it was edited earlier",
})

-- suppress exit code when closing terminal (if terminal outputs non-zero code)
vim.api.nvim_create_autocmd("TermClose", {
  callback = function() vim.api.nvim_input("<CR>") end,
})

-- LSP
-- ----------------------------------------------------------------------------

-- show basic LSP progress
create_autocmd("LspProgress", {
  callback = function(ev)
    local spinner =
      { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }

    vim.notify(vim.lsp.status(), "info", {
      id = "lsp_progress",
      title = "LSP Progress",
      opts = function(notif)
        notif.icon = ev.data.params.value.kind == "end" and " "
          or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
      end,
    })
  end,
})
