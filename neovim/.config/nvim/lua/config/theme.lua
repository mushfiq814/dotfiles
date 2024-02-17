local colorsFound, colors = pcall(require, "config/colors")
if not colorsFound then
  vim.notify("please generate colors file using the colorscheme script")
  return
end

local utils               = require("config/utils/color-utils")

local colorMap            = {
  none = nil,

  comment = colors.grey2,
  terminal_black = colors.grey0,
  dark3 = colors.grey0,
  dark5 = colors.grey1,

  bg_highlight = colors.black,

  fg = colors.white,
  bg = colors.black,
  fg_dark = colors.grey5,
  bg_dark = utils.darken(colors.black, 0.1),
  fg_gutter = colors.grey3,

  red = colors.bright_red,
  red1 = colors.neutral_red,
  orange = colors.neutral_orange,
  yellow = colors.neutral_yellow,
  green = colors.neutral_green,
  green1 = colors.bright_green,
  green2 = colors.faded_green,
  blue = colors.bright_blue,
  blue0 = utils.darken(colors.neutral_blue, 0.5),
  blue1 = colors.neutral_blue,
  blue2 = utils.lighten(colors.neutral_blue, 0.1),
  blue5 = utils.lighten(colors.neutral_blue, 0.4),
  blue6 = utils.lighten(colors.neutral_blue, 0.8),
  blue7 = utils.darken(colors.faded_blue, 0.4),
  cyan = colors.bright_aqua,
  teal = colors.neutral_aqua,
  magenta = colors.bright_purple,
  magenta2 = utils.lighten(colors.bright_purple, 0.2),
  purple = colors.neutral_purple,

  git = {
    add = colors.faded_aqua,
    change = colors.faded_blue,
    delete = colors.faded_orange,
  },
  gitSigns = {
    add = colors.faded_aqua,
    change = colors.faded_blue,
    delete = colors.faded_orange,
  },
}

colorMap.diff             = {
  add = utils.darken(colorMap.green2, 0.15),
  delete = utils.darken(colorMap.red1, 0.15),
  change = utils.darken(colorMap.blue7, 0.15),
  text = colorMap.blue7,
}

colorMap.git.ignore       = colorMap.dark3
colorMap.black            = utils.darken(colorMap.bg, 0.8)
colorMap.border_highlight = utils.darken(colorMap.blue1, 0.8)
colorMap.border           = colorMap.black

-- Popups and statusline always get a dark background
colorMap.bg_popup         = colorMap.bg_dark
colorMap.bg_statusline    = colorMap.bg_dark

-- Sidebar and Floats are configurable
colorMap.bg_sidebar       = colorMap.none
colorMap.bg_float         = colorMap.none

colorMap.bg_visual        = utils.darken(colorMap.blue0, 0.4)
colorMap.bg_search        = colorMap.blue0
colorMap.fg_sidebar       = colorMap.fg_dark
colorMap.fg_float         = colorMap.fg

colorMap.error            = colorMap.red1
colorMap.todo             = colorMap.blue
colorMap.warning          = colorMap.yellow
colorMap.info             = colorMap.blue2
colorMap.hint             = colorMap.teal

colorMap.delta            = {
  add = utils.darken(colorMap.green2, 0.45),
  delete = utils.darken(colorMap.red1, 0.45),
}

vim.bo.syntax             = "ON"
vim.opt.termguicolors     = true
vim.cmd("set background=" .. colors.mode)
if vim.fn.exists("syntax_on") then vim.cmd("syntax reset") end

-- Neovim LSP virtual diagnostics symbols
vim.cmd("sign define DiagnosticSignError text= texthl=LspDiagnosticsDefaultError       linehl= numhl=")
vim.cmd("sign define DiagnosticSignWarn  text= texthl=LspDiagnosticsDefaultWarning     linehl= numhl=")
vim.cmd("sign define DiagnosticSignInfo  text= texthl=LspDiagnosticsDefaultInformation linehl= numhl=")
vim.cmd("sign define DiagnosticSignHint  text= texthl=LspDiagnosticsDefaultHint        linehl= numhl=")

local sharedColors = {
  darkeraccent        = utils.darken(colors.accent, 0.1),
  darkerbg            = utils.darken(colors.black, 0.1),
  darkercursorline    = utils.darken(colors.grey0, 0.1),
  darkerstatusline    = utils.darken(colors.grey1, 0.1),
  mdCodeBlockBg       = nil,
  mdTitleDarkenFactor = 0.05,
  statusBg            = colors.grey0,
  statusFg            = colors.white,
  winbarBg            = colors.grey1,
  winbarFg            = colors.bright_green,
}

