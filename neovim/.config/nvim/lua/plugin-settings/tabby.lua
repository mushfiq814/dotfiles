local colors = require('theme').colors
local success, tabby = pcall(require, 'tabby')
if not success then return end

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
  return require('tabby.util').get_tab_name(tabid, vim.api.nvim_tabpage_get_number)
end

local gitbranch = function()
  local handle = io.popen('git rev-parse --abbrev-ref HEAD 2> /dev/null')
  local branch_name = handle:read('*a')
  branch_name = string.gsub(branch_name, '[^%w-\\.]', '')
  handle:close()

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

tabby.setup({ tabline = line })

