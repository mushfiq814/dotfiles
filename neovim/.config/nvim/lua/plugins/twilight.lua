require("twilight").setup {
	-- your configuration comes here
	-- or leave it empty to use the default settings
	-- refer to the configuration section below
	dimming = {
    alpha = 0.50, -- amount of dimming
    -- we try to get the foreground from the highlight groups or fallback color
    color = { "#ffffff" },
    inactive = false, -- when true, other windows will be fully dimmed (unless they contain the same buffer)
  },
  context = 10, -- amount of lines we will try to show around the current line
  treesitter = true, -- use treesitter when available for the filetype
  -- treesitter is used to automatically expand the visible text,
  -- but you can further control the types of nodes that should always be fully expanded
  expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
    "function",
    "method",
    "table",
    "if_statement",
  },
  exclude = {}, -- exclude these filetypes
}

-- NOTE: a modification has been added to the following line in the following file.
-- ./.local/share/nvim/site/pack/packer/start/twilight.nvim/lua/twilight/config.lua:55
-- to keep the background color to transparent as per this github issue:
-- https://github.com/folke/twilight.nvim/issues/15