local highlights   = {

  -- Theme Color Highlights, used in plugin settings
  ColorBlack                                 = { fg = colorMap.black },
  ColorWhite                                 = { fg = colorMap.white },
  ColorRed                                   = { fg = colorMap.neutral_red },
  ColorYellow                                = { fg = colorMap.neutral_yellow },
  ColorOrange                                = { fg = colorMap.neutral_orange },
  ColorGreen                                 = { fg = colorMap.neutral_green },
  ColorBlue                                  = { fg = colorMap.neutral_blue },
  ColorAqua                                  = { fg = colorMap.neutral_aqua },
  ColorPurple                                = { fg = colorMap.neutral_purple },

  -- Vim editor colors
  Bold                                       = { bold = true },
  Boolean                                    = { fg = colors.bright_orange, },
  Character                                  = { fg = colorMap.green },   --  a character constant: 'c', '\n'
  ColorColumn                                = { bg = colorMap.black },   -- used for the columns set with 'colorcolumn'
  Comment                                    = { fg = colorMap.comment }, -- any comment
  Conceal                                    = { fg = colorMap.dark5 },   -- placeholder characters substituted for concealed text (see 'conceallevel')
  Conditional                                = { fg = colors.bright_purple, },
  Constant                                   = { fg = colorMap.orange },  -- (preferred) any constant
  CurSearch                                  = { link = "IncSearch" },
  Cursor                                     = { fg = colors.black, bg = colors.grey4, },
  CursorColumn                               = { bg = colorMap.bg_highlight },         -- Screen-column at the cursor, when 'cursorcolumn' is set.
  CursorIM                                   = { fg = colorMap.bg, bg = colorMap.fg }, -- like Cursor, but used when in IME mode |CursorIM|
  CursorLine                                 = { bg = colorMap.bg_highlight },         -- Screen-line at the cursor, when 'cursorline' is set.  Low-priority if foreground (ctermfg OR guifg) is not set.
  CursorLineNr                               = { fg = colorMap.dark5 },                -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
  Debug                                      = { fg = colorMap.orange },               --    debugging statements
  Define                                     = { fg = colors.bright_purple, },
  Delimiter                                  = { link = "Special" },                   --  character that needs attention
  Directory                                  = { fg = colorMap.blue },                 -- directory names (and other special names in listings)
  EndOfBuffer                                = { fg = colorMap.bg },                   -- filler lines (~) after the end of the buffer.  By default, this is highlighted like |hl-NonText|.
  Error                                      = { fg = colorMap.error },                -- (preferred) any erroneous construct
  ErrorMsg                                   = { fg = colorMap.error },                -- error messages on the command line
  Exception                                  = { fg = colors.bright_red, },
  Float                                      = { fg = colors.bright_orange, bg = sharedColors.darkerbg, },
  FloatBorder                                = { fg = colorMap.border_highlight, bg = colorMap.bg_float },
  FloatTitle                                 = { fg = colorMap.border_highlight, bg = colorMap.bg_float },
  FoldColumn                                 = { bg = colorMap.none, fg = colorMap.comment },   -- 'foldcolumn'
  Folded                                     = { fg = colorMap.blue, bg = colorMap.fg_gutter }, -- line used for closed folds
  Function                                   = { fg = colorMap.blue, },                         -- function name (also: methods for classes)
  Identifier                                 = { fg = colorMap.magenta, },                      -- (preferred) any variable name
  IncSearch                                  = { bg = colorMap.orange, fg = colorMap.black },   -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
  Include                                    = { fg = colors.bright_blue, },
  Italic                                     = { italic = true },
  Keyword                                    = { fg = colorMap.cyan, },     --  any other keyword
  Label                                      = { fg = colors.bright_yellow, },
  LineNr                                     = { fg = colorMap.fg_gutter }, -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
  LineNrAbove                                = { fg = colors.grey4, },
  LineNrBelow                                = { fg = colors.grey4, },
  Macro                                      = { fg = colors.bright_red, },
  MatchParen                                 = { fg = colorMap.orange, bold = true },                  -- The character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
  ModeMsg                                    = { fg = colorMap.fg_dark, bold = true },                 -- 'showmode' message (e.g., "-- INSERT -- ")
  MoreMsg                                    = { fg = colorMap.blue },                                 -- |more-prompt|
  MsgArea                                    = { fg = colorMap.fg_dark },                              -- Area for messages and cmdline
  NonText                                    = { fg = colorMap.dark3 },                                -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
  Normal                                     = { fg = colorMap.fg, bg = colorMap.none },               -- normal text
  NormalFloat                                = { fg = colorMap.fg_float, bg = colorMap.bg_float },     -- Normal text in floating windows.
  NormalNC                                   = { fg = colorMap.fg, bg = colorMap.none },               -- normal text in non-current windows
  NormalSB                                   = { fg = colorMap.fg_sidebar, bg = colorMap.bg_sidebar }, -- normal text in sidebar
  Number                                     = { fg = colors.bright_orange, },
  Operator                                   = { fg = colorMap.blue5 },                                -- "sizeof", "+", "*", etc.
  PMenu                                      = { fg = colors.grey4, bg = colors.grey0, },
  PMenuSel                                   = { fg = colors.grey0, bg = colors.grey4, },
  Pmenu                                      = { bg = colorMap.bg_popup, fg = colorMap.fg },              -- Popup menu: normal item.
  PmenuSbar                                  = { bg = utils.lighten(colorMap.bg_popup, 0.95) },           -- Popup menu: scrollbar.
  PmenuSel                                   = { bg = utils.darken(colorMap.fg_gutter, 0.8) },            -- Popup menu: selected item.
  PmenuThumb                                 = { bg = colorMap.fg_gutter },                               -- Popup menu: Thumb of the scrollbar.
  PreProc                                    = { fg = colorMap.cyan },                                    -- (preferred) generic Preprocessor
  Question                                   = { fg = colorMap.blue },                                    -- |hit-enter| prompt and yes/no questions
  QuickFixLine                               = { bg = colorMap.bg_visual, bold = true },                  -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
  Repeat                                     = { fg = colors.bright_yellow, },
  Search                                     = { bg = colorMap.bg_search, fg = colorMap.fg },             -- Last search pattern highlighting (see 'hlsearch').  Also used for similar items that need to stand out.
  SignColumn                                 = { bg = colorMap.none, fg = colorMap.fg_gutter },           -- column where |signs| are displayed
  SignColumnSB                               = { bg = colorMap.bg_sidebar, fg = colorMap.fg_gutter },     -- column where |signs| are displayed
  Special                                    = { fg = colorMap.blue1 },                                   -- (preferred) any special symbol
  SpecialChar                                = { fg = colors.faded_orange, },
  SpecialKey                                 = { fg = colorMap.dark3 },                                   -- Unprintable characters: text displayed differently from what it really is.  But not 'listchars' whitespace. |hl-Whitespace|
  Statement                                  = { fg = colorMap.magenta },                                 -- (preferred) any statement
  StatusLine                                 = { fg = colorMap.fg_sidebar, bg = colorMap.bg_statusline }, -- status line of current window
  StatusLineNC                               = { fg = colorMap.fg_gutter, bg = colorMap.bg_statusline },  -- status lines of not-current windows Note: if this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
  StorageClass                               = { fg = colors.bright_yellow, },
  String                                     = { fg = colorMap.green },                                   --   a string constant: "this is a string"
  Structure                                  = { fg = colors.bright_purple, },
  Substitute                                 = { bg = colorMap.red, fg = colorMap.black },                -- |:substitute| replacement text highlighting
  TabLine                                    = { bg = colorMap.bg_statusline, fg = colorMap.fg_gutter },  -- tab pages line, not active tab page label
  TabLineFill                                = { bg = colorMap.black },                                   -- tab pages line, where there are no labels
  TabLineSel                                 = { fg = colorMap.black, bg = colorMap.blue },               -- tab pages line, active tab page label
  Tag                                        = { fg = colors.bright_yellow, },
  TermCursor                                 = { fg = colors.black, bg = colors.grey4, },
  TermCursorNC                               = { fg = colors.black, bg = colors.grey4, },
  Title                                      = { fg = colorMap.blue, bold = true },        -- titles for output from ":set all", ":autocmd" etc.
  Todo                                       = { bg = colorMap.yellow, fg = colorMap.bg }, -- (preferred) anything that needs extra attention; mostly the keywords TODO FIXME and XXX
  TooLong                                    = { fg = colors.bright_red, },
  Type                                       = { fg = colorMap.blue1 },                    -- (preferred) int, long, char, etc.
  Typedef                                    = { fg = colors.bright_yellow, },
  Underlined                                 = { underline = true },                       -- (preferred) text that stands out, HTML links
  VertSplit                                  = { fg = colorMap.border },                   -- the column separating vertically split windows
  Visual                                     = { bg = colorMap.bg_visual },                -- Visual mode selection
  VisualNOS                                  = { bg = colorMap.bg_visual },                -- Visual mode selection when vim is "Not Owning the Selection".
  WarningMsg                                 = { fg = colorMap.warning },                  -- warning messages
  Whitespace                                 = { fg = colorMap.fg_gutter },                -- "nbsp", "space", "tab" and "trail" in 'listchars'
  WildMenu                                   = { bg = colorMap.bg_visual },                -- current match in 'wildmenu' completion
  WinBar                                     = { link = "StatusLine" },                    -- window bar
  WinBarNC                                   = { link = "StatusLineNC" },                  -- window bar in inactive windows
  WinSeparator                               = { fg = colorMap.border, bold = true },      -- the column separating vertically split windows
  htmlH1                                     = { fg = colorMap.magenta, bold = true },
  htmlH2                                     = { fg = colorMap.blue, bold = true },
  lCursor                                    = { fg = colorMap.bg, bg = colorMap.fg }, -- the character under the cursor when |language-mapping| is used (see 'guicursor')
  qfFileName                                 = { fg = colorMap.blue },
  qfLineNr                                   = { fg = colorMap.dark5 },

  -- Diff
  DiffAdd                                    = { bg = colorMap.diff.add },    -- diff mode: Added line |diff.txt|
  DiffChange                                 = { bg = colorMap.diff.change }, -- diff mode: Changed line |diff.txt|
  DiffDelete                                 = { bg = colorMap.diff.delete }, -- diff mode: Deleted line |diff.txt|
  DiffText                                   = { bg = colorMap.diff.text },   -- diff mode: Changed text within a changed line |diff.txt|
  DiffAdded                                  = { fg = colors.bright_green, bg = colors.black, },
  DiffChanged                                = { fg = colors.bright_blue, bg = colors.black, },
  DiffFile                                   = { fg = colors.bright_red, bg = colors.black, },
  DiffNewFile                                = { fg = colors.bright_green, bg = colors.black, },
  DiffOldFile                                = { fg = colors.bright_red, bg = colors.black, },
  DiffLine                                   = { fg = colors.bright_blue, bg = colors.black, },
  DiffRemoved                                = { fg = colors.bright_red, bg = colors.black, },
  ["@text.diff.change"]                      = { fg = colors.neutral_blue, bold = true, },
  ["@text.diff.delete"]                      = { fg = colors.neutral_red, bold = true, },
  ["@text.diff.add"]                         = { fg = colors.neutral_green, bold = true, },
  ["@diff.delta"]                            = { link = "DiffChange" },
  ["@diff.minus"]                            = { link = "DiffDelete" },
  ["@diff.plus"]                             = { link = "DiffAdd" },
  diffAdded                                  = { fg = colorMap.git.add },
  diffRemoved                                = { fg = colorMap.git.delete },
  diffChanged                                = { fg = colorMap.git.change },
  diffOldFile                                = { fg = colorMap.yellow },
  diffNewFile                                = { fg = colorMap.orange },
  diffFile                                   = { fg = colorMap.blue },
  diffLine                                   = { fg = colorMap.comment },
  diffIndexLine                              = { fg = colorMap.magenta },

  -- Git
  gitcommitOverflow                          = { fg = colors.bright_red, },
  gitcommitSummary                           = { fg = colors.bright_green, },
  gitcommitComment                           = { fg = colors.grey2, },
  gitcommitUntracked                         = { fg = colors.grey2, },
  gitcommitDiscarded                         = { fg = colors.grey2, },
  gitcommitSelected                          = { fg = colors.grey2, },
  gitcommitHeader                            = { fg = colors.bright_purple, },
  gitcommitSelectedType                      = { fg = colors.bright_blue, },
  gitcommitUnmergedType                      = { fg = colors.bright_blue, },
  gitcommitDiscardedType                     = { fg = colors.bright_blue, },
  gitcommitBranch                            = { fg = colors.bright_orange, bold = true, },
  gitcommitUntrackedFile                     = { fg = colors.bright_yellow, },
  gitcommitUnmergedFile                      = { fg = colors.bright_red, bold = true, },
  gitcommitDiscardedFile                     = { fg = colors.bright_red, bold = true, },
  gitcommitSelectedFile                      = { fg = colors.bright_green, bold = true, },

  -- GitGutter
  GitGutterAdd                               = { fg = colorMap.gitSigns.add },    -- diff mode: Added line |diff.txt|
  GitGutterChange                            = { fg = colorMap.gitSigns.change }, -- diff mode: Changed line |diff.txt|
  GitGutterDelete                            = { fg = colorMap.gitSigns.delete }, -- diff mode: Deleted line |diff.txt|
  GitGutterAddLineNr                         = { fg = colorMap.gitSigns.add },
  GitGutterChangeLineNr                      = { fg = colorMap.gitSigns.change },
  GitGutterDeleteLineNr                      = { fg = colorMap.gitSigns.delete },
  GitGutterChangeDelete                      = { fg = colors.bright_purple, bg = colors.black, },

  -- gitsigns
  GitSignsAdd                                = { fg = colorMap.gitSigns.add },    -- diff mode: Added line |diff.txt|
  GitSignsChange                             = { fg = colorMap.gitSigns.change }, -- diff mode: Changed line |diff.txt|
  GitSignsDelete                             = { fg = colorMap.gitSigns.delete }, -- diff mode: Deleted line |diff.txt|
  GitSignsChangeDelete                       = { fg = colors.bright_aqua, bg = colors.bright_red },

  -- Spelling
  SpellBad                                   = { sp = colorMap.error, undercurl = true },   -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
  SpellCap                                   = { sp = colorMap.warning, undercurl = true }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
  SpellLocal                                 = { sp = colorMap.info, undercurl = true },    -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
  SpellRare                                  = { sp = colorMap.hint, undercurl = true },    -- Word that is recognized by the spellchecker as one that is hardly ever used.  |spell| Combined with the highlighting used otherwise.

  -- Diagnostics
  DiagnosticError                            = { fg = colorMap.error },                                             -- Used as the base highlight group. Other Diagnostic highlights link to this by default
  DiagnosticWarn                             = { fg = colorMap.warning },                                           -- Used as the base highlight group. Other Diagnostic highlights link to this by default
  DiagnosticInfo                             = { fg = colorMap.info },                                              -- Used as the base highlight group. Other Diagnostic highlights link to this by default
  DiagnosticHint                             = { fg = colorMap.hint },                                              -- Used as the base highlight group. Other Diagnostic highlights link to this by default
  DiagnosticUnnecessary                      = { fg = colorMap.fg_gutter },                                         -- Used as the base highlight group. Other Diagnostic highlights link to this by default
  DiagnosticVirtualTextError                 = { fg = colorMap.error },     -- Used for "Error" diagnostic virtual text
  DiagnosticVirtualTextWarn                  = { fg = colorMap.warning }, -- Used for "Warning" diagnostic virtual text
  DiagnosticVirtualTextInfo                  = { fg = colorMap.info },       -- Used for "Information" diagnostic virtual text
  DiagnosticVirtualTextHint                  = { fg = colorMap.hint },       -- Used for "Hint" diagnostic virtual text
  DiagnosticUnderlineError                   = { undercurl = true, sp = colorMap.error },                           -- Used to underline "Error" diagnostics
  DiagnosticUnderlineWarn                    = { undercurl = true, sp = colorMap.warning },                         -- Used to underline "Warning" diagnostics
  DiagnosticUnderlineInfo                    = { undercurl = true, sp = colorMap.info },                            -- Used to underline "Information" diagnostics
  DiagnosticUnderlineHint                    = { undercurl = true, sp = colorMap.hint },                            -- Used to underline "Hint" diagnostics
  DiagnosticUnderlineWarning                 = { undercurl = true, sp = colors.bright_purple },
  DiagnosticUnderlineInformation             = { undercurl = true, sp = colors.faded_orange },

  -- Language Server
  LspReferenceText                           = { bg = colorMap.fg_gutter },                      -- used for highlighting "text" references
  LspReferenceRead                           = { bg = colorMap.fg_gutter },                      -- used for highlighting "read" references
  LspReferenceWrite                          = { bg = colorMap.fg_gutter },                      -- used for highlighting "write" references
  LspDiagnosticsDefaultError                 = { fg = colors.bright_red, sp = colors.grey3 },    -- "DiagnosticError"
  LspDiagnosticsDefaultWarning               = { fg = colors.bright_yellow, sp = colors.grey3 }, -- "DiagnosticWarn"
  LspDiagnosticsDefaultInformation           = { fg = colors.bright_blue, sp = colors.grey3 },   -- "DiagnosticInfo"
  LspDiagnosticsDefaultHint                  = { fg = colors.bright_aqua, sp = colors.grey3 },   -- "DiagnosticHint"
  LspDiagnosticsUnderlineError               = { link = "DiagnosticUnderlineError" },
  LspDiagnosticsUnderlineWarning             = { link = "DiagnosticUnderlineWarning" },
  LspDiagnosticsUnderlineInformation         = { link = "DiagnosticUnderlineInformation" },
  LspDiagnosticsUnderlineHint                = { link = "DiagnosticUnderlineHint" },
  LspSignatureActiveParameter                = { bg = utils.darken(colorMap.bg_visual, 0.4), bold = true },
  LspCodeLens                                = { fg = colorMap.comment },
  LspInlayHint                               = { bg = utils.darken(colorMap.blue7, 0.1), fg = colorMap.dark3 },
  LspInfoBorder                              = { fg = colorMap.border_highlight, bg = colorMap.bg_float },

  -- Treesitter
  TSNodeKey                                  = { fg = colorMap.magenta2, bold = true },
  TSNodeUnmatched                            = { fg = colorMap.dark3 },
  TSAnnotation                               = { fg = colors.faded_orange, },
  TSAttribute                                = { fg = colors.bright_yellow, },
  TSBoolean                                  = { fg = colors.bright_orange, },
  TSCharacter                                = { fg = colors.bright_red, },
  TSComment                                  = { fg = colors.grey2, standout = true, },
  TSConstructor                              = { fg = colors.bright_blue, },
  TSConditional                              = { fg = colors.bright_purple, },
  TSConstant                                 = { fg = colors.bright_orange, },
  TSConstBuiltin                             = { fg = colors.bright_orange, standout = true, },
  TSConstMacro                               = { fg = colors.bright_red, },
  TSError                                    = { fg = colors.bright_red, },
  TSException                                = { fg = colors.bright_red, },
  TSField                                    = { fg = colors.grey4, },
  TSFloat                                    = { fg = colors.bright_orange, },
  TSFunction                                 = { fg = colors.bright_blue, },
  TSFuncBuiltin                              = { fg = colors.bright_blue, standout = true, },
  TSFuncMacro                                = { fg = colors.bright_red, },
  TSInclude                                  = { fg = colors.bright_blue, },
  TSKeyword                                  = { fg = colors.bright_purple, },
  TSKeywordFunction                          = { fg = colors.bright_purple, },
  TSKeywordOperator                          = { fg = colors.bright_purple, },
  TSLabel                                    = { fg = colors.bright_yellow, },
  TSMethod                                   = { fg = colors.bright_blue, },
  TSNamespace                                = { fg = colors.bright_red, },
  TSNone                                     = { fg = colors.grey4, },
  TSNumber                                   = { fg = colors.bright_orange, },
  TSOperator                                 = { fg = colors.grey4, },
  TSParameter                                = { fg = colors.grey4, },
  TSParameterReference                       = { fg = colors.grey4, },
  TSProperty                                 = { fg = colors.grey4, },
  TSPunctDelimiter                           = { fg = colors.faded_orange, },
  TSPunctBracket                             = { fg = colors.grey4, },
  TSPunctSpecial                             = { fg = colors.grey4, },
  TSRepeat                                   = { fg = colors.bright_purple, },
  TSString                                   = { fg = colors.bright_green, },
  TSStringRegex                              = { fg = colors.bright_aqua, },
  TSStringEscape                             = { fg = colors.bright_aqua, },
  TSSymbol                                   = { fg = colors.bright_green, },
  TSTag                                      = { fg = colors.bright_yellow, },
  TSTagDelimiter                             = { fg = colors.faded_orange, },
  TSText                                     = { fg = colors.grey4, },
  TSStrong                                   = { bold = true, },
  TSEmphasis                                 = { fg = colors.bright_orange, italic = true, },
  TSUnderline                                = { fg = colors.black, underline = true, },
  TSStrike                                   = { fg = colors.black, strikethrough = true, },
  TSTitle                                    = { fg = colors.bright_blue, },
  TSLiteral                                  = { fg = colors.bright_orange, },
  TSURI                                      = { fg = colors.bright_orange, underline = true, },
  TSType                                     = { fg = colors.bright_yellow, },
  TSTypeBuiltin                              = { fg = colors.bright_yellow, standout = true, },
  TSVariable                                 = { fg = colors.bright_red, },
  TSVariableBuiltin                          = { fg = colors.bright_red, standout = true, },
  TSDefinition                               = { underline = true, sp = colors.grey3 },
  TSDefinitionUsage                          = { underline = true, sp = colors.grey3 },
  TSCurrentScope                             = { bold = true, },
  TreesitterContext                          = { bg = utils.darken(colorMap.fg_gutter, 0.8) },
  Hlargs                                     = { fg = colorMap.yellow },

  -- new treesitter highlights
  ["@annotation"]                            = { link = "PreProc" },
  ["@attribute"]                             = { link = "PreProc" },
  ["@boolean"]                               = { link = "Boolean" },
  ["@character"]                             = { link = "Character" },
  ["@character.special"]                     = { link = "SpecialChar" },
  ["@comment"]                               = { link = "Comment" },
  ["@comment.error"]                         = { fg = colorMap.error },
  ["@comment.hint"]                          = { fg = colorMap.hint },
  ["@comment.info"]                          = { fg = colorMap.info },
  ["@comment.note"]                          = { fg = colorMap.hint },
  ["@comment.todo"]                          = { fg = colorMap.todo },
  ["@comment.warning"]                       = { fg = colorMap.warning },
  ["@constant"]                              = { link = "Constant" },
  ["@constant.builtin"]                      = { link = "Special" },
  ["@constant.macro"]                        = { link = "Define" },
  ["@constructor"]                           = { fg = colorMap.magenta }, -- For constructor calls and definitions: `= { }` in Lua, and Java constructors.
  ["@constructor.tsx"]                       = { fg = colorMap.blue1 },
  ["@function"]                              = { link = "Function" },
  ["@function.builtin"]                      = { link = "Special" },
  ["@function.call"]                         = { link = "@function" },
  ["@function.macro"]                        = { link = "Macro" },
  ["@function.method"]                       = { link = "Function" },
  ["@function.method.call"]                  = { link = "@function.method" },
  ["@keyword"]                               = { fg = colorMap.purple, }, -- For keywords that don't fall in previous categories.
  ["@keyword.conditional"]                   = { link = "Conditional" },
  ["@keyword.coroutine"]                     = { link = "@keyword" },
  ["@keyword.debug"]                         = { link = "Debug" },
  ["@keyword.directive"]                     = { link = "PreProc" },
  ["@keyword.directive.define"]              = { link = "Define" },
  ["@keyword.exception"]                     = { link = "Exception" },
  ["@keyword.function"]                      = { fg = colorMap.magenta, }, -- For keywords used to define a fuction.
  ["@keyword.import"]                        = { link = "Include" },
  ["@keyword.operator"]                      = { link = "@operator" },
  ["@keyword.repeat"]                        = { link = "Repeat" },
  ["@keyword.return"]                        = { link = "@keyword" },
  ["@keyword.storage"]                       = { link = "StorageClass" },
  ["@label"]                                 = { fg = colorMap.blue }, -- For labels: `label:` in C and `:label:` in Lua.
  ["@lsp.type.boolean"]                      = { link = "@boolean" },
  ["@lsp.type.builtinType"]                  = { link = "@type.builtin" },
  ["@lsp.type.comment"]                      = { link = "@comment" },
  ["@lsp.type.decorator"]                    = { link = "@attribute" },
  ["@lsp.type.deriveHelper"]                 = { link = "@attribute" },
  ["@lsp.type.enum"]                         = { link = "@type" },
  ["@lsp.type.enumMember"]                   = { link = "@constant" },
  ["@lsp.type.escapeSequence"]               = { link = "@string.escape" },
  ["@lsp.type.formatSpecifier"]              = { link = "@markup.list" },
  ["@lsp.type.generic"]                      = { link = "@variable" },
  ["@lsp.type.interface"]                    = { fg = utils.lighten(colorMap.blue1, 0.7) },
  ["@lsp.type.keyword"]                      = { link = "@keyword" },
  ["@lsp.type.lifetime"]                     = { link = "@keyword.storage" },
  ["@lsp.type.namespace"]                    = { link = "@module" },
  ["@lsp.type.number"]                       = { link = "@number" },
  ["@lsp.type.operator"]                     = { link = "@operator" },
  ["@lsp.type.parameter"]                    = { link = "@variable.parameter" },
  ["@lsp.type.property"]                     = { link = "@property" },
  ["@lsp.type.selfKeyword"]                  = { link = "@variable.builtin" },
  ["@lsp.type.selfTypeKeyword"]              = { link = "@variable.builtin" },
  ["@lsp.type.string"]                       = { link = "@string" },
  ["@lsp.type.typeAlias"]                    = { link = "@type.definition" },
  ["@lsp.type.unresolvedReference"]          = { undercurl = true, sp = colorMap.error },
  ["@lsp.type.variable"]                     = {}, -- use treesitter styles for regular variables
  ["@lsp.typemod.class.defaultLibrary"]      = { link = "@type.builtin" },
  ["@lsp.typemod.enum.defaultLibrary"]       = { link = "@type.builtin" },
  ["@lsp.typemod.enumMember.defaultLibrary"] = { link = "@constant.builtin" },
  ["@lsp.typemod.function.defaultLibrary"]   = { link = "@function.builtin" },
  ["@lsp.typemod.keyword.async"]             = { link = "@keyword.coroutine" },
  ["@lsp.typemod.keyword.injected"]          = { link = "@keyword" },
  ["@lsp.typemod.macro.defaultLibrary"]      = { link = "@function.builtin" },
  ["@lsp.typemod.method.defaultLibrary"]     = { link = "@function.builtin" },
  ["@lsp.typemod.operator.injected"]         = { link = "@operator" },
  ["@lsp.typemod.string.injected"]           = { link = "@string" },
  ["@lsp.typemod.struct.defaultLibrary"]     = { link = "@type.builtin" },
  ["@lsp.typemod.type.defaultLibrary"]       = { fg = utils.darken(colorMap.blue1, 0.8) },
  ["@lsp.typemod.typeAlias.defaultLibrary"]  = { fg = utils.darken(colorMap.blue1, 0.8) },
  ["@lsp.typemod.variable.callable"]         = { link = "@function" },
  ["@lsp.typemod.variable.defaultLibrary"]   = { link = "@variable.builtin" },
  ["@lsp.typemod.variable.injected"]         = { link = "@variable" },
  ["@lsp.typemod.variable.static"]           = { link = "@constant" },
  ["@markup"]                                = { link = "@none" },
  ["@markup.emphasis"]                       = { italic = true },
  ["@markup.environment"]                    = { link = "Macro" },
  ["@markup.environment.name"]               = { link = "Type" },
  ["@markup.heading"]                        = { link = "Title" },
  ["@markup.heading.1.markdown"]             = { link = "@text.title.1" },
  ["@markup.heading.2.markdown"]             = { link = "@text.title.2" },
  ["@markup.heading.3.markdown"]             = { link = "@text.title.3" },
  ["@markup.heading.4.markdown"]             = { link = "@text.title.4" },
  ["@markup.heading.5.markdown"]             = { link = "@text.title.5" },
  ["@markup.heading.6.markdown"]             = { link = "@text.title.6" },
  ["@markup.italic"]                         = { link = "@text.emphasis" },
  ["@markup.link"]                           = { fg = colorMap.teal },
  ["@markup.link.label"]                     = { link = "SpecialChar" },
  ["@markup.link.label.symbol"]              = { link = "Identifier" },
  ["@markup.link.url"]                       = { link = "Underlined" },
  ["@markup.list"]                           = { fg = colorMap.blue5 },  -- For special punctutation that does not fall in the catagories before.
  ["@markup.list.checked"]                   = { fg = colorMap.green1 }, -- For brackets and parens.
  ["@markup.list.markdown"]                  = { fg = colorMap.orange, bold = true },
  ["@markup.list.unchecked"]                 = { fg = colorMap.blue },   -- For brackets and parens.
  ["@markup.math"]                           = { link = "Special" },
  ["@markup.quote"]                          = { link = "@text.quote" },
  ["@markup.raw"]                            = { link = "String" },
  ["@markup.raw.block"]                      = { link = "@text.literal.block" },
  ["@markup.raw.markdown_inline"]            = { bg = colorMap.dark3, fg = colorMap.blue },
  ["@markup.strikethrough"]                  = { strikethrough = true },
  ["@markup.strong"]                         = { bold = true },
  ["@markup.underline"]                      = { underline = true },
  ["@module"]                                = { link = "Include" },
  ["@module.builtin"]                        = { fg = colorMap.red }, -- Variable names that are defined by the languages, like `this` or `self`.
  ["@namespace.builtin"]                     = { link = "@variable.builtin" },
  ["@none"]                                  = { fg = colors.bright_yellow, },
  ["@number"]                                = { link = "Number" },
  ["@number.float"]                          = { link = "Float" },
  ["@operator"]                              = { fg = colorMap.blue5 },   -- For any operator: `+`, but also `->` and `*` in colorMap.
  ["@property"]                              = { fg = colorMap.green1 },
  ["@punctuation.bracket"]                   = { fg = colorMap.fg_dark }, -- For brackets and parens.
  ["@punctuation.delimiter"]                 = { fg = colorMap.blue5 },   -- For delimiters ie: `.`
  ["@punctuation.special"]                   = { fg = colorMap.blue5 },   -- For special symbols (e.g. `{}` in string interpolation)
  ["@puntuation.strikethrough"]              = { fg = sharedColors.darkeraccent, strikethrough = true, },
  ["@string"]                                = { link = "String" },
  ["@string.documentation"]                  = { fg = colorMap.yellow },
  ["@string.escape"]                         = { fg = colorMap.magenta }, -- For escape characters within a string.
  ["@string.regexp"]                         = { fg = colorMap.blue6 },   -- For regexes.
  ["@string.special.symbol"]                 = { link = "@symbol" },
  ["@string.special.url"]                    = { link = "@text.uri" },
  ["@tag"]                                   = { link = "Label" },
  ["@tag.attribute"]                         = { link = "@property" },
  ["@tag.delimiter"]                         = { link = "Delimiter" },
  ["@tag.delimiter.tsx"]                     = { fg = utils.darken(colorMap.blue, 0.7) },
  ["@tag.tsx"]                               = { fg = colorMap.red },
  ["@text.danger"]                           = { fg = colors.black, bg = colors.bright_red, bold = true, },
  ["@text.emphasis"]                         = { fg = sharedColors.darkeraccent, italic = true, },
  ["@text.literal"]                          = { fg = colors.bright_purple, },
  ["@text.note"]                             = { fg = colors.black, bg = colors.bright_aqua, bold = true, },
  ["@text.quote"]                            = { fg = sharedColors.darkeraccent, bg = colors.grey0, italic = true, },
  ["@text.reference"]                        = { fg = colors.bright_purple, },
  ["@text.strike"]                           = { fg = sharedColors.darkeraccent, strikethrough = true, },
  ["@text.strong"]                           = { fg = sharedColors.darkeraccent, bold = true, },
  ["@text.title.1"]                          = { fg = utils.darken(colors.bright_aqua, sharedColors.mdTitleDarkenFactor * 0), bg = nil, bold = true },
  ["@text.title.1.marker"]                   = { fg = colors.grey3, bold = true, },
  ["@text.title.2"]                          = { fg = utils.darken(colors.bright_aqua, sharedColors.mdTitleDarkenFactor * 1), bg = nil, bold = true },
  ["@text.title.2.marker"]                   = { fg = colors.grey3, bold = true, },
  ["@text.title.3"]                          = { fg = utils.darken(colors.bright_aqua, sharedColors.mdTitleDarkenFactor * 2), bg = nil, bold = true },
  ["@text.title.3.marker"]                   = { fg = colors.grey3, bold = true, },
  ["@text.title.4"]                          = { fg = utils.darken(colors.bright_aqua, sharedColors.mdTitleDarkenFactor * 3), bg = nil, bold = true },
  ["@text.title.4.marker"]                   = { fg = colors.grey3, bold = true, },
  ["@text.title.5"]                          = { fg = utils.darken(colors.bright_aqua, sharedColors.mdTitleDarkenFactor * 4), bg = nil, bold = true },
  ["@text.title.5.marker"]                   = { fg = colors.grey3, bold = true, },
  ["@text.title.6"]                          = { fg = utils.darken(colors.bright_aqua, sharedColors.mdTitleDarkenFactor * 5), bg = nil, bold = true },
  ["@text.title.6.marker"]                   = { fg = colors.grey3, bold = true, },
  ["@text.todo"]                             = { fg = colors.black, bg = colors.bright_yellow, bold = true, },
  ["@text.todo.checked.markdown"]            = {},
  ["@text.todo.unchecked.markdown"]          = {},
  ["@text.uri"]                              = { fg = colors.bright_blue, },
  ["@text.warning"]                          = { fg = colors.black, bg = colors.bright_orange, bold = true, },
  ["@type"]                                  = { link = "Type" },
  ["@type.builtin"]                          = { fg = utils.darken(colorMap.blue1, 0.8) },
  ["@type.definition"]                       = { link = "Typedef" },
  ["@type.qualifier"]                        = { link = "@keyword" },
  ["@variable"]                              = { fg = colorMap.fg, },                        -- Any variable name that does not have another highlight.
  ["@variable.builtin"]                      = { fg = colorMap.red },                        -- Variable names that are defined by the languages, like `this` or `self`.
  ["@variable.member"]                       = { fg = colorMap.green1 },                     -- For fields.
  ["@variable.parameter"]                    = { fg = colorMap.yellow },                     -- For parameters of a function.
  ["@variable.parameter.builtin"]            = { fg = utils.lighten(colorMap.yellow, 0.8) }, -- For builtin parameters of a function, e.g. "..." or Smali's p[1-99]

  -- markdown
  -- TODO: update code block delimiter color when concealed
  ["@markdown_check_done"]                   = { fg = colors.bright_green, },
  ["@markdown_check_undone"]                 = { fg = colors.bright_yellow, },
  ["@markdown_code_block_lang_bash"]         = { fg = colors.bright_green, bg = sharedColors.mdCodeBlockBg, bold = true, },
  ["@markdown_code_block_lang_css"]          = { fg = colors.bright_blue, bg = colors.grey0, bold = true, },
  ["@markdown_code_block_lang_diff"]         = { fg = colors.bright_red, bg = sharedColors.mdCodeBlockBg, bold = true, },
  ["@markdown_code_block_lang_html"]         = { fg = colors.bright_purple, bg = colors.grey0, bold = true, },
  ["@markdown_code_block_lang_java"]         = { fg = colors.bright_blue, bg = sharedColors.mdCodeBlockBg, bold = true, },
  ["@markdown_code_block_lang_javascript"]   = { fg = colors.bright_yellow, bg = sharedColors.mdCodeBlockBg, bold = true, },
  ["@markdown_code_block_lang_json"]         = { fg = colors.bright_orange, bg = sharedColors.mdCodeBlockBg, bold = true, },
  ["@markdown_code_block_lang_lua"]          = { fg = colors.bright_purple, bg = sharedColors.mdCodeBlockBg, bold = true, },
  ["@markdown_code_block_lang_sql"]          = { fg = colors.bright_yellow, bg = colors.grey0, bold = true, },
  ["@markdown_code_block_lang_typescript"]   = { fg = colors.bright_blue, bg = sharedColors.mdCodeBlockBg, bold = true, },
  ["@markdown_code_block_lang_vim"]          = { fg = colors.bright_aqua, bg = sharedColors.mdCodeBlockBg, bold = true, },
  ["@markdown_code_block_lang_yaml"]         = { fg = colors.bright_orange, bg = sharedColors.mdCodeBlockBg, bold = true, },
  ["@markdown_code_block_marker"]            = { fg = colors.bright_yellow, bg = sharedColors.mdCodeBlockBg, bold = true, },
  ["@markdown_list_marker"]                  = { fg = sharedColors.darkeraccent, },
  ["@markdown_quote_marker"]                 = { fg = sharedColors.darkeraccent, bg = colors.grey0, },
  mkdCodeDelimiter                           = { fg = colorMap.fg, bg = colorMap.terminal_black, },
  mkdCodeStart                               = { fg = colorMap.teal, bold = true },
  mkdCodeEnd                                 = { fg = colorMap.teal, bold = true },
  markdownHeadingDelimiter                   = { fg = colorMap.orange, bold = true },
  markdownCode                               = { fg = colorMap.teal },
  markdownCodeBlock                          = { fg = colorMap.teal },
  markdownH1                                 = { fg = colorMap.magenta, bold = true },
  markdownH2                                 = { fg = colorMap.blue, bold = true },
  markdownLinkText                           = { fg = colorMap.blue, underline = true },

  -- TODO: find out
  NvimInternalError                          = { fg = colors.black, bg = colors.bright_red, },
  User1                                      = { fg = colors.bright_red, bg = colors.grey1, },
  User2                                      = { fg = colors.bright_purple, bg = colors.grey1, },
  User3                                      = { fg = colors.grey4, bg = colors.grey1, },
  User4                                      = { fg = colors.bright_aqua, bg = colors.grey1, },
  User5                                      = { fg = colors.grey4, bg = colors.grey1, },
  User6                                      = { fg = colors.grey4, bg = colors.grey0, },
  User7                                      = { fg = colors.grey4, bg = colors.grey1, },
  User8                                      = { fg = colors.black, bg = colors.grey1, },
  User9                                      = { fg = colors.black, bg = colors.grey1, },

  -- telescope
  TelescopeBorder                            = { link = "FloatBorder" },
  TelescopePromptBorder                      = { link = "FloatBorder" },
  TelescopePromptNormal                      = { fg = colors.grey4, bg = sharedColors.darkerbg, },
  TelescopePromptPrefix                      = { fg = colors.bright_red, bg = sharedColors.darkerbg, },
  TelescopeNormal                            = { bg = sharedColors.darkerbg, },
  TelescopePreviewTitle                      = { fg = sharedColors.darkercursorline, bg = colors.bright_green, bold = true, },
  TelescopePromptTitle                       = { fg = sharedColors.darkercursorline, bg = colors.bright_red, bold = true, },
  TelescopeResultsTitle                      = { fg = sharedColors.darkerbg, bg = sharedColors.darkerbg, bold = true, },
  TelescopeSelection                         = { bg = sharedColors.darkerstatusline, },
  TelescopePreviewLine                       = { bg = colors.grey1, },

  -- nvim-notify
  NotifyDEBUGBody                            = { link = "Float" },
  NotifyDEBUGBorder                          = { link = "FloatBorder" },
  NotifyDEBUGIcon                            = { fg = colors.bright_aqua, bg = sharedColors.darkerbg, },
  NotifyDEBUGTitle                           = { fg = colors.bright_aqua, bg = sharedColors.darkerbg, bold = true, },
  NotifyERRORBody                            = { link = "Float" },
  NotifyERRORBorder                          = { link = "FloatBorder" },
  NotifyERRORIcon                            = { fg = colors.bright_red, bg = sharedColors.darkerbg, },
  NotifyERRORTitle                           = { fg = colors.bright_red, bg = sharedColors.darkerbg, bold = true, },
  NotifyINFOBody                             = { link = "Float" },
  NotifyINFOBorder                           = { link = "FloatBorder" },
  NotifyINFOIcon                             = { fg = colors.bright_green, bg = sharedColors.darkerbg, },
  NotifyINFOTitle                            = { fg = colors.bright_green, bg = sharedColors.darkerbg, bold = true, },
  NotifyTRACEBody                            = { link = "Float" },
  NotifyTRACEBorder                          = { link = "FloatBorder" },
  NotifyTRACEIcon                            = { fg = colors.bright_aqua, bg = sharedColors.darkerbg, },
  NotifyTRACETitle                           = { fg = colors.bright_aqua, bg = sharedColors.darkerbg, bold = true, },
  NotifyWARNBody                             = { link = "Float" },
  NotifyWARNBorder                           = { link = "FloatBorder" },
  NotifyWARNIcon                             = { fg = colors.bright_purple, bg = sharedColors.darkerbg, },
  NotifyWARNTitle                            = { fg = colors.bright_purple, bg = sharedColors.darkerbg, bold = true, },
  NotifyBackground                           = { fg = colors.bright_aqua, bg = sharedColors.darkerbg, },

  -- indentblankline
  IndentBlanklineChar                        = { fg = colors.grey1, nocombine = true, },
  IndentBlanklineContextChar                 = { fg = colors.grey3, nocombine = true, },
  IndentBlanklineSpaceChar                   = { fg = colors.grey2, nocombine = true, },
  IndentBlanklineSpaceCharBlankline          = { fg = colors.white, nocombine = true, },

  -- nvim-cmp
  -- TODO: check which colors here need changing
  CmpDocumentation                           = { fg = colorMap.fg, bg = colorMap.bg_float },
  CmpDocumentationBorder                     = { fg = colorMap.border_highlight, bg = colorMap.bg_float },
  CmpGhostText                               = { fg = colorMap.terminal_black },
  CmpItemAbbr                                = { fg = colorMap.fg, bg = colorMap.none },
  CmpItemAbbrDeprecated                      = { fg = colorMap.fg_gutter, bg = colorMap.none, strikethrough = true },
  CmpItemAbbrMatch                           = { fg = colorMap.blue1, bg = colorMap.none },
  CmpItemAbbrMatchFuzzy                      = { fg = colorMap.blue1, bg = colorMap.none },
  CmpItemKindClass                           = { fg = colors.black, bg = colors.bright_yellow, },
  CmpItemKindCodeium                         = { fg = colorMap.teal, bg = colorMap.none },
  CmpItemKindColor                           = { fg = colors.black, bg = colors.bright_blue, },
  CmpItemKindConstant                        = { fg = colors.black, bg = colors.bright_orange, },
  CmpItemKindConstructor                     = { fg = colors.black, bg = colors.bright_blue, },
  CmpItemKindCopilot                         = { fg = colorMap.teal, bg = colorMap.none },
  CmpItemKindDefault                         = { fg = colorMap.fg_dark, bg = colorMap.none },
  CmpItemKindEnum                            = { fg = colors.black, bg = colors.bright_yellow, },
  CmpItemKindEnumMember                      = { fg = colors.black, bg = colors.bright_yellow, },
  CmpItemKindEvent                           = { fg = colors.black, bg = colors.bright_yellow, },
  CmpItemKindField                           = { fg = colors.black, bg = colors.bright_red, },
  CmpItemKindFile                            = { fg = colors.black, bg = colors.bright_purple, },
  CmpItemKindFolder                          = { fg = colors.black, bg = colors.bright_yellow, },
  CmpItemKindFunction                        = { fg = colors.black, bg = colors.bright_blue, },
  CmpItemKindInterface                       = { fg = colors.black, bg = colors.bright_yellow, },
  CmpItemKindKeyword                         = { fg = colors.black, bg = colors.bright_purple, },
  CmpItemKindMethod                          = { fg = colors.black, bg = colors.bright_blue, },
  CmpItemKindModule                          = { fg = colors.black, bg = colors.grey4, },
  CmpItemKindOperator                        = { fg = colors.black, bg = colors.grey4, },
  CmpItemKindProperty                        = { fg = colors.black, bg = colors.bright_red, },
  CmpItemKindReference                       = { fg = colors.black, bg = colors.bright_red, },
  CmpItemKindSnippet                         = { fg = colors.black, bg = colors.grey3, },
  CmpItemKindStruct                          = { fg = colors.black, bg = colors.bright_yellow, },
  CmpItemKindTabNine                         = { fg = colorMap.teal, bg = colorMap.none },
  CmpItemKindText                            = { fg = colors.black, bg = colors.bright_green, },
  CmpItemKindTypeParameter                   = { fg = colors.black, bg = colors.bright_yellow, },
  CmpItemKindUnit                            = { fg = colors.black, bg = colors.bright_yellow, },
  CmpItemKindValue                           = { fg = colors.black, bg = colors.bright_orange, },
  CmpItemKindVariable                        = { fg = colors.black, bg = colors.bright_red, },
  CmpItemMenu                                = { fg = colorMap.comment, bg = colorMap.none },

  -- checkhealth
  healthError                                = { fg = colorMap.error },
  healthSuccess                              = { fg = colorMap.green1 },
  healthWarning                              = { fg = colorMap.warning },
  healthHelp                                 = { fg = colors.faded_blue, bold = true, },
  helpCommand                                = { link = "@markup.raw.markdown_inline" },

  -- winbar
  winbarFileName                             = { fg = colors.black, bg = colors.accent, bold = true, },
  winbarFileNameModified                     = { fg = colors.black, bg = colors.neutral_aqua, },
  winbarTags                                 = { bg = sharedColors.winbarBg, fg = colors.white },
  NavicSeparator                             = { fg = colorMap.fg, bg = sharedColors.winbarBg },
  NavicText                                  = { fg = colorMap.fg, bg = sharedColors.winbarBg },
  NavicIconsArray                            = { bg = sharedColors.winbarBg, fg = sharedColors.winbarFg },
  NavicIconsBoolean                          = { bg = sharedColors.winbarBg, fg = sharedColors.winbarFg },
  NavicIconsClass                            = { bg = sharedColors.winbarBg, fg = sharedColors.winbarFg },
  NavicIconsConstant                         = { bg = sharedColors.winbarBg, fg = sharedColors.winbarFg },
  NavicIconsConstructor                      = { bg = sharedColors.winbarBg, fg = sharedColors.winbarFg },
  NavicIconsEnum                             = { bg = sharedColors.winbarBg, fg = sharedColors.winbarFg },
  NavicIconsEnumMember                       = { bg = sharedColors.winbarBg, fg = sharedColors.winbarFg },
  NavicIconsEvent                            = { bg = sharedColors.winbarBg, fg = sharedColors.winbarFg },
  NavicIconsField                            = { bg = sharedColors.winbarBg, fg = sharedColors.winbarFg },
  NavicIconsFile                             = { bg = sharedColors.winbarBg, fg = sharedColors.winbarFg },
  NavicIconsFunction                         = { bg = sharedColors.winbarBg, fg = sharedColors.winbarFg },
  NavicIconsInterface                        = { bg = sharedColors.winbarBg, fg = sharedColors.winbarFg },
  NavicIconsKey                              = { bg = sharedColors.winbarBg, fg = sharedColors.winbarFg },
  NavicIconsMethod                           = { bg = sharedColors.winbarBg, fg = sharedColors.winbarFg },
  NavicIconsModule                           = { bg = sharedColors.winbarBg, fg = sharedColors.winbarFg },
  NavicIconsNamespace                        = { bg = sharedColors.winbarBg, fg = sharedColors.winbarFg },
  NavicIconsNull                             = { bg = sharedColors.winbarBg, fg = sharedColors.winbarFg },
  NavicIconsNumber                           = { bg = sharedColors.winbarBg, fg = sharedColors.winbarFg },
  NavicIconsObject                           = { bg = sharedColors.winbarBg, fg = sharedColors.winbarFg },
  NavicIconsOperator                         = { bg = sharedColors.winbarBg, fg = sharedColors.winbarFg },
  NavicIconsPackage                          = { bg = sharedColors.winbarBg, fg = sharedColors.winbarFg },
  NavicIconsProperty                         = { bg = sharedColors.winbarBg, fg = sharedColors.winbarFg },
  NavicIconsString                           = { bg = sharedColors.winbarBg, fg = sharedColors.winbarFg },
  NavicIconsStruct                           = { bg = sharedColors.winbarBg, fg = sharedColors.winbarFg },
  NavicIconsTypeParameter                    = { bg = sharedColors.winbarBg, fg = sharedColors.winbarFg },
  NavicIconsVariable                         = { bg = sharedColors.winbarBg, fg = sharedColors.winbarFg },

  -- statusline
  statusLineModeNormal                       = { fg = colors.grey0, bg = colors.bright_aqua, bold = true },
  statusLineModeInsert                       = { fg = colors.grey0, bg = colors.bright_blue, bold = true, },
  statusLineModeVisual                       = { fg = colors.grey0, bg = colors.bright_orange, bold = true, },
  statusLineModeCommand                      = { fg = colors.grey0, bg = colors.bright_yellow, bold = true, },
  statusLineModeTerminal                     = { fg = colors.grey0, bg = colors.bright_purple, bold = true, },
  statusLineTabNormal                        = { fg = sharedColors.statusFg, bg = sharedColors.statusBg, },
  statuslineTabActive                        = { fg = sharedColors.statusBg, bg = colors.accent, },
  statuslineTabInactive                      = { fg = colors.white, bg = colors.grey2, },
  statusLineBranch                           = { fg = sharedColors.statusFg, bg = sharedColors.statusBg, bold = true, },
  statusLineCwd                              = { fg = colors.bright_blue, bg = sharedColors.statusBg, },
  statusLineFileName                         = { fg = colors.bright_aqua, bg = sharedColors.statusBg, },
  statusLineFileNameModified                 = { fg = colors.bright_red, bg = sharedColors.statusBg, },
  statusLineSpacer                           = { fg = sharedColors.statusFg, bg = sharedColors.statusBg, },
  statusLineDiagnosticsError                 = { fg = colorMap.error, bg = sharedColors.statusBg, },
  statusLineDiagnosticsWarning               = { fg = colorMap.warning, bg = sharedColors.statusBg, },
  statusLineDiagnosticsInfo                  = { fg = colorMap.info, bg = sharedColors.statusBg, },
  statusLineLspClient                        = { fg = colors.bright_orange, bg = sharedColors.statusBg, },
  statusLineFileType                         = { fg = sharedColors.statusFg, bg = sharedColors.statusBg, },
  statusLineProgress                         = { fg = colors.grey3, bg = colors.bright_yellow, },
  statusLineRowCol                           = { fg = colors.bright_aqua, bg = sharedColors.statusBg, bold = true, },
  flagBlue                                   = { fg = colors.grey0, bg = colors.neutral_blue, bold = true, },
  flagYellow                                 = { fg = colors.grey0, bg = colors.neutral_yellow, bold = true, },
  flagOrange                                 = { fg = colors.grey0, bg = colors.neutral_orange, bold = true, },
  flagRed                                    = { fg = colors.grey0, bg = colors.neutral_red, bold = true, },
  statusLineFileTypeIcon                     = { bg = sharedColors.statusBg },

  -- Dashboard
  -- TODO: check if I need more of my own colors here
  DashboardShortCut                          = { fg = colorMap.cyan },
  DashboardHeader                            = { fg = colorMap.yellow },
  DashboardCenter                            = { fg = colorMap.magenta },
  DashboardFooter                            = { fg = colorMap.blue1 },
  DashboardKey                               = { fg = colorMap.orange },
  DashboardDesc                              = { fg = colorMap.cyan },
  DashboardIcon                              = { fg = colorMap.cyan, bold = true },
  DashboardProjectTitle                      = { fg = colors.neutral_blue },
  DashboardProjectIcon                       = { fg = colors.neutral_yellow },
  DashboardMruTitle                          = { fg = colors.neutral_blue },

  -- Lazy
  LazyProgressDone                           = { bold = true, fg = colorMap.magenta2 },
  LazyProgressTodo                           = { bold = true, fg = colorMap.fg_gutter },

  -- NvimTree
  -- TODO: try to use my colors
  NvimTreeNormal                             = { fg = colorMap.fg_sidebar, bg = colorMap.bg_sidebar },
  NvimTreeWinSeparator                       = { fg = colorMap.border, bg = colorMap.bg_sidebar, },
  NvimTreeNormalNC                           = { fg = colorMap.fg_sidebar, bg = colorMap.bg_sidebar },
  NvimTreeRootFolder                         = { fg = colorMap.blue, bold = true },
  NvimTreeGitDirty                           = { fg = colorMap.git.change },
  NvimTreeGitNew                             = { fg = colorMap.git.add },
  NvimTreeGitDeleted                         = { fg = colorMap.git.delete },
  NvimTreeOpenedFile                         = { bg = colorMap.bg_highlight },
  NvimTreeSpecialFile                        = { fg = colorMap.purple, underline = true },
  NvimTreeIndentMarker                       = { fg = colorMap.fg_gutter },
  NvimTreeImageFile                          = { fg = colorMap.fg_sidebar },
  NvimTreeSymlink                            = { fg = colorMap.blue },
  NvimTreeFolderIcon                         = { bg = colorMap.none, fg = colorMap.blue },
  NvimTreeFolderName                         = { fg = colorMap.fg_float },
  NvimTreeBookmark                           = { fg = colors.bright_red },
  NvimTreeExecFile                           = { fg = colors.bright_red, bold = true, },
  NvimTreeGitMerge                           = { fg = colors.bright_orange },
  NvimTreeGitRenamed                         = { fg = colors.bright_purple },
  NvimTreeGitStaged                          = { fg = colors.bright_red },
  NvimTreeLiveFilterPrefix                   = { fg = colors.bright_purple, bold = true, },
  NvimTreeLiveFilterValue                    = { bold = true, },
  NvimTreeModifiedFile                       = { fg = colors.bright_red },
  NvimTreeWindowPicker                       = { fg = colors.white, bg = colors.neutral_blue, bold = true, },

}

-- apply highlights
for k, v in pairs(highlights) do
  utils.highlight(k, v)
end

-- FIXME SignColumn highlight by itself retains the background color for some reason
vim.cmd("hi! SignColumn guibg=None")
