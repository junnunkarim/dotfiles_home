local keymaps = {
  -- navigation related
  {
    "<leader>te",
    function()
      Snacks.explorer.open()
    end,
    desc = "File Explorer",
  },
  {
    "<leader>tr",
    function()
      local explorer_pickers = Snacks.picker.get({ source = "explorer" })

      for _, picker in pairs(explorer_pickers) do
        if picker:is_focused() then
          picker:close()
        else
          picker:focus()
        end
      end

      if #explorer_pickers == 0 then
        Snacks.picker.explorer()
      end
    end,
    desc = "File Explorer",
  },
  {
    "<leader>tb",
    function()
      Snacks.picker.buffers()
    end,
    desc = "Buffers",
  },
  {
    "<leader>th",
    function()
      Snacks.picker.help()
    end,
    desc = "Help Pages",
  },
  {
    "<leader>tn",
    function()
      Snacks.notifier.show_history()
    end,
    desc = "Notification History",
  },
  {
    "<leader>tp",
    function()
      Snacks.picker.pickers()
    end,
    desc = "All Pickers",
  },
  {
    "<leader>tu",
    function()
      Snacks.picker.undo()
    end,
    desc = "Undo History",
  },
  -- git related
  {
    "<leader>gb",
    function()
      Snacks.git.blame_line()
    end,
    desc = "Git-blame of current line",
  },
  {
    "<leader>gg",
    function()
      Snacks.picker.git_diff()
    end,
    desc = "Git-diff",
  },
  {
    "<leader>go",
    function()
      Snacks.git.blame_line()
    end,
    desc = "Open repo of active file in browser",
  },
  -- project related
  {
    "<leader>pf",
    function()
      Snacks.picker.files()
    end,
    desc = "Workspace Files",
  },
  {
    "<leader>ps",
    function()
      Snacks.picker.grep()
    end,
    desc = "Search in Project",
  },
  --- terminal
  {
    "<leader>pt",
    function()
      Snacks.terminal(nil, {
        win = {
          position = "float",
          height = 0.8,
          width = 0.8,
        },
      })
    end,
    desc = "Toggle Terminal (float)",
  },
  {
    "<a-t>",
    mode = { "n", "t" },
    function()
      Snacks.terminal(nil, {
        win = {
          position = "float",
          height = 0.8,
          width = 0.8,
        },
      })
    end,
    desc = "Toggle Terminal (float)",
  },
  -- lsp related
  {
    "<leader>la",
    function()
      Snacks.picker.diagnostics()
    end,
    desc = "Diagnostics (Workspace)",
  },
  {
    "<leader>ld",
    function()
      Snacks.picker.diagnostics_buffer()
    end,
    desc = "Diagnostics (buffer)",
  },
  {
    "<leader>ls",
    function()
      Snacks.picker.lsp_symbols()
    end,
    desc = "LSP Symbols",
  },
  {
    "<leader>lw",
    function()
      Snacks.picker.lsp_workspace_symbols()
    end,
    desc = "LSP Workspace Symbols",
  },
  -- ui related
  {
    "<leader>uc",
    function()
      Snacks.picker.colorschemes()
    end,
    desc = "Colorschemes",
  },
  {
    "<leader>uz",
    function()
      Snacks.zen()
    end,
    desc = "Zen Mode",
  },
  -- misc
  {
    "<leader>mn",
    function()
      Snacks.notifier.hide()
    end,
    desc = "Hide Notifications",
  },
  -- others
  {
    "]]",
    function()
      Snacks.words.jump(vim.v.count1)
    end,
    desc = "Next Reference",
    mode = { "n", "t" },
  },
  {
    "[[",
    function()
      Snacks.words.jump(-vim.v.count1)
    end,
    desc = "Prev Reference",
    mode = { "n", "t" },
  },
}

return keymaps
