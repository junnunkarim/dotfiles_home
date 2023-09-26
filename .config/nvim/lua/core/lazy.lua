--{{ bootstrap lazy
--
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
--
--}}


local plugins = {
  --{{ lsp and debug
  --
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig",

  "p00f/clangd_extensions.nvim",

  --[[
  {
    "nvimdev/lspsaga.nvim",
    config = function()
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },
  ]]--
  --
  --}}


  --{{ utility
  --
  {
    "mickael-menu/zk-nvim",
  },
  {
    "luckasRanarison/nvim-devdocs",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },
  -- autocomplete
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-calc",
      "hrsh7th/cmp-nvim-lua",
      "saadparwaiz1/cmp_luasnip",
      --"hrsh7th/cmp-path",
      "FelipeLema/cmp-async-path", -- same as path, but directories are read in a separate thread to avoid
      "kdheepak/cmp-latex-symbols",
      --"petertriho/cmp-git",
    },
  },
  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ':TSUpdate',
  },
  "nvim-treesitter/nvim-treesitter-context",

  {
    "ellisonleao/glow.nvim"
  },
  --"AckslD/nvim-neoclip.lua",

  "akinsho/toggleterm.nvim",

  {
    'numToStr/Comment.nvim',
    lazy = false,
  },

  -- telescope
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.3',
    dependencies = {
      'nvim-lua/plenary.nvim',
      --"nvim-telescope/telescope-ui-select.nvim",
    }
  },

  -- file explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      "mrbjarksen/neo-tree-diagnostics.nvim",
    }
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
  },

  {
    "ethanholz/nvim-lastplace",
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      --vim.o.timeoutlen = 300
    end,
  },

  -- snippet
  {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    dependencies = { "rafamadriz/friendly-snippets" },
    -- install jsregexp (optional!).
    build = "make install_jsregexp"
  },
  --
  --}}


  --{{ aesthetic and functional
  --
  "rcarriga/nvim-notify",
  "stevearc/dressing.nvim",
  {
    's1n7ax/nvim-window-picker',
    name = 'window-picker',
    event = 'VeryLazy',
    version = '2.*',
    config = function()
        require'window-picker'.setup()
    end,
  },
  --"simrat39/symbols-outline.nvim",
  { -- statusline
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      lazy = true,
    }
  },
  -- {
  --   "echasnovski/mini.animate",
  --   version = '*'
  -- },
  {
    "folke/zen-mode.nvim",
  },
  {
    "lewis6991/gitsigns.nvim",
    lazy = true,
  },
  {
    "sindrets/diffview.nvim",
    lazy = true,
  },

  "lukas-reineke/indent-blankline.nvim",

  --[[ {
    "folke/trouble.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons"
    },
  }, ]]

  "goolord/alpha-nvim", -- dashboard

  "NvChad/nvim-colorizer.lua", -- highlights colors
  "ziontee113/color-picker.nvim",

  "karb94/neoscroll.nvim", -- smooth scroll
  --
  --}}


  --{{ Colorschemes
  --
  --{
  --  "ellisonleao/gruvbox.nvim",
  --},
  { "RRethy/nvim-base16" },
  -- {
  --   "luisiacc/gruvbox-baby",
  -- },
  -- {
  --   "rose-pine/neovim",
  --   name = 'rose-pine',
  -- },
  -- {
  --   "shaunsingh/nord.nvim",
  -- },
  -- {
  --   "rebelot/kanagawa.nvim",
  -- },
  -- {
  --   "catppuccin/nvim",
  --   name = "catppuccin",
  -- },
  -- {
  --   "folke/tokyonight.nvim",
  -- },
  -- {
  --   "nyoom-engineering/oxocarbon.nvim",
  -- },
  -- {
  --   "savq/melange",
  -- },
  -- {
  --   "Everblush/everblush.nvim",
  --   name = "everblush",
  -- },
  -- {
  --   "olivercederborg/poimandres.nvim",
  -- },
  -- {
  --   "EdenEast/nightfox.nvim",
  -- },
  --
  --}}
}

require("lazy").setup(plugins, opts)
