require('packer').startup(function ()
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	-- Programming Language Plugins
	use 'godlygeek/tabular'
	use 'mattn/emmet-vim'
	use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' } ; require('plugins/treesitter')
	-- use 'nvim-treesitter/playground'
	use 'neovim/nvim-lspconfig' ; require('plugins/nvim-lsp')
	use 'williamboman/nvim-lsp-installer' ; require('plugins/lsp-installer')
	use 'hrsh7th/nvim-compe' ; require('plugins/nvim-compe')
	use 'lewis6991/spellsitter.nvim' ; require('plugins/spellsitter')
	-- use 'dense-analysis/ale'

	-- Navigation Plugins
	use 'nvim-telescope/telescope.nvim' ; require('plugins/telescope')
	use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
	use 'masukomi/vim-markdown-folding'
	use 'nvim-lua/plenary.nvim'
	use 'psliwka/vim-smoothie'
	use 'rstacruz/vim-closer'

	-- UI Colors
	use 'kyazdani42/nvim-web-devicons'
	use 'kyazdani42/nvim-tree.lua' ; require('plugins/nvim-tree')
	use 'hoob3rt/lualine.nvim' ; require('plugins/lualine')
	use 'nanozuki/tabby.nvim' ; require('plugins/tabby')

  -- Colorschemes
	use 'morhetz/gruvbox'
	use 'Shadorain/shadotheme'
	use 'whatyouhide/vim-gotham'
	use 'sainnhe/sonokai'
  use 'NLKNguyen/papercolor-theme'
  use 'navarasu/onedark.nvim' ; require('plugins/onedark')

	use 'lukas-reineke/indent-blankline.nvim' ; require('plugins/indent-blankline')
	use 'junegunn/goyo.vim'
	-- use 'mhinz/vim-startify' ; require('plugins/startify')
	use 'goolord/alpha-nvim' ; require('plugins/alpha')
	use 'norcalli/nvim-colorizer.lua' ;  require'colorizer'.setup()
	use 'fladson/vim-kitty'

	use 'folke/twilight.nvim' ; require('plugins/twilight')

	-- Development Tools
	use 'tpope/vim-fugitive'
	use 'mbbill/undotree'
	use 'airblade/vim-gitgutter' ; require('plugins/gitgutter')
	use 'tpope/vim-surround'
	use 'tpope/vim-commentary'

  use 'jkramer/vim-checkbox'
end)

