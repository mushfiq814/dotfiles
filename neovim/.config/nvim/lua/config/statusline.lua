local function statusString(list)
  local str = ""
  for _, v in pairs(list) do
    str = str .. "%#" .. v[2] .. "#" .. v[1]
  end
  str = str .. "%#Normal#"
  return str
end

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
  local modeStr = string.format(" %s ", modes[current_mode].name):upper()
  return statusString({
    { modeStr, modes[current_mode].highlight },
  })
end

BRANCHES = {}
local function cacheGitBranch()
  local handle = io.popen("git rev-parse --abbrev-ref HEAD 2> /dev/null")
  if handle == nil then return "" end
  local branch_name = handle:read("*a")
  branch_name = string.gsub(branch_name, "[^%w-_/\\.]", "")
  handle:close()

  if branch_name == nil or branch_name == "" then
    return ""
  else
    BRANCHES[vim.api.nvim_get_current_buf()] = branch_name
    return statusString({
      { "  " .. branch_name .. " ", "statusLineBranch" },
    })
  end
end

local augroupGitBranch = vim.api.nvim_create_augroup("statusLineGitBranchGroup", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  group = augroupGitBranch,
  callback = function() cacheGitBranch() end
})
local function retrieveBranchFromCache()
  local branch_name = BRANCHES[vim.api.nvim_get_current_buf()] or nil
  if branch_name == nil or #(branch_name) < 1 then return "" end
  return statusString({
    { "  " .. branch_name .. " ", "statusLineBranch" },
  })
end

local function lspDiagnosticCounts()
  -- from nvim-lualine/lualine.nvim
  local diagnostics = vim.diagnostic.get(0)
  local count = { 0, 0, 0, 0 }
  for _, diagnostic in ipairs(diagnostics) do
    if vim.startswith(vim.diagnostic.get_namespace(diagnostic.namespace).name, "vim.lsp") then
      count[diagnostic.severity] = count[diagnostic.severity] + 1
    end
  end
  local error_count = count[vim.diagnostic.severity.ERROR]
  local warning_count = count[vim.diagnostic.severity.WARN]
  local info_count = count[vim.diagnostic.severity.INFO]
  local hint_count = count[vim.diagnostic.severity.HINT]
  return table.concat({
    statusString({
      { "  " .. error_count .. " ", "statusLineDiagnosticsError" },
      { " " .. warning_count .. " ", "statusLineDiagnosticsWarning" },
      { " " .. info_count + hint_count .. " ", "statusLineDiagnosticsInfo" },
    })
  })
end

local function filename()
  local file = vim.fn.expand("%:~:.")
  if vim.bo.modified then
    file = file .. statusString({
      { " ● ", "statusLineFileNameModified" },
    })
  end
  return statusString({
    { file, "statusLineFileName" },
  })
end

local function filetype()
  local currentFiletype = vim.bo.filetype
  local filetypeStr = statusString({
    { " " .. currentFiletype .. " ", "statusLineFileType" },
  })

  -- icon
  local filetypeIconStr = ""
  local devicons_loaded, devicons = pcall(require, "nvim-web-devicons")
  if devicons_loaded then
    local icon, color = devicons.get_icon_color_by_filetype(currentFiletype)
    if not (icon and color) then
      icon, color = devicons.get_icon_color(vim.fn.expand("%:t"), currentFiletype)
    end
    if icon and color then
      vim.cmd(
        "highlight! statusLineFileTypeIcon guifg="
        .. color
      )
      filetypeIconStr = statusString({
        { " " .. icon .. " ", "statusLineFileTypeIcon" },
      })
    else
    end
  end
  return filetypeIconStr .. filetypeStr
end

local function lineinfo()
  local lines = vim.api.nvim_buf_line_count(0)
  local currentLine = vim.fn.line(".")
  local currentColumn = vim.fn.col(".")
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

  return statusString({
    { progressStr, "statusLineProgress" },
    { " " .. currentLineStr .. ":" .. currentColumnStr .. " ", "statusLineRowCol" },
  })
end

local function cwd()
  return statusString({
    { "  " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t") .. " ", "statusLineCwd" },
  })
end

local function activeLlspClient()
  local clients = vim.lsp.get_active_clients({ bufnr = 0 })
  if #(clients) == 0 then return "" end
  return statusString({
    { " " .. clients[1].name .. " ", "statusLineLspClient" },
  })
end

local function tabpages()
  local tabStr = ""

  -- some icons look weird if not used in kitty (double width)
  -- so conditionally set the icons
  if vim.g.TERM_EMULATOR == "kitty" then
    tabStr = statusString({
      { " 缾", "statusLineTabNormal" },
    })
  end

  for _, id in ipairs(vim.api.nvim_list_tabpages()) do
    if vim.api.nvim_win_get_tabpage(0) == id then
      tabStr = tabStr .. statusString({
        { " " .. id .. " ", "statuslineTabActive" },
      })
    else
      tabStr = tabStr .. statusString({
        { " " .. id .. " ", "statuslineTabInactive" },
      })
    end
  end

  return tabStr
end

local function kulalaEnv()
  local icon = " 󱂛 "
  local kulala_loaded, kulala = pcall(require, "kulala")
  if not kulala_loaded then return "" end
  local env = kulala.get_selected_env()
  if env == nil then return "" end
  return statusString({
    { " " .. icon .. env .. " ", "statusLineKulalaEnv" },
  })
end

-- make statusline smaller depending on screen size
WINCOLS = nil
local augroupResize = vim.api.nvim_create_augroup("statusLineResizeGroup", { clear = true })
vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = augroupResize,
  callback = function()
    WINCOLS = vim.o.columns
  end
})

local function spacer()
  return statusString({
    { "%=", "statusLineSpacer" },
  })
end

function MyStatusLine()
  local statusline = ""
  if WINCOLS and WINCOLS < 150 then
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
      kulalaEnv(),
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
