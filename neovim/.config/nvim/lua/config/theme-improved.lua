local color_utils = require("config/utils/color-utils")
local adjustColor = color_utils.adjustColor
local colorInterpolate = color_utils.colorInterpolate
local blend = color_utils.blend

local palette = {
  theme          = "tokyonight",
  mode           = "dark",
  accent         = "#f7768e",
  black          = "#15161e",
  grey0          = "#2e303d",
  grey1          = "#464a5c",
  grey2          = "#5f647b",
  grey3          = "#777d99",
  grey4          = "#9097b8",
  grey5          = "#a8b1d7",
  white          = "#c0caf5",
  bright_red     = "#ff8daa",
  neutral_red    = "#f7768e",
  faded_red      = "#db4b4b",
  bright_green   = "#bdf77f",
  neutral_green  = "#9ece6a",
  faded_green    = "#7ea454",
  bright_yellow  = "#ffd27c",
  neutral_yellow = "#e0af68",
  faded_yellow   = "#b38c53",
  bright_blue    = "#92c2ff",
  neutral_blue   = "#6183bb",
  faded_blue     = "#6181c5",
  bright_purple  = "#bb9af7",
  neutral_purple = "#9d7cd8",
  faded_purple   = "#957bc5",
  bright_aqua    = "#7dcfff",
  neutral_aqua   = "#41a6b5",
  faded_aqua     = "#64a5cc",
  bright_orange  = "#ffb093",
  neutral_orange = "#ff9e64",
  faded_orange   = "#914c54",
}

local DEBUG = false

local colors = {}
if DEBUG then
  colors = {
    none = "NONE",
    bg = "#24283b",
    bg_dark = "#1f2335",
    bg_highlight = "#292e42",
    blue = "#7aa2f7",
    blue0 = "#3d59a1",
    blue1 = "#2ac3de",
    blue2 = "#0db9d7",
    blue5 = "#89ddff",
    blue6 = "#b4f9f8",
    blue7 = "#394b70",
    comment = "#565f89",
    cyan = "#7dcfff",
    dark3 = "#545c7e",
    dark5 = "#737aa2",
    fg = "#c0caf5",
    fg_dark = "#a9b1d6",
    fg_gutter = "#3b4261",
    green = "#9ece6a",
    green1 = "#73daca",
    green2 = "#41a6b5",
    magenta = "#bb9af7",
    magenta2 = "#ff007c",
    orange = "#ff9e64",
    purple = "#9d7cd8",
    red = "#f7768e",
    red1 = "#db4b4b",
    teal = "#1abc9c",
    terminal_black = "#414868",
    yellow = "#e0af68",
    git = {
      add = "#449dab",
      change = "#6183bb",
      delete = "#914c54",
    },
  }
else
  local greys = colorInterpolate(palette.black, palette.white, 8)
  colors = {
    none = "NONE",
    bg = greys[1],
    bg_dark = palette.black,
    bg_highlight = greys[2],
    blue = adjustColor(palette.neutral_blue, 3.47, 48.83, 16.67),
    blue0 = adjustColor(palette.neutral_blue, 5.87, 5.22, 12.16),
    blue1 = adjustColor(palette.neutral_blue, -28.33, 33.35, 13.92),
    blue2 = adjustColor(palette.neutral_blue, 28.42, 48.77, 10.98),
    blue5 = adjustColor(palette.neutral_blue, 20.05, 60.18, 21.18),
    blue6 = adjustColor(palette.neutral_blue, 38.20, 45.36, 28.43),
    blue7 = adjustColor(palette.neutral_blue, 3.03, 7.28, 22.55),
    comment = greys[5],
    cyan = palette.bright_aqua,
    dark3 = greys[6],
    dark5 = greys[7],
    fg = palette.white,
    fg_dark = greys[8],
    fg_gutter = greys[3],
    green = palette.neutral_green,
    green1 = adjustColor(palette.neutral_aqua, -27.08, 9.04, 14.06),
    green2 = palette.neutral_aqua,
    magenta = palette.bright_purple,
    magenta2 = adjustColor(palette.bright_purple, 0, 10, 10),
    orange = palette.neutral_orange,
    purple = palette.neutral_purple,
    red = palette.neutral_red,
    red1 = palette.bright_orange,
    teal = adjustColor(palette.neutral_aqua, 19.61, 28.55, 6.27),
    terminal_black = greys[4],
    yellow = palette.neutral_yellow,
    git = {
      add = adjustColor(palette.neutral_aqua, 0.40, 4.06, 1.37),
      change = palette.neutral_blue,
      delete = palette.faded_orange,
    },
  }
end

local function blend_bg(foreground, alpha, background)
  return blend(foreground, alpha, background or colors.bg)
end

local function blend_fg(hex, amount, fg)
  return blend(hex, amount, fg or colors.fg)
end

colors.diff = {
  add = blend_bg(colors.green2, 0.15),
  delete = blend_bg(colors.red1, 0.15),
  change = blend_bg(colors.blue7, 0.15),
  text = colors.blue7,
}

colors.git.ignore = colors.dark3
colors.black = blend_bg(colors.bg, 0.8, "#000000")
colors.border_highlight = blend_bg(colors.blue1, 0.8)
colors.border = colors.black

colors.bg_popup = colors.bg_dark
colors.bg_statusline = colors.bg_dark
colors.bg_sidebar = colors.none
colors.bg_float = colors.bg_dark
colors.bg_visual = blend_bg(colors.blue0, 0.4)
colors.bg_search = colors.blue0
colors.fg_sidebar = colors.fg_dark
colors.fg_float = colors.fg

