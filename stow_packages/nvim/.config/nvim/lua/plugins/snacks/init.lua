local keymaps = require("plugins.snacks.config.keymaps")

local bigfile = require("plugins.snacks.bigfile")
local dashboard = require("plugins.snacks.dashboard")
local image = require("plugins.snacks.image")
local indent = require("plugins.snacks.indent")
local input = require("plugins.snacks.input")
local notifier = require("plugins.snacks.notifier")
local picker = require("plugins.snacks.picker")
local quickfile = require("plugins.snacks.quickfile")
local scroll = require("plugins.snacks.scroll")
local zen = require("plugins.snacks.zen")

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = bigfile,
    dashboard = dashboard,
    image = image,
    indent = indent,
    input = input,
    picker = picker,
    notifier = notifier,
    quickfile = quickfile,
    scroll = scroll,
    zen = zen,
  },
  keys = keymaps,
}
