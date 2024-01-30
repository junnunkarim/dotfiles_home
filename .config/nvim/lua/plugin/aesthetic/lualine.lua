local available, lualine = pcall(require, "lualine")
if not available then
  return
end


local options = {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {
        "neo-tree",
        "nvim-tree",
      },
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {
      { 'mode', separator = { left = '', right = '' } }
    },
    lualine_b = {
      {
        "diagnostics",
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
          warn  = "DiagnosticWarn",
          info  = "DiagnosticInfo",
          hint  = "DiagnosticHint"
        },
        update_in_insert = true
      }
    },
    lualine_c = {},
    lualine_x = {
      { 'encoding', separator = { left = '', right = '' }},
      { 'filetype', separator = { left = '', right = '' }},
    },
    lualine_y = {
      { 'progress', separator = { left = '', right = '' }}
    },
    lualine_z = {
      { 'location', separator = { left = '', right = '' } }
    },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {
    lualine_a = {
      {
        'buffers',
        --show_filename_only = true,
        separator = { left = '', right = '' },
        icons_enabled = false,
        symbols = {
          modified = ' ●',      -- Text to show when the buffer is modified
          alternate_file = '', -- Text to show to identify the alternate file
          directory =  '',     -- Text to show when the buffer is a directory
        },
      },
    },
    lualine_b = {
      {
        'branch',
        separator = { left = '', right = '' }
      },
      {
        'diff',
        separator = { left = '', right = '' }},
    },
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {
      { 'tabs', separator = { left = '', right = '' } }
    },
  },
  winbar = {},
  inactive_winbar = {},
  extensions = {
    "nvim-tree",
    "neo-tree",
    "toggleterm",
    "quickfix",
    "lazy",
  }
}

lualine.setup(options)
