-- require("tabby").setup({
-- 	tabline = require("tabby.presets").active_wins_at_end,
-- })

local colors = {
	black          = '#1d2021',
	grey0          = '#282828',
	grey1          = '#504945',
	grey2          = '#7c6f64',
	grey3          = '#a89984',
	grey4          = '#ebdbb2',
	white          = '#fbf1c7',

	bright_red     = '#fb4934',
	bright_green   = '#b8bb26',
	bright_yellow  = '#fabd2f',
	bright_blue    = '#83a598',
	bright_purple  = '#d3869b',
	bright_aqua    = '#8ec07c',
	bright_orange  = '#fe8019',

	neutral_red    = '#cc241d',
	neutral_green  = '#98971a',
	neutral_yellow = '#d79921',
	neutral_blue   = '#458588',
	neutral_purple = '#b16286',
	neutral_aqua   = '#689d6a',
	neutral_orange = '#d65d0e',

	faded_red      = '#9d0006',
	faded_green    = '#79740e',
	faded_yellow   = '#b57614',
	faded_blue     = '#076678',
	faded_purple   = '#8f3f71',
	faded_aqua     = '#427b58',
	faded_orange   = '#af3a03',
}

local palette = {
	bg0   = nil,
	bg1   = colors.black,
	bg2   = colors.grey1,
	ac1_1 = colors.bright_aqua,
	ac1_2 = colors.neutral_aqua,
	ac1_3 = colors.faded_aqua,
	ac2_1 = colors.bright_purple,
	ac2_2 = colors.neutral_purple,
	ac2_3 = colors.faded_purple,
}

local separator = {
	left  = '▐', -- ▐    
	right = '▌', -- ▌    
}

 local filename = require('tabby.filename')
 
 local cwd = function()
 	return ' ' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':t') .. ' '
 end
  
 local tabname = function(tabid)
 	return vim.api.nvim_tabpage_get_number(tabid)
 end
 
 local gitbranch = function()
 	-- get branch name from lualine function
 	local branch = require('lualine.components.branch')
 	local branch_name = branch.git_branch
 
 	if branch_name == nil or branch_name == '' then
 		return ''
 	else
 		return '  ' .. branch_name .. ' '
 	end
 end
 
 local line = {
 	hl = { fg = palette.white, bg = palette.bg },
 	layout = 'active_wins_at_tail',
 	head = {
 		-- { separator.left, hl = { fg = palette.ac1_1 } },
 		{ cwd, hl = { fg = palette.bg1, bg = palette.ac1_1, style = 'bold' } },
 		{ gitbranch, hl = { fg = palette.bg1, bg = palette.ac1_2, style = 'bold' } },
 		{ separator.right, hl = { fg = palette.ac1_2, bg = palette.bg0 } },
 	},
 	active_tab = {
 		label = function(tabid)
 			return {
 				'  ' .. tabname(tabid) .. ' ',
 				hl = { fg = palette.bg1, bg = palette.ac1_3, style = 'bold' },
 			}
 		end,
 		left_sep = { separator.left, hl = { fg = palette.ac1_3, bg = palette.bg0 } },
 		right_sep = { separator.right, hl = { fg = palette.ac1_3, bg = palette.bg0 } },
 	},
 	inactive_tab = {
 		label = function(tabid)
 			return {
 				'  ' .. tabname(tabid) .. ' ',
 				hl = { fg = palette.white, bg = palette.bg2, style = 'italic' },
 			}
 		end,
 		left_sep = { separator.left, hl = { fg = palette.bg2, bg = palette.bg0 } },
 		right_sep = { separator.right, hl = { fg = palette.bg2, bg = palette.bg0 } },
 	},
 	top_win = {
 		label = function(winid)
 			return {
 				'  ' .. filename.unique(winid) .. ' ',
 				hl = { fg = palette.bg1, bg = palette.ac2_2, style = 'bold' },
 			}
 		end,
 		left_sep = { separator.left, hl = { fg = palette.ac2_2, bg = palette.bg0 } },
 		right_sep = { separator.right, hl = { fg = palette.ac2_2, bg = palette.bg0 } },
 	},
 	win = {
 		label = function(winid)
 			return {
 				'  ' .. filename.unique(winid) .. ' ',
 				hl = { fg = palette.bg1, bg = palette.bg2 },
 			}
 		end,
 		left_sep = { separator.left, hl = { fg = palette.bg2, bg = palette.bg0 } },
 		right_sep = { separator.right, hl = { fg = palette.bg2, bg = palette.bg0 } },
 	},
 	tail = {
 		{ separator.left, hl = { fg = palette.ac2_1, bg = palette.bg0 } },
 		{ '   ', hl = { fg = palette.bg1, bg = palette.ac2_1 } },
 		-- { separator.right, hl = { fg = palette.ac2_1 } },
 	},
 }
 
 require('tabby').setup({ tabline = line })

