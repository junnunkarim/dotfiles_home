local keymaps = require("plugins.snacks.keymaps")

local bigfile = require("plugins.snacks.bigfile")
local dashboard = require("plugins.snacks.dashboard")
local explorer = require("plugins.snacks.explorer")
local git = require("plugins.snacks.git")
local image = require("plugins.snacks.image")
local indent = require("plugins.snacks.indent")
local input = require("plugins.snacks.input")
local notifier = require("plugins.snacks.notifier")
local picker = require("plugins.snacks.picker")
local quickfile = require("plugins.snacks.quickfile")
local scroll = require("plugins.snacks.scroll")
-- local statuscolumn = require("plugins.snacks.statuscolumn")
local terminal = require("plugins.snacks.terminal")

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = bigfile,
    dashboard = dashboard,
    explorer = explorer,
    git = git,
    image = image,
    indent = indent,
    input = input,
    picker = picker,
    notifier = notifier,
    quickfile = quickfile,
    scroll = scroll,
    -- statuscolumn = statuscolumn,
    terimnal = terminal,
  },
  keys = keymaps,
}
