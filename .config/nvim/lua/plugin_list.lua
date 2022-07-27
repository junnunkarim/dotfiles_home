local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugin_list.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end


-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float({border = border}) -- never change this s**t unless you know what you are doing. It took me hours to fix this
    end,
  },
}

-- Install your plugins here
return require('packer').startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  use "windwp/nvim-autopairs" -- Autopairs, integrates with both cmp and treesitter
  use "numToStr/Comment.nvim" -- Easily comment stuff
  use "kyazdani42/nvim-web-devicons"
  --use "kyazdani42/nvim-tree.lua"
  --use "akinsho/bufferline.nvim"
  --use "moll/vim-bbye"
  use "nvim-lualine/lualine.nvim" -- infobar
  --use "akinsho/toggleterm.nvim"
  --use "ahmedkhalf/project.nvim"
  --use "lewis6991/impatient.nvim" -- Speed up loading Lua modules to improve startup time
  --use "lukas-reineke/indent-blankline.nvim"
  use "goolord/alpha-nvim" -- A greeter/dashboard
  use "antoinemadec/FixCursorHold.nvim" -- This is needed to fix lsp doc highlight
  use "folke/which-key.nvim" -- Shows possible keybindings
  use {
    "ellisonleao/glow.nvim",
    branch = 'main',
  } -- Enable markdown preview using glow (cli)

  -- Colorschemes
  -- use "lunarvim/colorschemes" -- A bunch of colorschemes you can try out
  use "lunarvim/darkplus.nvim"
	use "rebelot/kanagawa.nvim"
	use "shaunsingh/nord.nvim"
	use "ellisonleao/gruvbox.nvim"
  use "Mofiqul/dracula.nvim"
  use "folke/tokyonight.nvim"
  use({ "catppuccin/nvim", as = "catppuccin" })

  -- cmp plugins
  use "hrsh7th/nvim-cmp" -- The completion plugin
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp"

  -- snippets
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- LSP
  use "neovim/nvim-lspconfig" -- enable LSP
  use "williamboman/nvim-lsp-installer" -- simple to use language server installer
  use "tamago324/nlsp-settings.nvim" -- language server settings defined in json for
  use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters

  -- Telescope
  use "nvim-telescope/telescope.nvim"

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }
  use "JoosepAlviste/nvim-ts-context-commentstring"

  -- nvim-lastplace
  use "ethanholz/nvim-lastplace" -- save cursor position

  -- mkdir
  use {'jghauser/mkdir.nvim'}

  -- Git
  --use "lewis6991/gitsigns.nvim"

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require("packer").sync()
  end
end)
