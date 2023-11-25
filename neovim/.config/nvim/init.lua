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

local env_loaded, files = pcall(require, 'config/utils/read-env')
if not env_loaded then vim.notify("could not load env file!") end

require("lazy").setup("config/plugins")
require("config/keybindings")
require("config/settings")
require("config/statusline")
require("config/winbar")
require("config/snippets")
require("config/theme")