colors.error = colors.red1
colors.todo = colors.blue
colors.warning = colors.yellow
colors.info = colors.blue2
colors.hint = colors.teal

colors.rainbow = {
  colors.blue,
  colors.yellow,
  colors.green,
  colors.teal,
  colors.magenta,
  colors.purple,
}

local highlightGroups = {
  -- base
  Comment                                    = { fg = colors.comment, italic = true },            -- any comment
  ColorColumn                                = { bg = colors.black },                             -- used for the columns set with 'colorcolumn'
  Conceal                                    = { fg = colors.dark5 },                             -- placeholder characters substituted for concealed text (see 'conceallevel')
  Cursor                                     = { fg = colors.bg, bg = colors.fg },                -- character under the cursor
  lCursor                                    = { fg = colors.bg, bg = colors.fg },                -- the character under the cursor when |language-mapping| is used (see 'guicursor')
  CursorIM                                   = { fg = colors.bg, bg = colors.fg },                -- like Cursor, but used when in IME mode |CursorIM|
  CursorColumn                               = { bg = colors.bg_highlight },                      -- Screen-column at the cursor, when 'cursorcolumn' is set.
  CursorLine                                 = { bg = colors.bg_highlight },                      -- Screen-line at the cursor, when 'cursorline' is set.  Low-priority if foreground (ctermfg OR guifg) is not set.
  Directory                                  = { fg = colors.blue },                              -- directory names (and other special names in listings)
  DiffAdd                                    = { bg = colors.diff.add },                          -- diff mode: Added line |diff.txt|
  DiffChange                                 = { bg = colors.diff.change },                       -- diff mode: Changed line |diff.txt|
  DiffDelete                                 = { bg = colors.diff.delete },                       -- diff mode: Deleted line |diff.txt|
  DiffText                                   = { bg = colors.diff.text },                         -- diff mode: Changed text within a changed line |diff.txt|
  EndOfBuffer                                = { fg = colors.bg },                                -- filler lines (~) after the end of the buffer.  By default, this is highlighted like |hl-NonText|.
  ErrorMsg                                   = { fg = colors.error },                             -- error messages on the command line
  VertSplit                                  = { fg = colors.border },                            -- the column separating vertically split windows
  WinSeparator                               = { fg = colors.border, bold = true },               -- the column separating vertically split windows
  Folded                                     = { fg = colors.blue, bg = colors.fg_gutter },       -- line used for closed folds
  FoldColumn                                 = { bg = colors.none, fg = colors.comment },         -- 'foldcolumn'
  SignColumn                                 = { bg = colors.none, fg = colors.fg_gutter },       -- column where |signs| are displayed
  SignColumnSB                               = { bg = colors.bg_sidebar, fg = colors.fg_gutter }, -- column where |signs| are displayed
  Substitute                                 = { bg = colors.red, fg = colors.black },            -- |:substitute| replacement text highlighting
  LineNr                                     = { fg = colors.fg_gutter },                         -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
  CursorLineNr                               = { fg = colors.orange, bold = true },               -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
  LineNrAbove                                = { fg = colors.fg_gutter },
  LineNrBelow                                = { fg = colors.fg_gutter },
  MatchParen                                 = { fg = colors.orange, bold = true },                -- The character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
  ModeMsg                                    = { fg = colors.fg_dark, bold = true },               -- 'showmode' message (e.g., "-- INSERT -- ")
  MsgArea                                    = { fg = colors.fg_dark },                            -- Area for messages and cmdline
  MoreMsg                                    = { fg = colors.blue },                               -- |more-prompt|
  NonText                                    = { fg = colors.dark3 },                              -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
  Normal                                     = { fg = colors.fg, bg = colors.none },               -- normal text
  NormalNC                                   = { fg = colors.fg, bg = colors.none },               -- normal text in non-current windows
  NormalSB                                   = { fg = colors.fg_sidebar, bg = colors.bg_sidebar }, -- normal text in sidebar
  NormalFloat                                = { fg = colors.fg_float, bg = colors.bg_float },     -- Normal text in floating windows.
  FloatBorder                                = { fg = colors.border_highlight, bg = colors.bg_float },
  FloatTitle                                 = { fg = colors.border_highlight, bg = colors.bg_float },
  Pmenu                                      = { bg = colors.bg_popup, fg = colors.fg },                    -- Popup menu: normal item.
  PmenuMatch                                 = { bg = colors.bg_popup, fg = colors.blue1 },                 -- Popup menu: Matched text in normal item.
  PmenuSel                                   = { bg = blend_bg(colors.fg_gutter, 0.8) },                    -- Popup menu: selected item.
  PmenuMatchSel                              = { bg = blend_bg(colors.fg_gutter, 0.8), fg = colors.blue1 }, -- Popup menu: Matched text in selected item.
  PmenuSbar                                  = { bg = blend_fg(colors.bg_popup, 0.95) },                    -- Popup menu: scrollbar.
  PmenuThumb                                 = { bg = colors.fg_gutter },                                   -- Popup menu: Thumb of the scrollbar.
  Question                                   = { fg = colors.blue },                                        -- |hit-enter| prompt and yes/no questions
  QuickFixLine                               = { bg = colors.bg_visual, bold = true },                      -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
  Search                                     = { bg = colors.bg_search, fg = colors.fg },                   -- Last search pattern highlighting (see 'hlsearch').  Also used for similar items that need to stand out.
  IncSearch                                  = { bg = colors.orange, fg = colors.black },                   -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
  CurSearch                                  = "IncSearch",
  SpecialKey                                 = { fg = colors.dark3 },                                       -- Unprintable characters: text displayed differently from what it really is.  But not 'listchars' whitespace. |hl-Whitespace|
  SpellBad                                   = { sp = colors.error, undercurl = true },                     -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
  SpellCap                                   = { sp = colors.warning, undercurl = true },                   -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
  SpellLocal                                 = { sp = colors.info, undercurl = true },                      -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
  SpellRare                                  = { sp = colors.hint, undercurl = true },                      -- Word that is recognized by the spellchecker as one that is hardly ever used.  |spell| Combined with the highlighting used otherwise.
  StatusLine                                 = { fg = colors.fg_sidebar, bg = colors.bg_statusline },       -- status line of current window
  StatusLineNC                               = { fg = colors.fg_gutter, bg = colors.bg_statusline },        -- status lines of not-current windows Note: if this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
  TabLine                                    = { bg = colors.bg_statusline, fg = colors.fg_gutter },        -- tab pages line, not active tab page label
  TabLineFill                                = { bg = colors.black },                                       -- tab pages line, where there are no labels
  TabLineSel                                 = { fg = colors.black, bg = colors.blue },                     -- tab pages line, active tab page label
  Title                                      = { fg = colors.blue, bold = true },                           -- titles for output from ":set all", ":autocmd" etc.
  Visual                                     = { bg = colors.bg_visual },                                   -- Visual mode selection
  VisualNOS                                  = { bg = colors.bg_visual },                                   -- Visual mode selection when vim is "Not Owning the Selection".
  WarningMsg                                 = { fg = colors.warning },                                     -- warning messages
  Whitespace                                 = { fg = colors.fg_gutter },                                   -- "nbsp", "space", "tab" and "trail" in 'listchars'
  WildMenu                                   = { bg = colors.bg_visual },                                   -- current match in 'wildmenu' completion
  WinBar                                     = "StatusLine",                                                -- window bar
  WinBarNC                                   = "StatusLineNC",                                              -- window bar in inactive windows

  Bold                                       = { bold = true, fg = colors.fg },                             -- (preferred) any bold text
  Character                                  = { fg = colors.green },                                       --  a character constant: 'c', '\n'
  Constant                                   = { fg = colors.orange },                                      -- (preferred) any constant
  Debug                                      = { fg = colors.orange },                                      --    debugging statements
  Delimiter                                  = "Special",                                                   --  character that needs attention
  Error                                      = { fg = colors.error },                                       -- (preferred) any erroneous construct
  Function                                   = { fg = colors.blue },                                        -- function name (also: methods for classes)
  Identifier                                 = { fg = colors.magenta },                                     -- (preferred) any variable name
  Italic                                     = { italic = true, fg = colors.fg },                           -- (preferred) any italic text
  Keyword                                    = { fg = colors.cyan, italic = true },                         --  any other keyword
  Operator                                   = { fg = colors.blue5 },                                       -- "sizeof", "+", "*", etc.
  PreProc                                    = { fg = colors.cyan },                                        -- (preferred) generic Preprocessor
  Special                                    = { fg = colors.blue1 },                                       -- (preferred) any special symbol
  Statement                                  = { fg = colors.magenta },                                     -- (preferred) any statement
  String                                     = { fg = colors.green },                                       --   a string constant: "this is a string"
  Todo                                       = { bg = colors.yellow, fg = colors.bg },                      -- (preferred) anything that needs extra attention; mostly the keywords TODO FIXME and XXX
  Type                                       = { fg = colors.blue1 },                                       -- (preferred) int, long, char, etc.
  Underlined                                 = { underline = true },                                        -- (preferred) text that stands out, HTML links
  debugBreakpoint                            = { bg = blend_bg(colors.info, 0.1), fg = colors.info },       -- used for breakpoint colors in terminal-debug
  debugPC                                    = { bg = colors.bg_sidebar },                                  -- used for highlighting the current line in terminal-debug
  dosIniLabel                                = "@property",
  helpCommand                                = { bg = colors.terminal_black, fg = colors.blue },
  htmlH1                                     = { fg = colors.magenta, bold = true },
  htmlH2                                     = { fg = colors.blue, bold = true },
  qfFileName                                 = { fg = colors.blue },
  qfLineNr                                   = { fg = colors.dark5 },

  -- These groups are for the native LSP client. Some other LSP clients may
  -- use these groups, or use their own.
  LspReferenceText                           = { bg = colors.fg_gutter }, -- used for highlighting "text" references
  LspReferenceRead                           = { bg = colors.fg_gutter }, -- used for highlighting "read" references
  LspReferenceWrite                          = { bg = colors.fg_gutter }, -- used for highlighting "write" references
  LspSignatureActiveParameter                = { bg = blend_bg(colors.bg_visual, 0.4), bold = true },
  LspCodeLens                                = { fg = colors.comment },
  LspInlayHint                               = { bg = blend_bg(colors.blue7, 0.1), fg = colors.dark3 },
  LspInfoBorder                              = { fg = colors.border_highlight, bg = colors.bg_float },

  -- diagnostics
  DiagnosticError                            = { fg = colors.error },                                       -- Used as the base highlight group. Other Diagnostic highlights link to this by default
  DiagnosticWarn                             = { fg = colors.warning },                                     -- Used as the base highlight group. Other Diagnostic highlights link to this by default
  DiagnosticInfo                             = { fg = colors.info },                                        -- Used as the base highlight group. Other Diagnostic highlights link to this by default
  DiagnosticHint                             = { fg = colors.hint },                                        -- Used as the base highlight group. Other Diagnostic highlights link to this by default
  DiagnosticUnnecessary                      = { fg = colors.terminal_black },                              -- Used as the base highlight group. Other Diagnostic highlights link to this by default
  DiagnosticVirtualTextError                 = { bg = blend_bg(colors.error, 0.1), fg = colors.error },     -- Used for "Error" diagnostic virtual text
  DiagnosticVirtualTextWarn                  = { bg = blend_bg(colors.warning, 0.1), fg = colors.warning }, -- Used for "Warning" diagnostic virtual text
  DiagnosticVirtualTextInfo                  = { bg = blend_bg(colors.info, 0.1), fg = colors.info },       -- Used for "Information" diagnostic virtual text
  DiagnosticVirtualTextHint                  = { bg = blend_bg(colors.hint, 0.1), fg = colors.hint },       -- Used for "Hint" diagnostic virtual text
  DiagnosticUnderlineError                   = { undercurl = true, sp = colors.error },                     -- Used to underline "Error" diagnostics
  DiagnosticUnderlineWarn                    = { undercurl = true, sp = colors.warning },                   -- Used to underline "Warning" diagnostics
  DiagnosticUnderlineInfo                    = { undercurl = true, sp = colors.info },                      -- Used to underline "Information" diagnostics
  DiagnosticUnderlineHint                    = { undercurl = true, sp = colors.hint },                      -- Used to underline "Hint" diagnostics

  -- Health
  healthError                                = { fg = colors.error },
  healthSuccess                              = { fg = colors.green1 },
  healthWarning                              = { fg = colors.warning },

  -- diff (not needed anymore?)
  diffAdded                                  = { fg = colors.git.add },
  diffRemoved                                = { fg = colors.git.delete },
  diffChanged                                = { fg = colors.git.change },
  diffOldFile                                = { fg = colors.yellow },
  diffNewFile                                = { fg = colors.orange },
  diffFile                                   = { fg = colors.blue },
  diffLine                                   = { fg = colors.comment },
  diffIndexLine                              = { fg = colors.magenta },
  helpExample                                = { fg = colors.comment },

  -- bufferline
  BufferLineIndicatorSelected                = { fg = colors.git.change },

  -- cmp
  CmpDocumentation                           = { fg = colors.fg, bg = colors.bg_float },
  CmpDocumentationBorder                     = { fg = colors.border_highlight, bg = colors.bg_float },
  CmpGhostText                               = { fg = colors.terminal_black },
  CmpItemAbbr                                = { fg = colors.fg, bg = colors.none },
  CmpItemAbbrDeprecated                      = { fg = colors.fg_gutter, bg = colors.none, strikethrough = true },
  CmpItemAbbrMatch                           = { fg = colors.blue1, bg = colors.none },
  CmpItemAbbrMatchFuzzy                      = { fg = colors.blue1, bg = colors.none },
  CmpItemKindCodeium                         = { fg = colors.teal, bg = colors.none },
  CmpItemKindCopilot                         = { fg = colors.teal, bg = colors.none },
  CmpItemKindSupermaven                      = { fg = colors.teal, bg = colors.none },
  CmpItemKindDefault                         = { fg = colors.fg_dark, bg = colors.none },
  CmpItemKindTabNine                         = { fg = colors.teal, bg = colors.none },
  CmpItemMenu                                = { fg = colors.comment, bg = colors.none },

  -- dashboard
  -- General
  DashboardHeader                            = { fg = colors.blue },
  DashboardFooter                            = { fg = colors.blue1 },
  -- Hyper theme
  DashboardProjectTitle                      = { fg = colors.cyan },
  DashboardProjectTitleIcon                  = { fg = colors.orange },
  DashboardProjectIcon                       = { fg = colors.yellow },
  DashboardMruTitle                          = { fg = colors.cyan },
  DashboardMruIcon                           = { fg = colors.purple },
  DashboardFiles                             = { fg = colors.blue },
  DashboardShortCutIcon                      = { fg = colors.magenta },
  -- Doome theme
  DashboardDesc                              = { fg = colors.cyan },
  DashboardKey                               = { fg = colors.orange },
  DashboardIcon                              = { fg = colors.cyan, bold = true },
  DashboardShortCut                          = { fg = colors.cyan },

  -- gitgutter
  GitGutterAdd                               = { fg = colors.git.add },    -- diff mode: Added line |diff.txt|
  GitGutterChange                            = { fg = colors.git.change }, -- diff mode: Changed line |diff.txt|
  GitGutterDelete                            = { fg = colors.git.delete }, -- diff mode: Deleted line |diff.txt|
  GitGutterAddLineNr                         = { fg = colors.git.add },
  GitGutterChangeLineNr                      = { fg = colors.git.change },
  GitGutterDeleteLineNr                      = { fg = colors.git.delete },

  -- gitsigns
  GitSignsAdd                                = { fg = colors.git.add },    -- diff mode: Added line |diff.txt|
  GitSignsChange                             = { fg = colors.git.change }, -- diff mode: Changed line |diff.txt|
  GitSignsDelete                             = { fg = colors.git.delete }, -- diff mode: Deleted line |diff.txt|

  -- glyph-palette
  GlyphPalette1                              = { fg = colors.red1 },
  GlyphPalette2                              = { fg = colors.green },
  GlyphPalette3                              = { fg = colors.yellow },
  GlyphPalette4                              = { fg = colors.blue },
  GlyphPalette6                              = { fg = colors.green1 },
  GlyphPalette7                              = { fg = colors.fg },
  GlyphPalette9                              = { fg = colors.red },

  -- lazy
  LazyProgressDone                           = { bold = true, fg = colors.magenta2 },
  LazyProgressTodo                           = { bold = true, fg = colors.fg_gutter },

  -- notify
  NotifyBackground                           = { fg = colors.fg, bg = colors.bg },
  NotifyDEBUGBody                            = { fg = colors.fg, bg = colors.none },
  NotifyDEBUGBorder                          = { fg = blend_bg(colors.comment, 0.3), bg = colors.none },
  NotifyDEBUGIcon                            = { fg = colors.comment },
  NotifyDEBUGTitle                           = { fg = colors.comment },
  NotifyERRORBody                            = { fg = colors.fg, bg = colors.none },
  NotifyERRORBorder                          = { fg = blend_bg(colors.error, 0.3), bg = colors.none },
  NotifyERRORIcon                            = { fg = colors.error },
  NotifyERRORTitle                           = { fg = colors.error },
  NotifyINFOBody                             = { fg = colors.fg, bg = colors.none },
  NotifyINFOBorder                           = { fg = blend_bg(colors.info, 0.3), bg = colors.none },
  NotifyINFOIcon                             = { fg = colors.info },
  NotifyINFOTitle                            = { fg = colors.info },
  NotifyTRACEBody                            = { fg = colors.fg, bg = colors.none },
  NotifyTRACEBorder                          = { fg = blend_bg(colors.purple, 0.3), bg = colors.none },
  NotifyTRACEIcon                            = { fg = colors.purple },
  NotifyTRACETitle                           = { fg = colors.purple },
  NotifyWARNBody                             = { fg = colors.fg, bg = colors.none },
  NotifyWARNBorder                           = { fg = blend_bg(colors.warning, 0.3), bg = colors.none },
  NotifyWARNIcon                             = { fg = colors.warning },
  NotifyWARNTitle                            = { fg = colors.warning },

  -- nvim-tree
  NvimTreeFolderIcon                         = { bg = colors.none, fg = colors.blue },
  NvimTreeGitDeleted                         = { fg = colors.git.delete },
  NvimTreeGitDirty                           = { fg = colors.git.change },
  NvimTreeGitNew                             = { fg = colors.git.add },
  NvimTreeImageFile                          = { fg = colors.fg_sidebar },
  NvimTreeIndentMarker                       = { fg = colors.fg_gutter },
  NvimTreeNormal                             = { fg = colors.fg_sidebar, bg = colors.bg_sidebar },
  NvimTreeNormalNC                           = { fg = colors.fg_sidebar, bg = colors.bg_sidebar },
  NvimTreeOpenedFile                         = { bg = colors.bg_highlight },
  NvimTreeRootFolder                         = { fg = colors.blue, bold = true },
  NvimTreeSpecialFile                        = { fg = colors.purple, underline = true },
  NvimTreeSymlink                            = { fg = colors.blue },
  NvimTreeWinSeparator                       = { fg = colors.border, bg = colors.bg_sidebar },

  -- octo
  OctoDetailsLabel                           = { fg = colors.blue1, bold = true },
  OctoDetailsValue                           = "@variable.member",
  OctoDirty                                  = { fg = colors.orange, bold = true },
  OctoIssueTitle                             = { fg = colors.purple, bold = true },
  OctoStateChangesRequested                  = "DiagnosticVirtualTextWarn",
  OctoStateClosed                            = "DiagnosticVirtualTextError",
  OctoStateMerged                            = { bg = blend_bg(colors.magenta, 0.1), fg = colors.magenta },
  OctoStateOpen                              = "DiagnosticVirtualTextHint",
  OctoStatePending                           = "DiagnosticVirtualTextWarn",
  OctoStatusColumn                           = { fg = colors.blue1 },

  -- rainbow-delimiters
  RainbowDelimiterRed                        = { fg = colors.red },
  RainbowDelimiterOrange                     = { fg = colors.orange },
  RainbowDelimiterYellow                     = { fg = colors.yellow },
  RainbowDelimiterGreen                      = { fg = colors.green },
  RainbowDelimiterBlue                       = { fg = colors.blue },
  RainbowDelimiterViolet                     = { fg = colors.purple },
  RainbowDelimiterCyan                       = { fg = colors.cyan },

  -- semantic_tokens
  ["@lsp.type.boolean"]                      = "@boolean",
  ["@lsp.type.builtinType"]                  = "@type.builtin",
  ["@lsp.type.comment"]                      = "@comment",
  ["@lsp.type.decorator"]                    = "@attribute",
  ["@lsp.type.deriveHelper"]                 = "@attribute",
  ["@lsp.type.enum"]                         = "@type",
  ["@lsp.type.enumMember"]                   = "@constant",
  ["@lsp.type.escapeSequence"]               = "@string.escape",
  ["@lsp.type.formatSpecifier"]              = "@markup.list",
  ["@lsp.type.generic"]                      = "@variable",
  ["@lsp.type.interface"]                    = { fg = blend_fg(colors.blue1, 0.7) },
  ["@lsp.type.keyword"]                      = "@keyword",
  ["@lsp.type.lifetime"]                     = "@keyword.storage",
  ["@lsp.type.namespace"]                    = "@module",
  ["@lsp.type.namespace.python"]             = "@variable",
  ["@lsp.type.number"]                       = "@number",
  ["@lsp.type.operator"]                     = "@operator",
  ["@lsp.type.parameter"]                    = "@variable.parameter",
  ["@lsp.type.property"]                     = "@property",
  ["@lsp.type.selfKeyword"]                  = "@variable.builtin",
  ["@lsp.type.selfTypeKeyword"]              = "@variable.builtin",
  ["@lsp.type.string"]                       = "@string",
  ["@lsp.type.typeAlias"]                    = "@type.definition",
  ["@lsp.type.unresolvedReference"]          = { undercurl = true, sp = colors.error },
  ["@lsp.type.variable"]                     = {}, -- use treesitter styles for regular variables
  ["@lsp.typemod.class.defaultLibrary"]      = "@type.builtin",
  ["@lsp.typemod.enum.defaultLibrary"]       = "@type.builtin",
  ["@lsp.typemod.enumMember.defaultLibrary"] = "@constant.builtin",
  ["@lsp.typemod.function.defaultLibrary"]   = "@function.builtin",
  ["@lsp.typemod.keyword.async"]             = "@keyword.coroutine",
  ["@lsp.typemod.keyword.injected"]          = "@keyword",
  ["@lsp.typemod.macro.defaultLibrary"]      = "@function.builtin",
  ["@lsp.typemod.method.defaultLibrary"]     = "@function.builtin",
  ["@lsp.typemod.operator.injected"]         = "@operator",
  ["@lsp.typemod.string.injected"]           = "@string",
  ["@lsp.typemod.struct.defaultLibrary"]     = "@type.builtin",
  ["@lsp.typemod.type.defaultLibrary"]       = { fg = blend_bg(colors.blue1, 0.8) },
  ["@lsp.typemod.typeAlias.defaultLibrary"]  = { fg = blend_bg(colors.blue1, 0.8) },
  ["@lsp.typemod.variable.callable"]         = "@function",
  ["@lsp.typemod.variable.defaultLibrary"]   = "@variable.builtin",
  ["@lsp.typemod.variable.injected"]         = "@variable",
  ["@lsp.typemod.variable.static"]           = "@constant",

  -- telescope
  TelescopeBorder                            = { fg = colors.border_highlight, bg = colors.bg_float },
  TelescopeNormal                            = { fg = colors.fg, bg = colors.bg_float },
  TelescopePromptBorder                      = { fg = colors.orange, bg = colors.bg_float },
  TelescopePromptTitle                       = { fg = colors.orange, bg = colors.bg_float },
  TelescopeResultsComment                    = { fg = colors.dark3 },

  -- treesitter-context
  TreesitterContext                          = { bg = blend_bg(colors.fg_gutter, 0.8) },

  -- treesitter
  ["@annotation"]                            = "PreProc",
  ["@attribute"]                             = "PreProc",
  ["@boolean"]                               = "Boolean",
  ["@character"]                             = "Character",
  ["@character.printf"]                      = "SpecialChar",
  ["@character.special"]                     = "SpecialChar",
  ["@comment"]                               = "Comment",
  ["@comment.error"]                         = { fg = colors.error },
  ["@comment.hint"]                          = { fg = colors.hint },
  ["@comment.info"]                          = { fg = colors.info },
  ["@comment.note"]                          = { fg = colors.hint },
  ["@comment.todo"]                          = { fg = colors.todo },
  ["@comment.warning"]                       = { fg = colors.warning },
  ["@constant"]                              = "Constant",
  ["@constant.builtin"]                      = "Special",
  ["@constant.macro"]                        = "Define",
  ["@constructor"]                           = { fg = colors.magenta }, -- For constructor calls and definitions: `= { }` in Lua, and Java constructors.
  ["@constructor.tsx"]                       = { fg = colors.blue1 },
  ["@diff.delta"]                            = "DiffChange",
  ["@diff.minus"]                            = "DiffDelete",
  ["@diff.plus"]                             = "DiffAdd",
  ["@function"]                              = "Function",
  ["@function.builtin"]                      = "Special",
  ["@function.call"]                         = "@function",
  ["@function.macro"]                        = "Macro",
  ["@function.method"]                       = "Function",
  ["@function.method.call"]                  = "@function.method",
  ["@keyword"]                               = { fg = colors.purple, italic = true }, -- For keywords that don't fall in previous categories.
  ["@keyword.conditional"]                   = "Conditional",
  ["@keyword.coroutine"]                     = "@keyword",
  ["@keyword.debug"]                         = "Debug",
  ["@keyword.directive"]                     = "PreProc",
  ["@keyword.directive.define"]              = "Define",
  ["@keyword.exception"]                     = "Exception",
  ["@keyword.function"]                      = { fg = colors.magenta }, -- For keywords used to define a function.
  ["@keyword.import"]                        = "Include",
  ["@keyword.operator"]                      = "@operator",
  ["@keyword.repeat"]                        = "Repeat",
  ["@keyword.return"]                        = "@keyword",
  ["@keyword.storage"]                       = "StorageClass",
  ["@label"]                                 = { fg = colors.blue }, -- For labels: `label:` in C and `:label:` in Lua.
  ["@markup"]                                = "@none",
  ["@markup.emphasis"]                       = { italic = true },
  ["@markup.environment"]                    = "Macro",
  ["@markup.environment.name"]               = "Type",
  ["@markup.heading"]                        = "Title",
  ["@markup.heading.1.markdown"]             = { fg = colors.rainbow[1], bold = true },
  ["@markup.heading.2.markdown"]             = { fg = colors.rainbow[2], bold = true },
  ["@markup.heading.3.markdown"]             = { fg = colors.rainbow[3], bold = true },
  ["@markup.heading.4.markdown"]             = { fg = colors.rainbow[4], bold = true },
  ["@markup.heading.5.markdown"]             = { fg = colors.rainbow[5], bold = true },
  ["@markup.heading.6.markdown"]             = { fg = colors.rainbow[6], bold = true },
  ["@markup.italic"]                         = { italic = true },
  ["@markup.link"]                           = { fg = colors.teal },
  ["@markup.link.label"]                     = "SpecialChar",
  ["@markup.link.label.symbol"]              = "Identifier",
  ["@markup.link.url"]                       = "Underlined",
  ["@markup.list"]                           = { fg = colors.blue5 },  -- For special punctutation that does not fall in the categories before.
  ["@markup.list.checked"]                   = { fg = colors.green1 }, -- For brackets and parens.
  ["@markup.list.markdown"]                  = { fg = colors.orange, bold = true },
  ["@markup.list.unchecked"]                 = { fg = colors.blue },   -- For brackets and parens.
  ["@markup.math"]                           = "Special",
  ["@markup.raw"]                            = "String",
  ["@markup.raw.markdown_inline"]            = { bg = colors.terminal_black, fg = colors.blue },
  ["@markup.strikethrough"]                  = { strikethrough = true },
  ["@markup.strong"]                         = { bold = true },
  ["@markup.underline"]                      = { underline = true },
  ["@module"]                                = "Include",
  ["@module.builtin"]                        = { fg = colors.red }, -- Variable names that are defined by the languages, like `this` or `self`.
  ["@namespace.builtin"]                     = "@variable.builtin",
  ["@none"]                                  = {},
  ["@number"]                                = "Number",
  ["@number.float"]                          = "Float",
  ["@operator"]                              = { fg = colors.blue5 },   -- For any operator: `+`, but also `->` and `*` in C.
  ["@property"]                              = { fg = colors.green1 },
  ["@punctuation.bracket"]                   = { fg = colors.fg_dark }, -- For brackets and parens.
  ["@punctuation.delimiter"]                 = { fg = colors.blue5 },   -- For delimiters ie: `.`
  ["@punctuation.special"]                   = { fg = colors.blue5 },   -- For special symbols (e.g. `{}` in string interpolation)
  ["@string"]                                = "String",
  ["@string.documentation"]                  = { fg = colors.yellow },
  ["@string.escape"]                         = { fg = colors.magenta }, -- For escape characters within a string.
  ["@string.regexp"]                         = { fg = colors.blue6 },   -- For regexes.
  ["@tag"]                                   = "Label",
  ["@tag.attribute"]                         = "@property",
  ["@tag.delimiter"]                         = "Delimiter",
  ["@tag.delimiter.tsx"]                     = { fg = blend_bg(colors.blue, 0.7) },
  ["@tag.tsx"]                               = { fg = colors.red },
  ["@tag.javascript"]                        = { fg = colors.red },
  ["@type"]                                  = "Type",
  ["@type.builtin"]                          = { fg = blend_bg(colors.blue1, 0.8) },
  ["@type.definition"]                       = "Typedef",
  ["@type.qualifier"]                        = "@keyword",
  ["@variable"]                              = { fg = colors.fg },                    -- Any variable name that does not have another highlight.
  ["@variable.builtin"]                      = { fg = colors.red },                   -- Variable names that are defined by the languages, like `this` or `self`.
  ["@variable.member"]                       = { fg = colors.green1 },                -- For fields.
  ["@variable.parameter"]                    = { fg = colors.yellow },                -- For parameters of a function.
  ["@variable.parameter.builtin"]            = { fg = blend_fg(colors.yellow, 0.8) }, -- For builtin parameters of a function, e.g. "..." or Smali's p[1-99]

  -- kinds
  LspKindArray                               = "@punctuation.bracket",
  LspKindBoolean                             = "@boolean",
  LspKindClass                               = "@type",
  LspKindColor                               = "Special",
  LspKindConstant                            = "@constant",
  LspKindConstructor                         = "@constructor",
  LspKindEnum                                = "@lsp.type.enum",
  LspKindEnumMember                          = "@lsp.type.enumMember",
  LspKindEvent                               = "Special",
  LspKindField                               = "@variable.member",
  LspKindFile                                = "Normal",
  LspKindFolder                              = "Directory",
  LspKindFunction                            = "@function",
  LspKindInterface                           = "@lsp.type.interface",
  LspKindKey                                 = "@variable.member",
  LspKindKeyword                             = "@lsp.type.keyword",
  LspKindMethod                              = "@function.method",
  LspKindModule                              = "@module",
  LspKindNamespace                           = "@module",
  LspKindNull                                = "@constant.builtin",
  LspKindNumber                              = "@number",
  LspKindObject                              = "@constant",
  LspKindOperator                            = "@operator",
  LspKindPackage                             = "@module",
  LspKindProperty                            = "@property",
  LspKindReference                           = "@markup.link",
  LspKindSnippet                             = "Conceal",
  LspKindString                              = "@string",
  LspKindStruct                              = "@lsp.type.struct",
  LspKindUnit                                = "@lsp.type.struct",
  LspKindText                                = "@markup",
  LspKindTypeParameter                       = "@lsp.type.typeParameter",
  LspKindVariable                            = "@variable",
  LspKindValue                               = "@string",

  -- winbar
  winbarFileName                             = { fg = palette.black, bg = palette.accent, bold = true },
  winbarFileNameModified                     = { fg = palette.black, bg = palette.neutral_aqua },
  winbarTags                                 = { fg = palette.white, bg = palette.grey1 },
  NavicText                                  = { fg = palette.white, bg = palette.grey1 },
  NavicSeparator                             = { fg = palette.bright_orange, bg = palette.grey1 },
  NavicIconsArray                            = { fg = palette.bright_green, bg = palette.grey1 },
  NavicIconsBoolean                          = { fg = palette.bright_green, bg = palette.grey1 },
  NavicIconsClass                            = { fg = palette.bright_green, bg = palette.grey1 },
  NavicIconsConstant                         = { fg = palette.bright_green, bg = palette.grey1 },
  NavicIconsConstructor                      = { fg = palette.bright_green, bg = palette.grey1 },
  NavicIconsEnum                             = { fg = palette.bright_green, bg = palette.grey1 },
  NavicIconsEnumMember                       = { fg = palette.bright_green, bg = palette.grey1 },
  NavicIconsEvent                            = { fg = palette.bright_green, bg = palette.grey1 },
  NavicIconsField                            = { fg = palette.bright_green, bg = palette.grey1 },
  NavicIconsFile                             = { fg = palette.bright_green, bg = palette.grey1 },
  NavicIconsFunction                         = { fg = palette.bright_green, bg = palette.grey1 },
  NavicIconsInterface                        = { fg = palette.bright_green, bg = palette.grey1 },
  NavicIconsKey                              = { fg = palette.bright_green, bg = palette.grey1 },
  NavicIconsMethod                           = { fg = palette.bright_green, bg = palette.grey1 },
  NavicIconsModule                           = { fg = palette.bright_green, bg = palette.grey1 },
  NavicIconsNamespace                        = { fg = palette.bright_green, bg = palette.grey1 },
  NavicIconsNull                             = { fg = palette.bright_green, bg = palette.grey1 },
  NavicIconsNumber                           = { fg = palette.bright_green, bg = palette.grey1 },
  NavicIconsObject                           = { fg = palette.bright_green, bg = palette.grey1 },
  NavicIconsOperator                         = { fg = palette.bright_green, bg = palette.grey1 },
  NavicIconsPackage                          = { fg = palette.bright_green, bg = palette.grey1 },
  NavicIconsProperty                         = { fg = palette.bright_green, bg = palette.grey1 },
  NavicIconsString                           = { fg = palette.bright_green, bg = palette.grey1 },
  NavicIconsStruct                           = { fg = palette.bright_green, bg = palette.grey1 },
  NavicIconsTypeParameter                    = { fg = palette.bright_green, bg = palette.grey1 },
  NavicIconsVariable                         = { fg = palette.bright_green, bg = palette.grey1 },

  -- statusline
  statusLineModeNormal                       = { fg = palette.grey0, bg = palette.bright_aqua, bold = true },
  statusLineModeInsert                       = { fg = palette.grey0, bg = palette.bright_blue, bold = true },
  statusLineModeVisual                       = { fg = palette.grey0, bg = palette.bright_orange, bold = true },
  statusLineModeCommand                      = { fg = palette.grey0, bg = palette.bright_yellow, bold = true },
  statusLineModeTerminal                     = { fg = palette.grey0, bg = palette.bright_purple, bold = true },
  statusLineTabNormal                        = { fg = palette.white, bg = palette.grey0 },
  statuslineTabActive                        = { fg = palette.grey0, bg = palette.accent },
  statuslineTabInactive                      = { fg = palette.white, bg = palette.grey2 },
  statusLineBranch                           = { fg = palette.white, bg = palette.grey0, bold = true },
  statusLineCwd                              = { fg = palette.bright_blue, bg = palette.grey0 },
  statusLineFileName                         = { fg = palette.bright_aqua, bg = palette.grey0 },
  statusLineFileNameModified                 = { fg = palette.bright_red, bg = palette.grey0 },
  statusLineSpacer                           = { fg = palette.white, bg = palette.grey0 },
  statusLineDiagnosticsError                 = { fg = palette.bright_red, bg = palette.grey0 },
  statusLineDiagnosticsWarning               = { fg = palette.bright_yellow, bg = palette.grey0 },
  statusLineDiagnosticsInfo                  = { bg = palette.grey0, fg = palette.bright_aqua },
  statusLineLspClient                        = { bg = palette.grey0, fg = palette.bright_orange },
  statusLineFileType                         = { fg = palette.white, bg = palette.grey0 },
  statusLineProgress                         = { bg = palette.bright_yellow, fg = palette.grey3 },
  statusLineRowCol                           = { fg = palette.bright_aqua, bg = palette.grey0, bold = true },
  flagBlue                                   = { fg = palette.grey0, bg = palette.neutral_blue, bold = true },
  flagYellow                                 = { fg = palette.grey0, bg = palette.neutral_yellow, bold = true },
  flagOrange                                 = { fg = palette.grey0, bg = palette.neutral_orange, bold = true },
  flagRed                                    = { fg = palette.grey0, bg = palette.neutral_red, bold = true },
  statusLineFileTypeIcon                     = { bg = palette.grey0 },
  statusLineKulalaEnv                        = { fg = palette.bright_red, bg = palette.grey0, bold = true },
}

for group, hl in pairs(highlightGroups) do
  hl = type(hl) == "string" and { link = hl } or hl
  vim.api.nvim_set_hl(0, group, hl)
end

-- TODO: add missing highlightGroups from theme
