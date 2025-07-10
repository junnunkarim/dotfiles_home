local sources = require("plugins.snacks.pickers")
local layouts = require("plugins.snacks.config.layouts")

  -- default layout
local default_layout = {
  preset = "custom_dropdown",
}

local win = {
  -- input window
  input = {
    -- when there is input field in the picker
    keys = {
      ["<S-Tab>"] = { "list_up", mode = { "i", "n" } },
      ["<Tab>"] = { "list_down", mode = { "i", "n" } },

      ["<a-p>"] = { "preview_scroll_up", mode = { "i", "n" } },
      ["<a-n>"] = { "preview_scroll_down", mode = { "i", "n" } },
      ["<c-p>"] = { "preview_scroll_up", mode = { "i", "n" } },
      ["<c-n>"] = { "preview_scroll_down", mode = { "i", "n" } },

      ["s"] = { "edit_vsplit", mode = { "n" } },
      ["S"] = { "edit_split", mode = { "n" } },

      ["t"] = { { "tab", "tcd" }, mode = { "n" } },

      ["<S-CR>"] = { { "pick_win", "jump" }, mode = { "n", "i" } },
    },
  },
  -- output/result list window
  list = {
    -- when there is no input field in the picker
    keys = {
      ["<S-Tab>"] = { "list_up", mode = { "n", "x" } },
      ["<Tab>"] = { "list_down", mode = { "n", "x" } },

      ["<a-p>"] = "preview_scroll_up",
      ["<a-n>"] = "preview_scroll_down",
      ["<c-p>"] = "preview_scroll_up",
      ["<c-n>"] = "preview_scroll_down",

      ["s"] = "edit_vsplit",
      ["S"] = "edit_split",

      ["t"] = { { "tab", "tcd" } },

      ["-"] = { { "pick_win", "jump" } },
    },
  },
}

return {
  enabled = true,
  prompt = "  ",
  -- ui_select = false,
  -- default layout
  layout = default_layout,
  -- all layouts available
  layouts = layouts,
  sources = sources,
  win = win,
}
