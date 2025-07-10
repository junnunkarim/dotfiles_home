return {
  {
    "<leader>b",
    function() Snacks.picker.buffers() end,
    desc = "Open buffer picker",
  },
  {
    "<leader>B",
    function() Snacks.picker.grep_buffers() end,
    desc = "Search in buffers (grep)",
  },
  {
    "<leader>h",
    function() Snacks.picker.help() end,
    desc = "Help pages",
  },
  {
    "<leader>N",
    function() Snacks.notifier.show_history() end,
    desc = "Notification history",
  },
  {
    "<leader>uk",
    function() Snacks.picker.keymaps() end,
    desc = "Show all keymaps",
  },
  {
    "<leader>up",
    function() Snacks.picker.pickers() end,
    desc = "Show all pickers",
  },
  {
    "<leader>uu",
    function() Snacks.picker.undo() end,
    desc = "Undo history",
  },

  -- git
  {
    "<leader>gd",
    function() Snacks.picker.git_diff() end,
    desc = "Show git diff of changed files",
  },
  {
    "<leader>gc",
    function() Snacks.picker.git_branches() end,
    desc = "Show git branches",
  },
  {
    "<leader>gl",
    function() Snacks.picker.git_log() end,
    desc = "Show git logs",
  },
  {
    "<leader>gs",
    function()
      Snacks.picker.git_status({
        win = {
          input = {
            keys = {
              ["<S-Tab>"] = { "list_up", mode = { "i", "n" } },
              ["<Tab>"] = { "list_down", mode = { "i", "n" } },
            },
          },
        },
      })
    end,
    desc = "Show git status of changed files",
  },

  -- project related
  {
    "<leader>f",
    function() Snacks.picker.files({ ignored = false, hidden = true }) end,
    desc = "Open file picker",
  },
  {
    "<leader>F",
    function()
      local buffer_dir = vim.fn.expand("%:p:h")

      if vim.fn.isdirectory(buffer_dir) == 1 then
        Snacks.picker.files({ cwd = buffer_dir, ignored = false, hidden = true })
      else
        Snacks.picker.files({ ignored = false, hidden = true })
        vim.notify(
          "[ERROR] This is not a file buffer.\nOpening file picker in current working directory.",
          vim.log.levels.WARN
        )
      end
    end,
    desc = "Open file picker at current buf dir",
  },
  {
    "<leader>/",
    function() Snacks.picker.grep() end,
    desc = "Search in workspace (grep)",
  },
  {
    "<leader>j",
    function() Snacks.picker.jumps() end,
    desc = "Open jump list",
  },
  {
    "<leader>z",
    function() Snacks.picker.zoxide() end,
    desc = "Open projects (zoxide)",
  },

  -- lsp related
  {
    "<leader>dd",
    function() Snacks.picker.diagnostics_buffer() end,
    desc = "Open diagnostics picker",
  },
  {
    "<leader>dw",
    function() Snacks.picker.diagnostics() end,
    desc = "Open diagnostics picker (workspace)",
  },
  {
    "<leader>l",
    function() Snacks.picker.lsp_symbols() end,
    desc = "Open symbols picker",
  },
  {
    "<leader>L",
    function() Snacks.picker.lsp_workspace_symbols() end,
    desc = "Open symbols picker (workspace)",
  },

  -- ui related
  {
    "<leader>wc",
    function() Snacks.picker.colorschemes() end,
    desc = "Open colorschemes picker",
  },
  {
    "<leader>wz",
    function() Snacks.zen() end,
    desc = "Toggle zen mode",
  },

  -- misc
  {
    "<leader>mn",
    function() Snacks.notifier.hide() end,
    desc = "Hide notifications",
  },

  -- others
  {
    "]]",
    function() Snacks.words.jump(vim.v.count1) end,
    desc = "Next reference",
    mode = { "n", "t" },
  },
  {
    "[[",
    function() Snacks.words.jump(-vim.v.count1) end,
    desc = "Prev reference",
    mode = { "n", "t" },
  },
}
