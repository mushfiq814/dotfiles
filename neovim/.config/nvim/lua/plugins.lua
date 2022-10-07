local list = {
  -- Programming Language Plugins
  { name = 'williamboman/mason.nvim' },
  { name = 'williamboman/mason-lspconfig.nvim', config = 'plugin-settings/mason' },
  { name = 'neovim/nvim-lspconfig', config = 'plugin-settings/nvim-lsp' },
  { name = 'godlygeek/tabular' },
  { name = 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', config = 'plugin-settings/treesitter' },
  { name = 'nvim-treesitter/playground' },
  { name = 'lewis6991/spellsitter.nvim', config = 'plugin-settings/spellsitter' },
  { name = 'simrat39/symbols-outline.nvim', config = 'plugin-settings/symbols-outline' },
  { name = 'jose-elias-alvarez/null-ls.nvim', config = 'plugin-settings/null-ls' },

  -- cmp plugins
  { name = 'hrsh7th/nvim-cmp', config = 'plugin-settings/nvim-cmp' },
  { name = 'hrsh7th/cmp-buffer' }, -- buffer completions
  { name = 'hrsh7th/cmp-path' }, -- path completions
  { name = 'hrsh7th/cmp-cmdline' }, -- cmdline completions
  { name = 'saadparwaiz1/cmp_luasnip' }, -- snippet completions
  { name = 'hrsh7th/cmp-nvim-lsp' },
  { name = 'hrsh7th/cmp-nvim-lsp-signature-help' },
  { name = 'SmiteshP/nvim-navic', config = 'plugin-settings/nvim-navic' },

  -- snippets
  { name = "L3MON4D3/LuaSnip" },
  { name = "rafamadriz/friendly-snippets" },

  -- Navigation Plugins
  { name = 'nvim-lua/popup.nvim' },
  { name = 'nvim-lua/plenary.nvim' },
  { name = 'nvim-telescope/telescope.nvim', config = 'plugin-settings/telescope' },
  { name = 'nvim-telescope/telescope-media-files.nvim', config = 'plugin-settings/telescope-media-files' },
  { name = 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },

  -- UI
  { name = 'kyazdani42/nvim-web-devicons' },
  { name = 'kyazdani42/nvim-tree.lua', config = 'plugin-settings/nvim-tree' },
  -- { name = 'hoob3rt/lualine.nvim', config = 'plugin-settings/lualine' },
  { name = 'nanozuki/tabby.nvim', config = 'plugin-settings/tabby' },
  { name = 'rcarriga/nvim-notify', config = 'plugin-settings/nvim-notify' },
  { name = 'lukas-reineke/indent-blankline.nvim', config = 'plugin-settings/indent-blankline' },
  { name = 'folke/zen-mode.nvim', config = 'plugin-settings/zen-mode' },
  { name = 'goolord/alpha-nvim', config = 'plugin-settings/alpha' },
  { name = 'NvChad/nvim-colorizer.lua', config = 'plugin-settings/nvim-colorizer' },
  -- { name = 'fladson/vim-kitty' },
  -- { name = 'edluffy/hologram.nvim', config = 'plugin-settings/hologram' },
  -- { name = 'samodostal/image.nvim', config = 'plugin-settings/image' },

  -- Colorschemes
  { name = 'morhetz/gruvbox' },
  { name = 'navarasu/onedark.nvim', config = 'plugin-settings/onedark' },
  { name = 'eddyekofo94/gruvbox-flat.nvim' },
  { name = ({ "catppuccin/nvim", as = "catppuccin" }), config = 'plugin-settings/catppuccin' },

  -- Development Tools
  { name = 'tpope/vim-fugitive' },
  { name = 'tpope/vim-surround' },
  { name = 'numToStr/Comment.nvim', config = 'plugin-settings/comment' },
  { name = 'jkramer/vim-checkbox' },
  { name = 'lewis6991/gitsigns.nvim', config = 'plugin-settings.gitsigns' },
}
return list
