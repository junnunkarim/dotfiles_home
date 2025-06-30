local options = {
  picker = "snacks_picker",

  lsp = {
    -- `config` is passed to `vim.lsp.start_client(config)`
    config = {
      cmd = { "zk", "lsp" },
      name = "zk",
    },

    -- automatically attach buffers in a zk notebook that match the given filetypes
    auto_attach = {
      enabled = true,
      filetypes = { "markdown" },
    },
  },
}

return {
  "zk-org/zk-nvim",
  lazy = true,
  ft = "markdown",
  config = function()
    require("zk").setup(options)
  end
}
