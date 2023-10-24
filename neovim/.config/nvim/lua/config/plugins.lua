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

local afterFileOpen = { "BufReadPre", "BufNewFile" }

local modulesDir = '/home/mushfiq/.config/nvim/lua/config/'
-- load package manager
require('lazy').setup({
  -- local
  { dir = modulesDir .. 'theme.lua', name = 'theme', config = function() require('config/theme') end, priority = 1000 },
  { dir = modulesDir .. 'winbar.lua', name = 'winbar', config = function() require('config/winbar') end },
  { dir = modulesDir .. 'statusline.lua', name = 'statusline', config = function() require('config/statusline') end },
  { dir = modulesDir .. 'settings.lua', name = 'settings', config = function() require('config/settings') end },
  { dir = modulesDir .. 'keybindings.lua', name = 'keybindings', config = function() require('config/keybindings') end },

  -- language server
  { 'williamboman/mason.nvim', event = afterFileOpen },
  { 'williamboman/mason-lspconfig.nvim', config = function() require('config/plugin-settings/mason') end, event = afterFileOpen },
  { 'neovim/nvim-lspconfig', config = function() require('config/plugin-settings/nvim-lsp') end, event = afterFileOpen },
  { 'jose-elias-alvarez/null-ls.nvim', config = function() require('config/plugin-settings/null-ls') end, lazy = true },
  { 'mfussenegger/nvim-dap', lazy = true },
  { 'mfussenegger/nvim-jdtls', lazy = true },
  { 'SmiteshP/nvim-navic', config = function() require('config/plugin-settings/nvim-navic') end, lazy = true },

  -- treesitter
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate', config = function() require('config/plugin-settings/treesitter') end, event = afterFileOpen },
  { 'nvim-treesitter/playground', cmd = { 'TSPlaygroundToggle', 'TSHighlightCapturesUnderCursor' } },
  { 'simrat39/symbols-outline.nvim', config = function() require('config/plugin-settings/symbols-outline') end, cmd = "SymbolsOutline" },

  -- cmp plugins
  { 'hrsh7th/cmp-nvim-lsp', event = afterFileOpen },
  { 'hrsh7th/cmp-buffer', event = afterFileOpen },
  { 'hrsh7th/cmp-path', event = afterFileOpen },
  { 'hrsh7th/cmp-cmdline', event = afterFileOpen },
  { 'hrsh7th/nvim-cmp', config = function() require('config/plugin-settings/nvim-cmp') end, event = afterFileOpen },
  { 'hrsh7th/cmp-nvim-lsp-signature-help', event = afterFileOpen },

  -- snippets
  { 'L3MON4D3/LuaSnip', event = afterFileOpen },
  { 'saadparwaiz1/cmp_luasnip', event = afterFileOpen },

  -- required libraries
  { 'nvim-lua/popup.nvim', lazy = true },
  { 'nvim-lua/plenary.nvim', lazy = true },
  { 'kyazdani42/nvim-web-devicons', lazy = true },

  -- telescope
  { 'nvim-telescope/telescope.nvim', config = function() require('config/plugin-settings/telescope') end, lazy = true },
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make', lazy = true },

  -- UI
  { 'kyazdani42/nvim-tree.lua', config = function() require('config/plugin-settings/nvim-tree') end, cmd = { 'NvimTreeOpen', 'NvimTreeToggle' }, keys = '<C-n>' },
  { 'rcarriga/nvim-notify', config = function() require('config/plugin-settings/nvim-notify') end, event = afterFileOpen },
  { 'lukas-reineke/indent-blankline.nvim', main = "ibl", config = function() require('config/plugin-settings/indent-blankline') end, event = afterFileOpen },
  { 'folke/zen-mode.nvim', config = function() require('config/plugin-settings/zen-mode') end, keys = '<leader>x' },
  { 'NvChad/nvim-colorizer.lua', config = function() require('config/plugin-settings/nvim-colorizer') end, event = afterFileOpen },
  { 'm00qek/baleia.nvim', lazy = true },
  { 'samodostal/image.nvim', config = function() require('config/plugin-settings/image') end, event = afterFileOpen },

  -- Development Tools
  { 'TimUntersberger/neogit', config = function() require('config/plugin-settings/neogit') end, lazy = true },
  { 'sindrets/diffview.nvim', lazy = true },
  { 'tpope/vim-fugitive', cmd = { 'G', 'Gvdiffsplit' } },
  { 'numToStr/Comment.nvim', config = function() require('config/plugin-settings/comment') end, keys = { { 'gc', mode = { "n", "v" } }, 'gcc' } },
  { 'lewis6991/gitsigns.nvim', config = function() require('config/plugin-settings.gitsigns') end, event = afterFileOpen },

  -- replace eventually
  { 'jkramer/vim-checkbox', keys = '<leader>tt' },
  { 'godlygeek/tabular', keys = '<leader>a', cmd = 'Tabularize' },
  { 'goolord/alpha-nvim', config = function() require('config/plugin-settings/alpha') end, priority = 1000 },
})

-- vim:nospell
