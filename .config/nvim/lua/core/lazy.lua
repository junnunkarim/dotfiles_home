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

local helper = require("core.helper")

local plugins = {
  --{{ lsp and debug
  --
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig",

  "p00f/clangd_extensions.nvim",
  --
  --}}

  --{{ formatter and linter
  --
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
  },
  --
  --}}

  --{{ utility
  --
  -- {
  --   "kristijanhusak/vim-dadbod-ui",
  --   dependencies = {
  --     { "tpope/vim-dadbod",                     lazy = true },
  --     { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
  --   },
  --   cmd = {
  --     "DBUI",
  --     "DBUIToggle",
  --     "DBUIAddConnection",
  --     "DBUIFindBuffer",
  --   },
  --   init = function()
  --     -- Your DBUI configuration
  --     vim.g.db_ui_use_nerd_fonts = 1
  --   end,
  -- },
  -- { "Vigemus/iron.nvim" },
  {
    "quarto-dev/quarto-nvim",
    dev = false,
    dependencies = {
      {
        "jmbuhr/otter.nvim",
        dev = false,
        dependencies = {
          "hrsh7th/nvim-cmp",
          "neovim/nvim-lspconfig",
          "nvim-treesitter/nvim-treesitter",
        },
      },
    },
  },
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
      "FelipeLema/cmp-async-path", -- same as path, but directories are read in a separate thread to avoid
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-calc",
      "hrsh7th/cmp-cmdline",
      --"hrsh7th/cmp-emoji",
      --"petertriho/cmp-git",
      "kdheepak/cmp-latex-symbols",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-nvim-lua",
      "jmbuhr/cmp-pandoc-references",
      "f3fora/cmp-spell",
      "ray-x/cmp-treesitter",
    },
  },
  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "nvim-treesitter/nvim-treesitter-context",
    },
    build = ":TSUpdate",
  },

  {
    "ellisonleao/glow.nvim",
  },
  --"AckslD/nvim-neoclip.lua",

  "akinsho/toggleterm.nvim",

  {
    "numToStr/Comment.nvim",
    lazy = false,
  },

  -- telescope
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.3",
    dependencies = {
      "nvim-lua/plenary.nvim",
      --"nvim-telescope/telescope-ui-select.nvim",
    },
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
    },
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
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    -- install jsregexp (optional!).
    build = "make install_jsregexp",
  },
  --
  --}}

  --{{ aesthetic and functional
  --
  -- "jbyuki/nabla.nvim",
  "rcarriga/nvim-notify",
  "stevearc/dressing.nvim",
  {
    "s1n7ax/nvim-window-picker",
    name = "window-picker",
    event = "VeryLazy",
    version = "2.*",
    config = function()
      require("window-picker").setup()
    end,
  },
  { -- statusline
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      lazy = true,
    },
  },
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
  "goolord/alpha-nvim",        -- dashboard
  "NvChad/nvim-colorizer.lua", -- highlights colors
  "ziontee113/color-picker.nvim",
  "karb94/neoscroll.nvim",     -- smooth scroll
  --
  --}}

  --{{ Colorschemes
  --
  { "RRethy/nvim-base16" },
  { "nyoom-engineering/oxocarbon.nvim" },
  {
    "Everblush/nvim",
    name = "everblush",
  },
  --
  --}}
}

local options = {}

require("lazy").setup(plugins, options)

--{{ keymaps
--
helper.set_keymap("n", "<leader>sl", "<cmd>Lazy<cr>", { noremap = true, silent = true, desc = "Open Lazy" })
--
--}}
