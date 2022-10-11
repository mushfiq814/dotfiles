local colors_loaded, colors = pcall(require, 'config/colors')
if not colors_loaded then return end
local background = colors.black
local foreground = colors.white

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

BRANCHES = {}
local function cacheGitBranch()
  local handle = io.popen('git rev-parse --abbrev-ref HEAD 2> /dev/null')
  local branch_name = handle:read('*a')
  branch_name = string.gsub(branch_name, '[^%w-\\.]', '')
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
  if #(BRANCHES) then return '' end
  local branch_name = BRANCHES[vim.api.nvim_get_current_buf()]
  if #(branch_name) then return '' end
  return '%#statusLineBranch#  ' .. BRANCHES[vim.api.nvim_get_current_buf()] .. ' %#Normal#'
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

  return '%#statusLineProgress# ' ..
      progressStr .. '%#statusLineRowCol# ' .. currentLineStr .. ':' .. currentColumnStr .. ' %#Normal#'
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
    tabpages(),
    retrieveBranchFromCache(),
    cwd(),
    spacer(),
    lspDiagnosticCounts(),
    activeLlspClient(),
    filetype(),
    lineinfo(),
  })
  return statusline
end
vim.o.statusline = "%{%v:lua.MyStatusLine()%}"

-- remove native tabline
vim.o.showtabline = false

-- global statusline
vim.o.laststatus = 3

local function highlights()
  --
  vim.cmd(
    "highlight! statusLineModeNormal gui=bold guibg="
    .. colors.bright_aqua
    .. " guifg="
    .. colors.grey0
  )
  vim.cmd(
    "highlight! statusLineModeInsert gui=bold guibg="
    .. colors.bright_blue
    .. " guifg="
    .. colors.grey0
  )
  vim.cmd(
    "highlight! statusLineModeVisual gui=bold guibg="
    .. colors.bright_orange
    .. " guifg="
    .. colors.grey0
  )
  vim.cmd(
    "highlight! statusLineModeCommand gui=bold guibg="
    .. colors.bright_yellow
    .. " guifg="
    .. colors.grey0
  )
  vim.cmd(
    "highlight! statusLineModeTerminal gui=bold guibg="
    .. colors.bright_purple
    .. " guifg="
    .. colors.grey0
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
    .. colors.bright_red
  )
  vim.cmd(
    "highlight! statusLineDiagnosticsWarning guibg="
    .. background
    .. " guifg="
    .. colors.bright_yellow
  )
  vim.cmd(
    "highlight! statusLineDiagnosticsInfo guibg="
    .. background
    .. " guifg="
    .. colors.bright_aqua
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
    .. colors.bright_purple
    .. " guibg="
    .. colors.grey0
  )
  vim.cmd(
    "highlight! statusLineRowCol gui=bold guifg="
    .. colors.bright_aqua
    .. " guibg="
    .. colors.grey0
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
    .. colors.bright_blue
  )
  --
  vim.cmd(
    "highlight! statusLineLspClient guibg="
    .. background
    .. " guifg="
    .. colors.bright_orange
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
    .. colors.faded_purple
    .. " guifg="
    .. background
  )
  vim.cmd(
    "highlight! statuslineTabInactive guibg="
    .. colors.grey2
    .. " guifg="
    .. colors.white
  )
end

highlights()
