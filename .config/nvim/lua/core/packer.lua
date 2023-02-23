-- use {in manager

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost packer.lua source <afile> | PackerSync
  augroup end
]])

return require('packer').startup(
  function(use)
    -- Packer can manage itself
    use {"wbthomason/packer.nvim"}

    -- cmp
    use { 'hrsh7th/cmp-nvim-lsp' }
    use { 'hrsh7th/cmp-buffer' }
    use { 'hrsh7th/cmp-path' }
    use { 'hrsh7th/cmp-cmdline' }
    use { 'hrsh7th/nvim-cmp' }
    --use { "onsails/lspkind.nvim"}

    -- LSP
    use {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    }
    use { "neovim/nvim-lspconfig" }
    use { "folke/lsp-colors.nvim" }
    use { "glepnir/lspsaga.nvim", }

    --use { "mfussenegger/nvim-jdtls" }
    --use { "ranjithshegde/ccls.nvim", }
    use { "p00f/clangd_extensions.nvim" }
    use 'simrat39/rust-tools.nvim'
    use { "folke/trouble.nvim", requires = "nvim-tree/nvim-web-devicons", }

    -- Debugging
    use 'mfussenegger/nvim-dap'

    -- snippet
    use { "L3MON4D3/LuaSnip", }
    use { "saadparwaiz1/cmp_luasnip", }
    use "rafamadriz/friendly-snippets"

    use "nvim-lua/plenary.nvim"

    -- telescope
    use {
      "nvim-telescope/telescope.nvim", tag = '0.1.0',
      requires = { {'nvim-lua/plenary.nvim'} }
    }

    -- treesitter
    use {
      "nvim-treesitter/nvim-treesitter",
      run = ':TSUpdate'
    }
    use {"nvim-treesitter/nvim-treesitter-context"}

    use { "karb94/neoscroll.nvim" }

    use {"mbbill/undotree"}

    use {
      "nvim-lualine/lualine.nvim",
      requires = { "kyazdani42/nvim-web-devicons", opt = true }
    }

    use {"ellisonleao/glow.nvim"}

    use {'lewis6991/gitsigns.nvim'}

    use { "folke/which-key.nvim", }

    use { "lukas-reineke/indent-blankline.nvim" }

    use { "lewis6991/impatient.nvim" }

    use { "windwp/nvim-autopairs" }

    use { "NvChad/nvim-colorizer.lua" }
    --use { "max397574/colortils.nvim" }
    use { "ziontee113/color-picker.nvim" }

    --use { "glepnir/dashboard-nvim" }
    use { "goolord/alpha-nvim" }

    use {
      'nvim-tree/nvim-tree.lua',
      requires = {
        'nvim-tree/nvim-web-devicons', -- optional, for file icons
      },
      tag = 'nightly' -- optional, updated every week. (see issue #1193)
    }

    use {"akinsho/toggleterm.nvim", tag = '*', }
    --use { "NvChad/nvterm", }

    use {
      "nvim-neorg/neorg",
      -- tag = "*",
      ft = "norg",
      after = "nvim-treesitter", -- You may want to specify Telescope here as well
    }

    -- Aesthetics
    use { "nvim-tree/nvim-web-devicons" }

    use({
      "folke/noice.nvim",
      requires = {
        -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
        "MunifTanjim/nui.nvim",
        -- OPTIONAL:
        --   `nvim-notify` is only needed, if you want to use the notification view.
        --   If not available, we use `mini` as the fallback
        "rcarriga/nvim-notify",
        }
    })

    -- Colorschemes
    use { "ellisonleao/gruvbox.nvim" }
    use { "rose-pine/neovim", as = 'rose-pine', }
    use { "shaunsingh/nord.nvim" }
    use { "rebelot/kanagawa.nvim" }
    use { "catppuccin/nvim", as = "catppuccin" }
    use { "folke/tokyonight.nvim" }
    use { 'nyoom-engineering/oxocarbon.nvim' }
    use { "savq/melange" }
    use { 'Everblush/everblush.nvim', as = 'everblush' }
    use { "olivercederborg/poimandres.nvim" }
    use { "EdenEast/nightfox.nvim" }
  end
)
