-- copied from https://github.com/LunarVim/Neovim-from-scratch/blob/03-plugins/lua/user/plugins.lua
-- Automatically install packer
local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = vim.fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerSync
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
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

require('packer').startup(function ()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Programming Language Plugins
  use 'godlygeek/tabular'
  use 'mattn/emmet-vim'
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' } ; require('plugin-settings/treesitter')
  -- use 'lewis6991/spellsitter.nvim' ; require('plugin-settings/spellsitter')
  use 'RRethy/nvim-treesitter-textsubjects' ; require('plugin-settings.treesitter-text-subjects')
  use 'neovim/nvim-lspconfig' ; require('plugin-settings/nvim-lsp')
  use 'williamboman/nvim-lsp-installer' ; require('plugin-settings/lsp-installer')

  -- cmp plugins
  use 'hrsh7th/nvim-cmp' ; require('plugin-settings/nvim-cmp') -- completion plugin
  use 'hrsh7th/cmp-buffer' -- buffer completions
  use 'hrsh7th/cmp-path' -- path completions
  use 'hrsh7th/cmp-cmdline' -- cmdline completions
  use 'saadparwaiz1/cmp_luasnip' -- snippet completions
  use 'hrsh7th/cmp-nvim-lsp'

  -- snippets
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- Navigation Plugins
  use 'nvim-telescope/telescope.nvim' ; require('plugin-settings/telescope')
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use 'masukomi/vim-markdown-folding'
  use 'nvim-lua/plenary.nvim'
  use 'psliwka/vim-smoothie'
  use 'rstacruz/vim-closer'

  -- UI Colors
  use 'kyazdani42/nvim-web-devicons'
  use 'kyazdani42/nvim-tree.lua' ; require('plugin-settings/nvim-tree')
  use 'hoob3rt/lualine.nvim' ; require('plugin-settings/lualine')
  use 'nanozuki/tabby.nvim' ; require('plugin-settings/tabby')

  -- Colorschemes
  use 'morhetz/gruvbox'
  use 'Shadorain/shadotheme'
  use 'whatyouhide/vim-gotham'
  use 'sainnhe/sonokai'
  use 'NLKNguyen/papercolor-theme'
  use 'navarasu/onedark.nvim' ; require('plugin-settings/onedark')

  use 'lukas-reineke/indent-blankline.nvim' ; require('plugin-settings/indent-blankline')
  use 'junegunn/goyo.vim'
  use 'goolord/alpha-nvim' ; require('plugin-settings/alpha')
  use 'norcalli/nvim-colorizer.lua' ; require'colorizer'.setup()
  use 'fladson/vim-kitty'

  use 'folke/twilight.nvim' ; require('plugin-settings/twilight')

  -- Development Tools
  use 'tpope/vim-fugitive'
  use 'mbbill/undotree'
  -- use 'airblade/vim-gitgutter' ; require('plugin-settings/gitgutter')
  use 'tpope/vim-surround'
  use 'tpope/vim-commentary'
  use 'jkramer/vim-checkbox'
  use 'tyru/capture.vim'
  use 'lewis6991/gitsigns.nvim' ; require('plugin-settings.gitsigns')

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)

