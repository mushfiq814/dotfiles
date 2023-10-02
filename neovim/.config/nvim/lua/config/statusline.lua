local colors_loaded, colors = pcall(require, 'config/colors')
if not colors_loaded then return end
local background = colors.grey0
local foreground = colors.white

-- from https://nuxsh.is-a.dev/blog/custom-nvim-statusline.html
local modes = {
  ["n"] = { name = "NORMAL", highlight = "statusLineModeNormal" },
  ["no"] = { name = "NORMAL", highlight = "statusLineModeNormal" },
  ["v"] = { name = "VISUAL", highlight = "statusLineModeVisual" },
  ["V"] = { name = "V-LINE", highlight = "statusLineModeVisual" },
  [""] = { name = "V-BLOCK", highlight = "statusLineModeVisual" },
  ["s"] = { name = "SELECT", highlight = "statusLineModeNormal" },
  ["S"] = { name = "SELECT LINE", highlight = "statusLineModeNormal" },
  [""] = { name = "SELECT BLOCK", highlight = "statusLineModeNormal" },
  ["i"] = { name = "INSERT", highlight = "statusLineModeInsert" },
  ["ic"] = { name = "INSERT", highlight = "statusLineModeInsert" },
  ["R"] = { name = "REPLACE", highlight = "statusLineModeNormal" },
  ["Rv"] = { name = "VISUAL REPLACE", highlight = "statusLineModeNormal" },
  ["c"] = { name = "COMMAND", highlight = "statusLineModeCommand" },
  ["cv"] = { name = "VIM EX", highlight = "statusLineModeNormal" },
  ["ce"] = { name = "EX", highlight = "statusLineModeNormal" },
  ["r"] = { name = "PROMPT", highlight = "statusLineModeNormal" },
  ["rm"] = { name = "MOAR", highlight = "statusLineModeNormal" },
  ["r?"] = { name = "CONFIRM", highlight = "statusLineModeNormal" },
  ["!"] = { name = "SHELL", highlight = "statusLineModeNormal" },
  ["t"] = { name = "TERMINAL", highlight = "statusLineModeTerminal" },
  ["nt"] = { name = "TERMINAL", highlight = "statusLineModeTerminal" },
}
local function mode()
  local current_mode = vim.api.nvim_get_mode().mode
  local mode = string.format(" %s ", modes[current_mode].name):upper()
  return "%#" .. modes[current_mode].highlight .. "#" .. mode .. "%#Normal#"
end

BRANCHES = {}
local function cacheGitBranch()
  local handle = io.popen('git rev-parse --abbrev-ref HEAD 2> /dev/null')
  if handle == nil then return '' end
  local branch_name = handle:read('*a')
  branch_name = string.gsub(branch_name, '[^%w-/\\.]', '')
  handle:close()

  if branch_name == nil or branch_name == '' then
    return ''
  else
    BRANCHES[vim.api.nvim_get_current_buf()] = branch_name
    return '%#statusLineBranch#  ' .. branch_name .. ' %#Normal#'
  end
end

local augroupGitBranch = vim.api.nvim_create_augroup('statusLineGitBranchGroup', { clear = true })
vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  group = augroupGitBranch,
  callback = function() cacheGitBranch() end
})
local function retrieveBranchFromCache()
  local branch_name = BRANCHES[vim.api.nvim_get_current_buf()] or nil
  if branch_name == nil or #(branch_name) < 1 then return '' end
  return '%#statusLineBranch#  ' .. branch_name .. ' %#Normal#'
end

local function lspDiagnosticCounts()
  -- from nvim-lualine/lualine.nvim
  local diagnostics = vim.diagnostic.get(0)
  local count = { 0, 0, 0, 0 }
  for _, diagnostic in ipairs(diagnostics) do
    if vim.startswith(vim.diagnostic.get_namespace(diagnostic.namespace).name, 'vim.lsp') then
      count[diagnostic.severity] = count[diagnostic.severity] + 1
    end
  end
  local error_count = count[vim.diagnostic.severity.ERROR]
  local warning_count = count[vim.diagnostic.severity.WARN]
  local info_count = count[vim.diagnostic.severity.INFO]
  local hint_count = count[vim.diagnostic.severity.HINT]
  return table.concat({
    '%#statusLineDiagnosticsError#  ' .. error_count .. ' ',
    '%#statusLineDiagnosticsWarning# ' .. warning_count .. ' ',
    '%#statusLineDiagnosticsInfo# ' .. info_count + hint_count .. ' ',
    '%#Normal#'
  })
end

local function filename()
  local file = vim.fn.expand("%:~:.")
  if vim.bo.modified then file = file .. "%#statusLineFileNameModified# ● %#Normal#" end
  return "%#statusLineFileName#" .. file .. "%#Normal#"
end

local function filetype()
  local filename = vim.fn.expand("%:t")
  local filetype = vim.bo.filetype
  local filetypeStr = "%#statusLineFileType# " .. filetype .. " %#Normal#"

  -- icon
  local filetypeIconStr = ""
  local devicons_loaded, devicons = pcall(require, 'nvim-web-devicons')
  if devicons_loaded then
    local icon, color = devicons.get_icon_color_by_filetype(filetype)
    if not (icon and color) then
      icon, color = devicons.get_icon_color(filename, filetype)
    end
    if icon and color then
      vim.cmd(
        "highlight! statusLineFileTypeIcon guifg="
        .. color
        .. " guibg="
        .. background
      )
      filetypeIconStr = '%#statusLineFileTypeIcon# ' .. icon .. ' %#Normal#'
    else
    end
  end
  return filetypeIconStr .. filetypeStr
