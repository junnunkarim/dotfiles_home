-- https://cmp.saghen.dev/installation#merging-lsp-capabilities
local capabilities = {
  textDocument = {
    foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    },
  },
}

capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

vim.lsp.config("*", {
  capabilities = capabilities,
  root_markers = { ".git" },
})

vim.lsp.enable({
  "lua_ls",
  "basedpyright",
  "rust-analyzer",
  "gopls",
  "svelte",
  "ts_ls",
})

vim.diagnostic.config({
  virtual_text = true,
  virtual_lines = false,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚 ",
      [vim.diagnostic.severity.WARN] = "󰀪 ",
      [vim.diagnostic.severity.INFO] = "󰋽 ",
      [vim.diagnostic.severity.HINT] = "󰌶 ",
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "ErrorMsg",
      [vim.diagnostic.severity.WARN] = "WarningMsg",
    },
  },
})

-- keymaps
-- ----------------------------------------------------------------------------

local function jump_virtual_lines(jump_count)
  -- prevent autocmd for repeated jumps
  pcall(vim.api.nvim_del_augroup_by_name, "jump_virtual_lines")

  vim.diagnostic.jump({ count = jump_count })

  local initial_state = {
    virt_text = vim.diagnostic.config().virtual_text,
    virt_lines = vim.diagnostic.config().virtual_lines,
  }

  vim.diagnostic.config({
    virtual_text = false,
    virtual_lines = { current_line = true },
  })

  -- deferred to not trigger by jump itself
  vim.defer_fn(function()
    vim.api.nvim_create_autocmd("CursorMoved", {
      desc = "User(once): Reset diagnostics virtual lines",
      once = true,
      group = vim.api.nvim_create_augroup("jump_virtual_lines", {}),
      callback = function()
        vim.diagnostic.config({
          virtual_lines = initial_state.virt_lines,
          virtual_text = initial_state.virt_text,
        })
      end,
    })
  end, 1)
end

-- go to next diagnostic
vim.keymap.set(
  "n",
  "ge",
  function() jump_virtual_lines(1) end,
  { noremap = true, silent = true, desc = "Next diagnostic" }
)

-- go to previous diagnostic
vim.keymap.set(
  "n",
  "gE",
  function() jump_virtual_lines(-1) end,
  { noremap = true, silent = true, desc = "Prev diagnostic" }
)

-- document symbols
vim.keymap.set(
  "n",
  "gO",
  function() vim.lsp.buf.document_symbol() end,
  { noremap = true, silent = true, desc = "Open document symbols picker" }
)

-- toggle between diagnostics `virtual_lines` and `virtual_text`
vim.keymap.set(
  "n",
  "<leader>dt",
  function()
    vim.diagnostic.config({
      virtual_lines = not vim.diagnostic.config().virtual_lines,
      virtual_text = not vim.diagnostic.config().virtual_text,
    })
  end,
  {
    noremap = true,
    silent = true,
    desc = "Toggle diagnostic lines/text",
  }
)

-- vim.keymap.set(
--   "n",
--   "<leader>=",
--   function() vim.lsp.buf.format() end,
--   { noremap = true, silent = true, desc = "format with LSP" }
-- )

-- can also be used with `gra`
vim.keymap.set(
  "n",
  "<leader>a",
  "<cmd>lua vim.lsp.buf.code_action()<cr>",
  { desc = "Perform code actions" }
)

--- `K` will show hover information (function signatures, docs etc.)
-- `KK` will jump inside the floting window, press `q` to dismiss
vim.keymap.set(
  "n",
  "K",
  "<cmd>lua vim.lsp.buf.hover({ border = 'rounded' }) <cr>",
  { desc = "Show docs for item under cursor" }
)
vim.keymap.set(
  "n",
  "<leader>k",
  "<cmd>lua vim.lsp.buf.hover({ border = 'rounded' }) <cr>",
  { desc = "Show docs for item under cursor" }
)

vim.keymap.set(
  "n",
  "<leader>r",
  "<cmd>lua vim.lsp.buf.rename()<cr>",
  { desc = "Rename selected symbol" }
)

vim.keymap.set(
  "n",
  "<leader>el",
  function() vim.print(vim.lsp.get_clients()[1].server_capabilities) end,
  { desc = "Rename selected symbol" }
)
