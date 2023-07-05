--{{{ code to kickstart lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
--}}}

local plugins = {
  --{{{ LSP
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig",
  "folke/lsp-colors.nvim",
  --"glepnir/lspsaga.nvim",

  -- autocomplete
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/nvim-cmp",

  --{ "mfussenegger/nvim-jdtls" }
  --{ "ranjithshegde/ccls.nvim", }
  "p00f/clangd_extensions.nvim",
  "simrat39/rust-tools.nvim",

  --[[
  {
    "folke/trouble.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
  },
  ]]--
  --}}}

  --{{{ Functional
  "nvim-lua/plenary.nvim",
  "ellisonleao/glow.nvim",
  "windwp/nvim-autopairs",
  --"lewis6991/impatient.nvim",
  --"mbbill/undotree",

  -- Debugging
  --"mfussenegger/nvim-dap",

  -- Snippet
  "L3MON4D3/LuaSnip",
  "saadparwaiz1/cmp_luasnip",
  "rafamadriz/friendly-snippets",

  -- telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
  },

  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ':TSUpdate',
  },
  --"nvim-treesitter/nvim-treesitter-context",

  -- knowledge organization system
  {
    "nvim-neorg/neorg",
    --build = ":Neorg sync-parsers",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  --}}}

  --{{{ Functional and Aesthetics
  "akinsho/toggleterm.nvim",
  --"NvChad/nvterm",

  -- statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      lazy = true,
    }
  },

  "goolord/alpha-nvim", -- dashboard
  --"glepnir/dashboard-nvim",

  --"max397574/colortils.nvim",
  "NvChad/nvim-colorizer.lua", -- highlights colors
  "ziontee113/color-picker.nvim",

  -- file manager
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons", -- optional, for file icons
    },
  },
  --[[
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- optional
      "MunifTanjim/nui.nvim",
    },
  },
  --]]

  "lewis6991/gitsigns.nvim",
  "folke/which-key.nvim", -- shows keyboard shortcuts
  "lukas-reineke/indent-blankline.nvim",
  --}}}


  --{{{ Aesthetics
  "nvim-tree/nvim-web-devicons", -- nerdfont icons
  --"onsails/lspkind.nvim", -- vscode-like pictograms
  --"karb94/neoscroll.nvim", -- smooth scroll

  -- notification ui
  --[[
  {
    "folke/noice.nvim",
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to the notification view.
      --   If not available, we `mini` as the fallback
      "rcarriga/nvim-notify",
    }
  },
  --]]
  --}}}

  --{{{ Colorschemes
  "ellisonleao/gruvbox.nvim",
  "luisiacc/gruvbox-baby",

  {
    "rose-pine/neovim",
    name = 'rose-pine',
  },

  "shaunsingh/nord.nvim",
  "rebelot/kanagawa.nvim",

  {
    "catppuccin/nvim",
    name = "catppuccin"
  },

  "folke/tokyonight.nvim",
  "nyoom-engineering/oxocarbon.nvim",
  "savq/melange",

  {
    "Everblush/everblush.nvim",
    name = "everblush"
  },

  "olivercederborg/poimandres.nvim",
  "EdenEast/nightfox.nvim",
  --}}}
}

local lazy_options = {}

require("lazy").setup(plugins, lazy_options)
