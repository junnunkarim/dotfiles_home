local function trunc(length)
  return function(str)
    return string.sub(str, 1, length)
  end
end

local options = {
  options = {
    icons_enabled = true,
    theme = "auto",
    section_separators = { left = "", right = "" },
    component_separators = { left = "", right = "" },
    disabled_filetypes = {
      statusline = {
        -- "neo-tree",
        -- "nvim-tree",
        -- "snacks_dashboard",
        "snacks_layout_box",
      },
      winbar = {
        -- "neo-tree",
        -- "nvim-tree",
        "snacks_dashboard",
        "snacks_layout_box",
      },
    },
    -- always_divide_middle = true,
    globalstatus = true,
    -- refresh = {
    --   tabline = 100,
    --   winbar = 200,
    --   statusline = 200,
    -- },
  },
  ----------------------------------------------------
  winbar = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {
      {
        "diagnostics",
        separator = { left = "", right = "" },
        sources = { "nvim_lsp" },
        sections = { "error", "warn", "info", "hint" },
        symbols = {
          error = " ",
          warn = " ",
          info = "󰋼 ",
          hint = "󰌵 ",
        },
        colored = true,
        diagnostics_color = {
          error = "DiagnosticError",
          warn = "DiagnosticWarn",
          info = "DiagnosticInfo",
          hint = "DiagnosticHint",
        },
        update_in_insert = true,
      },
    },
    lualine_d = {},
    lualine_x = {},
    lualine_y = {
      {
        "diff",
        separator = { left = "", right = "" },
      },
    },
    lualine_z = {
      {
        "filename",
        -- 4: filename and parent dir, with tilde as the home directory
        path = 4,
        separator = { left = "", right = "" },
        file_status = true,
        symbols = {
          modified = "[]",
          readonly = "[]",
          unnamed = "[no_name]",
          newfile = "[new]",
        },
      },
    },
  },
  ----------------------------------------------------
  inactive_winbar = {
    lualine_a = {
      {
        "diagnostics",
        separator = { left = "", right = "" },
        sources = { "nvim_lsp" },
        sections = { "error", "warn", "info", "hint" },
        symbols = {
          error = " ",
          warn = " ",
          info = "󰋼 ",
          hint = "󰌵 ",
        },
        colored = true,
        diagnostics_color = {
          error = "DiagnosticError",
          warn = "DiagnosticWarn",
          info = "DiagnosticInfo",
          hint = "DiagnosticHint",
        },
        update_in_insert = true,
      },
    },
    lualine_b = {},
    lualine_c = {},
    lualine_d = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {
      {
        "filename",
        -- 4: filename and parent dir, with tilde as the home directory
        path = 4,
        separator = { left = "", right = "" },
        file_status = true,
        symbols = {
          modified = "[]",
          readonly = "[]",
          unnamed = "[no_name]",
          newfile = "[new]",
        },
      },
    },
  },
  ----------------------------------------------------
  sections = {
    lualine_a = {
      {
        "mode",
        separator = { left = "", right = "" },
        fmt = trunc(1),
        padding = 2,
      },
    },
    lualine_b = {
      {
        "branch",
        separator = { left = "", right = "" },
      },
    },
    lualine_c = {
      {
        "buffers",
        separator = { left = "", right = "" },
        icons_enabled = false,
        mode = 0,
        show_modified_status = true,
        symbols = {
          -- text to show when the buffer is modified
          modified = " []",
          -- text to show to identify the alternate file
          alternate_file = "",
          -- text to show when the buffer is a directory
          directory = "",
        },
      },
    },
    lualine_d = {},
    lualine_x = {
      { "searchcount" },
    },
    lualine_y = {
      { "location", separator = { left = "", right = "" } },
    },
    lualine_z = {
      {
        "tabs",
        separator = { left = "", right = "" },
        padding = 2,
        use_mode_colors = true,
        symbols = {
          modified = " []", -- Text to show when the file is modified.
        },
      },
    },
  },
  ----------------------------------------------------
  inactive_sections = {},
  tabline = {},
  ----------------------------------------------------
  extensions = {
    "lazy",
    "man",
    "mason",
    -- "neo-tree",
    "toggleterm",
    "quickfix",
  },
}

return { -- statusline
  "nvim-lualine/lualine.nvim",
  -- priority = 1000,
  -- lazy = false,
  opts = options,
}
