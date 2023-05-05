-- install package manager
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

vim.g.mapleader = " "

local modulesDir = '/home/mushfiq/.config/nvim/lua/config/'
-- load package manager
require('lazy').setup({
  -- local
  { dir = modulesDir .. 'theme.lua', name = 'theme', config = function() require('config/theme') end },
  { dir = modulesDir .. 'winbar.lua', name = 'winbar', config = function() require('config/winbar') end },
  { dir = modulesDir .. 'statusline.lua', name = 'statusline', config = function() require('config/statusline') end },
  { dir = modulesDir .. 'settings.lua', name = 'settings', config = function() require('config/settings') end },
  { dir = modulesDir .. 'keybindings.lua', name = 'keybindings', config = function() require('config/keybindings') end },
  { dir = modulesDir .. 'functions.lua', name = 'functions', config = function() require('config/functions') end },
  { dir = modulesDir .. 'commands.lua', name = 'commands', config = function() require('config/commands') end },
  { dir = modulesDir .. 'autocommands.lua', name = 'autocommands', config = function() require('config/autocommands') end },

  -- language server
  { 'williamboman/mason.nvim' },
  { 'williamboman/mason-lspconfig.nvim', config = function() require('config/plugin-settings/mason') end },
  { 'neovim/nvim-lspconfig', config = function() require('config/plugin-settings/nvim-lsp') end },
  { 'jose-elias-alvarez/null-ls.nvim', config = function() require('config/plugin-settings/null-ls') end },
  { 'mfussenegger/nvim-dap', lazy = true },
  { 'mfussenegger/nvim-jdtls', lazy = true },

  -- treesitter
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate', config = function() require('config/plugin-settings/treesitter') end },
  { 'nvim-treesitter/playground', cmd = { 'TSPlaygroundToggle', 'TSHighlightCapturesUnderCursor' } },
  { 'simrat39/symbols-outline.nvim', config = function() require('config/plugin-settings/symbols-outline') end, cmd = "SymbolsOutline" },

  -- cmp plugins
  { 'hrsh7th/nvim-cmp', config = function() require('config/plugin-settings/nvim-cmp') end },
  { 'hrsh7th/cmp-buffer' }, -- buffer completions
  { 'hrsh7th/cmp-path' }, -- path completions
  { 'hrsh7th/cmp-cmdline' }, -- cmdline completions
  { 'saadparwaiz1/cmp_luasnip' }, -- snippet completions
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/cmp-nvim-lsp-signature-help' },
  { 'SmiteshP/nvim-navic', config = function() require('config/plugin-settings/nvim-navic') end },

  -- snippets
  { "L3MON4D3/LuaSnip" },
  { "rafamadriz/friendly-snippets" },

  -- required libraries
  { 'nvim-lua/popup.nvim', lazy = true },
  { 'nvim-lua/plenary.nvim' },
  { 'kyazdani42/nvim-web-devicons' },

  -- telescope
  { 'nvim-telescope/telescope.nvim', config = function() require('config/plugin-settings/telescope') end },
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },

  -- UI
  { 'kyazdani42/nvim-tree.lua', config = function() require('config/plugin-settings/nvim-tree') end, cmd = { 'NvimTreeOpen', 'NvimTreeToggle' }, keys = '<C-n>' },
  { 'rcarriga/nvim-notify', config = function() require('config/plugin-settings/nvim-notify') end },
  { 'lukas-reineke/indent-blankline.nvim', config = function() require('config/plugin-settings/indent-blankline') end },
  { 'folke/zen-mode.nvim', config = function() require('config/plugin-settings/zen-mode') end, keys = '<leader>x' },
  { 'NvChad/nvim-colorizer.lua', config = function() require('config/plugin-settings/nvim-colorizer') end, lazy = true },
  -- { 'fladson/vim-kitty' },
  -- { 'edluffy/hologram.nvim', config = function() require('config/plugin-settings/hologram') end },
  -- { 'samodostal/image.nvim', config = function() require('config/plugin-settings/image') end },
  { 'm00qek/baleia.nvim' },
  { 'samodostal/image.nvim', config = function() require('config/plugin-settings/image') end },

  -- Development Tools
  { 'TimUntersberger/neogit', config = function() require('config/plugin-settings/neogit') end, lazy = true },
  { 'sindrets/diffview.nvim', lazy = true },
  { 'tpope/vim-fugitive', cmd = 'G' },
  { 'numToStr/Comment.nvim', config = function() require('config/plugin-settings/comment') end, keys = { { 'gc', mode = { "n", "v" } }, 'gcc' } },
  { 'lewis6991/gitsigns.nvim', config = function() require('config/plugin-settings.gitsigns') end },

  -- replace eventually
  { 'jkramer/vim-checkbox', keys = '<leader>tt' },
  { 'godlygeek/tabular', keys = '<leader>a', cmd = 'Tabularize' },
  { 'goolord/alpha-nvim', config = function() require('config/plugin-settings/alpha') end, priority = 1000 },
})

-- vim:nospell
