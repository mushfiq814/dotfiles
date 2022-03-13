require('packer').startup(function ()
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	-- Programming Language Plugins
	use 'godlygeek/tabular'
	use 'mattn/emmet-vim'
	use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' } ; require('plugin-settings/treesitter')
	-- use 'lewis6991/spellsitter.nvim' ; require('plugin-settings/spellsitter')
	use 'neovim/nvim-lspconfig' ; require('plugin-settings/nvim-lsp')
	use 'williamboman/nvim-lsp-installer' ; require('plugin-settings/lsp-installer')

	-- use 'hrsh7th/cmp-nvim-lsp'
	-- use 'hrsh7th/cmp-buffer'
	-- use 'hrsh7th/cmp-path'
	-- use 'hrsh7th/cmp-cmdline'
	-- use 'hrsh7th/nvim-cmp' ; require('plugin-settings/nvim-cmp')
	-- use 'hrsh7th/cmp-vsnip'
	-- use 'hrsh7th/vim-vsnip'
	use 'hrsh7th/nvim-compe' ; require('plugin-settings/nvim-compe')

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
	use 'norcalli/nvim-colorizer.lua' ;  require'colorizer'.setup()
	use 'fladson/vim-kitty'

	use 'folke/twilight.nvim' ; require('plugin-settings/twilight')

	-- Development Tools
	use 'tpope/vim-fugitive'
	use 'mbbill/undotree'
	use 'airblade/vim-gitgutter' ; require('plugin-settings/gitgutter')
	use 'tpope/vim-surround'
	use 'tpope/vim-commentary'
	use 'jkramer/vim-checkbox'
end)

