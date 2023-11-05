# NeoVim Setup

This is my neovim configuration written in lua.

## Overview

* `after/`: directory containing filetype speific code inside `ftplugin` and treesitter highlight extension queries in `queries`
* `lua/config/`: the main configuration files written in lua
  * `plugins.lua`: list of plugins that I use. These are loaded using [lazy.nvim](https://github.com/folke/lazy.nvim) plugin manager
  * `settings.lua`: list of vim settings to set/override defaults
  * `snippets.lua`: list of global and filetype specific snippets powered by [luasnip](https://github.com/L3MON4D3/LuaSnip)
  * `statusline.lua`: config for my custom status line (line going through the bottom of my editor)
  * `winbar.lua`: config for my custom winbar (line towards the top of each file buffer)
  * `theme.lua`: highlight groups used all throughout my config for setting theme colors
  * `unused.lua`: functions that have not yet found a home in my config
  * `keybindings.lua`: my keybindings
  * `plugin-settings/`: contains specific settings for each plugin in `plugins.lua`

