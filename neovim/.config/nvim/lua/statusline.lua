local colors_loaded, colors = pcall(require, 'theme')
if not colors_loaded then return end
local theme = colors.colors
local background = theme.black
local foreground = theme.white

local function mode()
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
  local current_mode = vim.api.nvim_get_mode().mode
  local mode = string.format(" %s ", modes[current_mode].name):upper()
  return "%#" .. modes[current_mode].highlight .. "#" .. mode .. "%#Normal#"
end

local function gitbranch()
  local handle = io.popen('git rev-parse --abbrev-ref HEAD 2> /dev/null')
  local branch_name = handle:read('*a')
  branch_name = string.gsub(branch_name, '[^%w-\\.]', '')
  handle:close()

  if branch_name == nil or branch_name == '' then
    return ''
  else
    return '%#statusLineBranch#  ' .. branch_name .. ' %#Normal#'
  end
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
  local filename = vim.fn.expand("%:f")
  if vim.bo.modified then filename = filename .. " ● " end
  return filename
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
  if progress == 0 or currentLine == 1 then
    progressStr = "TOP"
  elseif progress == 100 then
    progressStr = "BOT"
  else
    progressStr = string.format("%2i%%%%", progress)
  end

  local currentLineStr = string.format("%3d", currentLine)
  local currentColumnStr = string.format("%-3d", currentColumn)

  return '%#statusLineProgress# ' .. progressStr .. '%#statusLineRowCol# ' .. currentLineStr .. ':' .. currentColumnStr .. ' %#Normal#'
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

local function spacer()
  return '%#statusLineCwd#%=%#Normal#'
end

function MyStatusLine()
  local statusline = table.concat({
    mode(),
    gitbranch(),
    cwd(),
    spacer(),
    lspDiagnosticCounts(),
    activeLlspClient(),
    filetype(),
    tabpages(),
    lineinfo(),
  })
  return statusline
end

vim.o.statusline = "%{%v:lua.MyStatusLine()%}"

-- global statusline
vim.o.laststatus = 3

local function highlights()
  -- 
  vim.cmd(
    "highlight! statusLineModeNormal gui=bold guibg="
    .. theme.bright_aqua
    .. " guifg="
    .. theme.grey0
  )
  vim.cmd(
    "highlight! statusLineModeInsert gui=bold guibg="
    .. theme.bright_blue
    .. " guifg="
    .. theme.grey0
  )
  vim.cmd(
    "highlight! statusLineModeVisual gui=bold guibg="
    .. theme.bright_orange
    .. " guifg="
    .. theme.grey0
  )
  vim.cmd(
    "highlight! statusLineModeCommand gui=bold guibg="
    .. theme.bright_yellow
    .. " guifg="
    .. theme.grey0
  )
  vim.cmd(
    "highlight! statusLineModeTerminal gui=bold guibg="
    .. theme.bright_purple
    .. " guifg="
    .. theme.grey0
  )
  -- 
  vim.cmd(
    "highlight! statusLineBranch gui=bold guibg="
    .. background
    .. " guifg="
    .. foreground
  )
  --
  vim.cmd(
    "highlight! statusLineDiagnosticsError guibg="
    .. background
    .. " guifg="
    .. theme.bright_red
  )
  vim.cmd(
    "highlight! statusLineDiagnosticsWarning guibg="
    .. background
    .. " guifg="
    .. theme.bright_yellow
  )
  vim.cmd(
    "highlight! statusLineDiagnosticsInfo guibg="
    .. background
    .. " guifg="
    .. theme.bright_aqua
  )
  -- 
  vim.cmd(
    "highlight! statusLineFileType guifg="
    .. foreground
    .. " guibg="
    .. background
  )
  -- 
  -- 
  vim.cmd(
    "highlight! statusLineProgress guifg="
    .. theme.bright_purple
    .. " guibg="
    .. theme.grey0
  )
  vim.cmd(
    "highlight! statusLineRowCol gui=bold guifg="
    .. theme.bright_aqua
    .. " guibg="
    .. theme.grey0
  )
  -- 
  vim.cmd(
    "highlight! statusLineSpacer guibg="
    .. background
    .. " guifg="
    .. foreground
  )
  -- 
  vim.cmd(
    "highlight! statusLineCwd guibg="
    .. background
    .. " guifg="
    .. theme.bright_blue
  )
  -- 
  vim.cmd(
    "highlight! statusLineLspClient guibg="
    .. background
    .. " guifg="
    .. theme.bright_orange
  )
  -- 
  vim.cmd(
    "highlight! statusLineTabNormal guibg="
    .. background
    .. " guifg="
    .. foreground
  )
  vim.cmd(
    "highlight! statuslineTabActive guibg="
    .. theme.faded_aqua
    .. " guifg="
    .. background
  )
  vim.cmd(
    "highlight! statuslineTabInactive guibg="
    .. theme.grey1
    .. " guifg="
    .. theme.white
  )
end
highlights()