end

local function lineinfo()
  local lines = vim.api.nvim_buf_line_count(0)
  local currentLine = vim.fn.line('.')
  local currentColumn = vim.fn.col('.')
  local progress = math.ceil(100 * currentLine / lines)

  local progressStr = ""
  if progress >= 0 and progress < 12.5 then
    progressStr = "██"
  elseif progress >= 12.5 and progress < 25 then
    progressStr = "▇▇"
  elseif progress >= 25 and progress < 37.5 then
    progressStr = "▆▆"
  elseif progress >= 37.5 and progress < 50 then
    progressStr = "▅▅"
  elseif progress >= 50 and progress < 62.5 then
    progressStr = "▄▄"
  elseif progress >= 62.5 and progress < 75 then
    progressStr = "▃▃"
  elseif progress >= 75 and progress < 87.5 then
    progressStr = "▂▂"
  else
    progressStr = "▁▁"
  end

  local currentLineStr = string.format("%3d", currentLine)
  local currentColumnStr = string.format("%-3d", currentColumn)

  return
    '%#statusLineProgress#' .. progressStr
    .. '%#statusLineRowCol# ' .. currentLineStr .. ':' .. currentColumnStr .. ' %#Normal#'
end

local function cwd()
  return '%#statusLineCwd#  ' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':t') .. ' %#Normal#'
end

local function activeLlspClient()
  local clients = vim.lsp.get_active_clients({ bufnr = 0 })
  if #(clients) == 0 then return '' end
  return '%#statusLineLspClient# ' .. clients[1].name .. ' %#Normal#'
end

local function tabpages()
  local tabpages = vim.api.nvim_list_tabpages()
  local currentTabpage = vim.api.nvim_win_get_tabpage(0)

  local tabStr = "%#statusLineTabNormal# 缾"
  for _, id in ipairs(tabpages) do
    if currentTabpage == id then
      -- tabStr = tabStr .. "%#statuslineTabActive#  " .. id .. " "
      tabStr = tabStr .. "%#statuslineTabActive# " .. id .. " "
    else
      -- tabStr = tabStr .. "%#statuslineTabInactive#  " .. id .. " "
      tabStr = tabStr .. "%#statuslineTabInactive# " .. id .. " "
    end
  end

  return tabStr
end

-- make statusline smaller depending on screen size
WINCOLS = nil
local augroupResize = vim.api.nvim_create_augroup('statusLineResizeGroup', { clear = true })
vim.api.nvim_create_autocmd({ 'VimResized' }, {
  group = augroupResize,
  callback = function()
    WINCOLS = vim.o.columns
  end
})

local function spacer()
  return '%#statusLineCwd#%=%#Normal#'
end

function MyStatusLine()
  local statusline = ''
  if WINCOLS and WINCOLS < 100 then
    statusline = table.concat({
      mode(),
      tabpages(),
      cwd(),
      spacer(),
      filetype(),
      lineinfo(),
    })
  else
    statusline = table.concat({
      mode(),
      tabpages(),
      retrieveBranchFromCache(),
      cwd(),
      filename(),
      spacer(),
      lspDiagnosticCounts(),
      activeLlspClient(),
      filetype(),
      lineinfo(),
    })
  end
  return statusline
end

vim.o.statusline = "%{%v:lua.MyStatusLine()%}"

-- remove native tabline
vim.o.showtabline = 0

-- global statusline
vim.o.laststatus = 3

local color_utils = require('config/utils/color-utils')
local hi = color_utils.highlight

hi.statusLineModeNormal = { guifg = colors.grey0, guibg = colors.bright_aqua, gui = 'bold', }
hi.statusLineModeInsert = { guifg = colors.grey0, guibg = colors.bright_blue, gui = 'bold', }
hi.statusLineModeVisual = { guifg = colors.grey0, guibg = colors.bright_orange, gui = 'bold', }
hi.statusLineModeCommand = { guifg = colors.grey0, guibg = colors.bright_yellow, gui = 'bold', }
hi.statusLineModeTerminal = { guifg = colors.grey0, guibg = colors.bright_purple, gui = 'bold', }
hi.statusLineTabNormal = { guifg = foreground, guibg = background, }
hi.statuslineTabActive = { guifg = background, guibg = colors.bright_purple, }
hi.statuslineTabInactive = { guifg = colors.white, guibg = colors.grey2, }
hi.statusLineBranch = { guifg = foreground, guibg = background, gui = 'bold', }
hi.statusLineCwd = { guifg = colors.bright_blue, guibg = background, }
hi.statusLineFileName = { guifg = colors.bright_aqua, guibg = background, }
hi.statusLineFileNameModified = { guifg = colors.bright_red, guibg = background, }
hi.statusLineSpacer = { guifg = foreground, guibg = background, }
hi.statusLineDiagnosticsError = { guifg = colors.bright_red, guibg = background, }
hi.statusLineDiagnosticsWarning = { guifg = colors.bright_yellow, guibg = background, }
hi.statusLineDiagnosticsInfo = { guibg = background, guifg = colors.bright_aqua, }
hi.statusLineLspClient = { guibg = background, guifg = colors.bright_orange, }
hi.statusLineFileType = { guifg = foreground, guibg = background, }
hi.statusLineProgress = { guibg = colors.bright_yellow, guifg = colors.grey3, }
hi.statusLineRowCol = { guifg = colors.bright_aqua, guibg = background, gui = 'bold', }
