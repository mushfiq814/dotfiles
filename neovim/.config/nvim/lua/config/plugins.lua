local list = {
  -- language server
  { name = 'williamboman/mason.nvim' },
  { name = 'williamboman/mason-lspconfig.nvim', config = 'config/plugin-settings/mason' },
  { name = 'neovim/nvim-lspconfig', config = 'config/plugin-settings/nvim-lsp' },
  { name = 'jose-elias-alvarez/null-ls.nvim', config = 'config/plugin-settings/null-ls' },

  -- treesitter
  { name = 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', config = 'config/plugin-settings/treesitter' },
  { name = 'nvim-treesitter/playground' },
  { name = 'lewis6991/spellsitter.nvim', config = 'config/plugin-settings/spellsitter' },
  { name = 'simrat39/symbols-outline.nvim', config = 'config/plugin-settings/symbols-outline' },

  -- cmp plugins
  { name = 'hrsh7th/nvim-cmp', config = 'config/plugin-settings/nvim-cmp' },
  { name = 'hrsh7th/cmp-buffer' }, -- buffer completions
  { name = 'hrsh7th/cmp-path' }, -- path completions
  { name = 'hrsh7th/cmp-cmdline' }, -- cmdline completions
  { name = 'saadparwaiz1/cmp_luasnip' }, -- snippet completions
  { name = 'hrsh7th/cmp-nvim-lsp' },
  { name = 'hrsh7th/cmp-nvim-lsp-signature-help' },
  { name = 'SmiteshP/nvim-navic', config = 'config/plugin-settings/nvim-navic' },

  -- snippets
  { name = "L3MON4D3/LuaSnip" },
  { name = "rafamadriz/friendly-snippets" },

  -- required libraries
  { name = 'nvim-lua/popup.nvim' },
  { name = 'nvim-lua/plenary.nvim' },
  { name = 'kyazdani42/nvim-web-devicons' },

  -- telescope
  { name = 'nvim-telescope/telescope.nvim', config = 'config/plugin-settings/telescope' },
  { name = 'nvim-telescope/telescope-media-files.nvim', config = 'config/plugin-settings/telescope-media-files' },
  { name = 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },

  -- UI
  { name = 'kyazdani42/nvim-tree.lua', config = 'config/plugin-settings/nvim-tree' },
  { name = 'rcarriga/nvim-notify', config = 'config/plugin-settings/nvim-notify' },
  { name = 'lukas-reineke/indent-blankline.nvim', config = 'config/plugin-settings/indent-blankline' },
  { name = 'folke/zen-mode.nvim', config = 'config/plugin-settings/zen-mode' },
  { name = 'NvChad/nvim-colorizer.lua', config = 'config/plugin-settings/nvim-colorizer' },
  -- { name = 'fladson/vim-kitty' },
  -- { name = 'edluffy/hologram.nvim', config = 'config/plugin-settings/hologram' },
  -- { name = 'samodostal/image.nvim', config = 'config/plugin-settings/image' },

  -- Development Tools
  { name = 'tpope/vim-fugitive' },
  { name = 'numToStr/Comment.nvim', config = 'config/plugin-settings/comment' },
  { name = 'lewis6991/gitsigns.nvim', config = 'config/plugin-settings.gitsigns' },

  -- replace eventually
  { name = 'jkramer/vim-checkbox' },
  { name = 'godlygeek/tabular' },
  { name = 'goolord/alpha-nvim', config = 'config/plugin-settings/alpha' },
}
return list
