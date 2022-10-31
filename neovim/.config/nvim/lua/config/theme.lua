local colorsFound, colors = pcall(require, 'config/colors')
if not colorsFound then return end

vim.bo.syntax = 'ON'
vim.opt.termguicolors = true

-- edited from https://github.com/RRethy/nvim-base16/
local utils = require('config/color-utils')

if vim.fn.exists('syntax_on') then
  vim.cmd('syntax reset')
end
local hi = utils.highlight

-- Vim editor colors
hi.Normal       = { guifg = colors.grey4, guibg = colors.black, gui = nil, guisp = nil }
hi.EndOfBuffer  = { guifg = colors.grey2, guibg = colors.black, gui = nil, guisp = nil }
hi.Pmenu        = { guifg = colors.grey4, guibg = nil, gui = nil, guisp = nil }
hi.Bold         = { guifg = nil, guibg = nil, gui = 'bold', guisp = nil }
hi.Debug        = { guifg = colors.bright_red, guibg = nil, gui = nil, guisp = nil }
hi.Directory    = { guifg = colors.bright_blue, guibg = nil, gui = nil, guisp = nil }
hi.Error        = { guifg = colors.black, guibg = colors.bright_red, gui = "bold", guisp = nil }
hi.ErrorMsg     = { guifg = colors.bright_red, guibg = colors.black, gui = nil, guisp = nil }
hi.Exception    = { guifg = colors.bright_red, guibg = nil, gui = nil, guisp = nil }
hi.FoldColumn   = { guifg = colors.bright_aqua, guibg = colors.black, gui = nil, guisp = nil }
hi.Folded       = { guifg = colors.grey2, guibg = colors.grey0, gui = nil, guisp = nil }
hi.IncSearch    = { guifg = colors.grey0, guibg = colors.bright_orange, gui = 'none', guisp = nil }
hi.Italic       = { guifg = nil, guibg = nil, gui = 'none', guisp = nil }
hi.Macro        = { guifg = colors.bright_red, guibg = nil, gui = nil, guisp = nil }
hi.MatchParen   = { guifg = nil, guibg = colors.grey2, gui = nil, guisp = nil }
hi.ModeMsg      = { guifg = colors.bright_green, guibg = nil, gui = nil, guisp = nil }
hi.MoreMsg      = { guifg = colors.bright_green, guibg = nil, gui = nil, guisp = nil }
hi.Question     = { guifg = colors.bright_blue, guibg = nil, gui = nil, guisp = nil }
hi.Search       = { guifg = colors.grey0, guibg = colors.bright_yellow, gui = nil, guisp = nil }
hi.Substitute   = { guifg = colors.grey0, guibg = colors.bright_yellow, gui = 'none', guisp = nil }
hi.SpecialKey   = { guifg = colors.grey2, guibg = nil, gui = nil, guisp = nil }
hi.TooLong      = { guifg = colors.bright_red, guibg = nil, gui = nil, guisp = nil }
hi.Underlined   = { guifg = colors.bright_red, guibg = nil, gui = nil, guisp = nil }
hi.Visual       = { guifg = nil, guibg = colors.grey1, gui = nil, guisp = nil }
hi.VisualNOS    = { guifg = colors.bright_red, guibg = nil, gui = nil, guisp = nil }
hi.WarningMsg   = { guifg = colors.bright_red, guibg = nil, gui = nil, guisp = nil }
hi.WildMenu     = { guifg = colors.bright_red, guibg = colors.bright_yellow, gui = nil, guisp = nil }
hi.Title        = { guifg = colors.bright_blue, guibg = nil, gui = 'none', guisp = nil }
hi.Conceal      = { guifg = colors.mode == "light" and colors.faded_blue or colors.bright_blue, guibg = colors.black, gui = nil, guisp = nil }
hi.Cursor       = { guifg = colors.black, guibg = colors.grey4, gui = nil, guisp = nil }
hi.NonText      = { guifg = colors.grey2, guibg = nil, gui = nil, guisp = nil }
hi.LineNr       = { guifg = colors.grey3, guibg = nil, gui = nil, guisp = nil }
hi.LineNrAbove  = { guifg = colors.grey4, guibg = nil, gui = nil, guisp = nil }
hi.LineNrBelow  = { guifg = colors.grey4, guibg = nil, gui = nil, guisp = nil }
hi.SignColumn   = { guifg = colors.grey3, guibg = nil, gui = nil, guisp = nil }
hi.StatusLine   = { guifg = colors.grey4, guibg = colors.grey1, gui = 'none', guisp = nil }
hi.StatusLineNC = { guifg = colors.grey3, guibg = colors.grey0, gui = 'none', guisp = nil }
hi.WinBar       = { guifg = colors.grey4, guibg = nil, gui = 'none', guisp = nil }
hi.WinBarNC     = { guifg = colors.grey3, guibg = nil, gui = 'none', guisp = nil }
hi.VertSplit    = { guifg = colors.grey2, guibg = nil, gui = 'none', guisp = nil }
hi.ColorColumn  = { guifg = nil, guibg = colors.grey0, gui = 'none', guisp = nil }
hi.CursorColumn = { guifg = nil, guibg = colors.grey0, gui = 'none', guisp = nil }
hi.CursorLine   = { guifg = nil, guibg = colors.grey0, gui = 'none', guisp = nil }
hi.CursorLineNr = { guifg = colors.grey3, guibg = colors.grey0, gui = nil, guisp = nil }
hi.QuickFixLine = { guifg = nil, guibg = colors.grey0, gui = 'none', guisp = nil }
hi.PMenu        = { guifg = colors.grey4, guibg = colors.grey0, gui = 'none', guisp = nil }
hi.PMenuSel     = { guifg = colors.grey0, guibg = colors.grey4, gui = nil, guisp = nil }
hi.TabLine      = { guifg = colors.grey2, guibg = colors.grey0, gui = 'none', guisp = nil }
hi.TabLineFill  = { guifg = colors.grey2, guibg = colors.grey0, gui = 'none', guisp = nil }
hi.TabLineSel   = { guifg = colors.bright_green, guibg = colors.grey0, gui = 'none', guisp = nil }

-- Standard syntax highlighting
hi.Boolean      = { guifg = colors.bright_orange, guibg = nil, gui = nil, guisp = nil }
hi.Character    = { guifg = colors.bright_red, guibg = nil, gui = nil, guisp = nil }
hi.Comment      = { guifg = colors.grey2, guibg = nil, gui = nil, guisp = nil }
hi.Conditional  = { guifg = colors.bright_purple, guibg = nil, gui = nil, guisp = nil }
hi.Constant     = { guifg = colors.bright_orange, guibg = nil, gui = nil, guisp = nil }
hi.Define       = { guifg = colors.bright_purple, guibg = nil, gui = 'none', guisp = nil }
hi.Delimiter    = { guifg = colors.faded_orange, guibg = nil, gui = nil, guisp = nil }
hi.Float        = { guifg = colors.bright_orange, guibg = nil, gui = nil, guisp = nil }
hi.Function     = { guifg = colors.bright_blue, guibg = nil, gui = nil, guisp = nil }
hi.Identifier   = { guifg = colors.bright_red, guibg = nil, gui = 'none', guisp = nil }
hi.Include      = { guifg = colors.bright_blue, guibg = nil, gui = nil, guisp = nil }
hi.Keyword      = { guifg = colors.bright_purple, guibg = nil, gui = nil, guisp = nil }
hi.Label        = { guifg = colors.bright_yellow, guibg = nil, gui = nil, guisp = nil }
hi.Number       = { guifg = colors.bright_orange, guibg = nil, gui = nil, guisp = nil }
hi.Operator     = { guifg = colors.grey4, guibg = nil, gui = 'none', guisp = nil }
hi.PreProc      = { guifg = colors.bright_yellow, guibg = nil, gui = nil, guisp = nil }
hi.Repeat       = { guifg = colors.bright_yellow, guibg = nil, gui = nil, guisp = nil }
hi.Special      = { guifg = colors.bright_aqua, guibg = nil, gui = nil, guisp = nil }
hi.SpecialChar  = { guifg = colors.faded_orange, guibg = nil, gui = nil, guisp = nil }
hi.Statement    = { guifg = colors.bright_red, guibg = nil, gui = nil, guisp = nil }
hi.StorageClass = { guifg = colors.bright_yellow, guibg = nil, gui = nil, guisp = nil }
hi.String       = { guifg = colors.bright_green, guibg = nil, gui = nil, guisp = nil }
hi.Structure    = { guifg = colors.bright_purple, guibg = nil, gui = nil, guisp = nil }
hi.Tag          = { guifg = colors.bright_yellow, guibg = nil, gui = nil, guisp = nil }
hi.Todo         = { guifg = colors.bright_yellow, guibg = colors.grey0, gui = nil, guisp = nil }
hi.Type         = { guifg = colors.bright_yellow, guibg = nil, gui = 'none', guisp = nil }
hi.Typedef      = { guifg = colors.bright_yellow, guibg = nil, gui = nil, guisp = nil }

-- Diff highlighting
hi.DiffAdd     = { guifg = colors.black, guibg = colors.bright_green, gui = nil, guisp = nil }
hi.DiffChange  = { guifg = colors.grey2, guibg = colors.bright_blue, gui = nil, guisp = nil }
hi.DiffDelete  = { guifg = colors.bright_red, guibg = colors.bright_red, gui = nil, guisp = nil }
hi.DiffText    = { guifg = colors.black, guibg = colors.bright_blue, gui = nil, guisp = nil }
hi.DiffAdded   = { guifg = colors.bright_green, guibg = colors.black, gui = nil, guisp = nil }
hi.DiffFile    = { guifg = colors.bright_red, guibg = colors.black, gui = nil, guisp = nil }
hi.DiffNewFile = { guifg = colors.bright_green, guibg = colors.black, gui = nil, guisp = nil }
hi.DiffLine    = { guifg = colors.bright_blue, guibg = colors.black, gui = nil, guisp = nil }
hi.DiffRemoved = { guifg = colors.bright_red, guibg = colors.black, gui = nil, guisp = nil }

-- Git highlighting
hi.gitcommitOverflow      = { guifg = colors.bright_red, guibg = nil, gui = nil, guisp = nil }
hi.gitcommitSummary       = { guifg = colors.bright_green, guibg = nil, gui = nil, guisp = nil }
hi.gitcommitComment       = { guifg = colors.grey2, guibg = nil, gui = nil, guisp = nil }
hi.gitcommitUntracked     = { guifg = colors.grey2, guibg = nil, gui = nil, guisp = nil }
hi.gitcommitDiscarded     = { guifg = colors.grey2, guibg = nil, gui = nil, guisp = nil }
hi.gitcommitSelected      = { guifg = colors.grey2, guibg = nil, gui = nil, guisp = nil }
hi.gitcommitHeader        = { guifg = colors.bright_purple, guibg = nil, gui = nil, guisp = nil }
hi.gitcommitSelectedType  = { guifg = colors.bright_blue, guibg = nil, gui = nil, guisp = nil }
hi.gitcommitUnmergedType  = { guifg = colors.bright_blue, guibg = nil, gui = nil, guisp = nil }
hi.gitcommitDiscardedType = { guifg = colors.bright_blue, guibg = nil, gui = nil, guisp = nil }
hi.gitcommitBranch        = { guifg = colors.bright_orange, guibg = nil, gui = 'bold', guisp = nil }
hi.gitcommitUntrackedFile = { guifg = colors.bright_yellow, guibg = nil, gui = nil, guisp = nil }
hi.gitcommitUnmergedFile  = { guifg = colors.bright_red, guibg = nil, gui = 'bold', guisp = nil }
hi.gitcommitDiscardedFile = { guifg = colors.bright_red, guibg = nil, gui = 'bold', guisp = nil }
hi.gitcommitSelectedFile  = { guifg = colors.bright_green, guibg = nil, gui = 'bold', guisp = nil }

-- GitGutter highlighting
hi.GitGutterAdd          = { guifg = colors.bright_green, guibg = colors.black, gui = nil, guisp = nil }
hi.GitGutterChange       = { guifg = colors.bright_blue, guibg = colors.black, gui = nil, guisp = nil }
hi.GitGutterDelete       = { guifg = colors.bright_red, guibg = colors.black, gui = nil, guisp = nil }
hi.GitGutterChangeDelete = { guifg = colors.bright_purple, guibg = colors.black, gui = nil, guisp = nil }

-- Spelling highlighting
hi.SpellBad   = { guifg = nil, guibg = nil, gui = 'undercurl', guisp = colors.bright_red }
hi.SpellLocal = { guifg = nil, guibg = nil, gui = 'undercurl', guisp = colors.bright_aqua }
hi.SpellCap   = { guifg = nil, guibg = nil, gui = 'undercurl', guisp = colors.bright_blue }
hi.SpellRare  = { guifg = nil, guibg = nil, gui = 'undercurl', guisp = colors.bright_purple }

hi.DiagnosticError                = { guifg = colors.bright_red, guibg = nil, gui = 'none', guisp = nil }
hi.DiagnosticWarn                 = { guifg = colors.bright_yellow, guibg = nil, gui = 'none', guisp = nil }
hi.DiagnosticInfo                 = { guifg = colors.bright_blue, guibg = nil, gui = 'none', guisp = nil }
hi.DiagnosticHint                 = { guifg = colors.bright_aqua, guibg = nil, gui = 'none', guisp = nil }
hi.DiagnosticUnderlineError       = { guifg = nil, guibg = nil, gui = 'undercurl', guisp = colors.bright_red }
hi.DiagnosticUnderlineWarning     = { guifg = nil, guibg = nil, gui = 'undercurl', guisp = colors.bright_purple }
hi.DiagnosticUnderlineWarn        = { guifg = nil, guibg = nil, gui = 'undercurl', guisp = colors.bright_purple }
hi.DiagnosticUnderlineInformation = { guifg = nil, guibg = nil, gui = 'undercurl', guisp = colors.faded_orange }
hi.DiagnosticUnderlineHint        = { guifg = nil, guibg = nil, gui = 'undercurl', guisp = colors.bright_aqua }

hi.LspReferenceText                   = { guifg = nil, guibg = nil, gui = 'underline', guisp = colors.grey3 }
hi.LspReferenceRead                   = { guifg = nil, guibg = nil, gui = 'underline', guisp = colors.grey3 }
hi.LspReferenceWrite                  = { guifg = nil, guibg = nil, gui = 'underline', guisp = colors.grey3 }
hi.LspDiagnosticsDefaultError         = { guifg = colors.bright_red, guibg = nil, gui = 'none', guisp = colors.grey3 } -- 'DiagnosticError'
hi.LspDiagnosticsDefaultWarning       = { guifg = colors.bright_yellow, guibg = nil, gui = 'none', guisp = colors.grey3 } -- 'DiagnosticWarn'
hi.LspDiagnosticsDefaultInformation   = { guifg = colors.bright_blue, guibg = nil, gui = 'none', guisp = colors.grey3 } -- 'DiagnosticInfo'
hi.LspDiagnosticsDefaultHint          = { guifg = colors.bright_aqua, guibg = nil, gui = 'none', guisp = colors.grey3 } -- 'DiagnosticHint'
hi.LspDiagnosticsUnderlineError       = 'DiagnosticUnderlineError'
hi.LspDiagnosticsUnderlineWarning     = 'DiagnosticUnderlineWarning'
hi.LspDiagnosticsUnderlineInformation = 'DiagnosticUnderlineInformation'
hi.LspDiagnosticsUnderlineHint        = 'DiagnosticUnderlineHint'

hi.TSAnnotation         = { guifg = colors.faded_orange, guibg = nil, gui = 'none', guisp = nil }
hi.TSAttribute          = { guifg = colors.bright_yellow, guibg = nil, gui = 'none', guisp = nil }
hi.TSBoolean            = { guifg = colors.bright_orange, guibg = nil, gui = 'none', guisp = nil }
hi.TSCharacter          = { guifg = colors.bright_red, guibg = nil, gui = 'none', guisp = nil }
hi.TSComment            = { guifg = colors.grey2, guibg = nil, gui = 'italic', guisp = nil }
hi.TSConstructor        = { guifg = colors.bright_blue, guibg = nil, gui = 'none', guisp = nil }
hi.TSConditional        = { guifg = colors.bright_purple, guibg = nil, gui = 'none', guisp = nil }
hi.TSConstant           = { guifg = colors.bright_orange, guibg = nil, gui = 'none', guisp = nil }
hi.TSConstBuiltin       = { guifg = colors.bright_orange, guibg = nil, gui = 'italic', guisp = nil }
hi.TSConstMacro         = { guifg = colors.bright_red, guibg = nil, gui = 'none', guisp = nil }
hi.TSError              = { guifg = colors.bright_red, guibg = nil, gui = 'none', guisp = nil }
hi.TSException          = { guifg = colors.bright_red, guibg = nil, gui = 'none', guisp = nil }
hi.TSField              = { guifg = colors.grey4, guibg = nil, gui = 'none', guisp = nil }
hi.TSFloat              = { guifg = colors.bright_orange, guibg = nil, gui = 'none', guisp = nil }
hi.TSFunction           = { guifg = colors.bright_blue, guibg = nil, gui = 'none', guisp = nil }
hi.TSFuncBuiltin        = { guifg = colors.bright_blue, guibg = nil, gui = 'italic', guisp = nil }
hi.TSFuncMacro          = { guifg = colors.bright_red, guibg = nil, gui = 'none', guisp = nil }
hi.TSInclude            = { guifg = colors.bright_blue, guibg = nil, gui = 'none', guisp = nil }
hi.TSKeyword            = { guifg = colors.bright_purple, guibg = nil, gui = 'none', guisp = nil }
hi.TSKeywordFunction    = { guifg = colors.bright_purple, guibg = nil, gui = 'none', guisp = nil }
hi.TSKeywordOperator    = { guifg = colors.bright_purple, guibg = nil, gui = 'none', guisp = nil }
hi.TSLabel              = { guifg = colors.bright_yellow, guibg = nil, gui = 'none', guisp = nil }
hi.TSMethod             = { guifg = colors.bright_blue, guibg = nil, gui = 'none', guisp = nil }
hi.TSNamespace          = { guifg = colors.bright_red, guibg = nil, gui = 'none', guisp = nil }
hi.TSNone               = { guifg = colors.grey4, guibg = nil, gui = 'none', guisp = nil }
hi.TSNumber             = { guifg = colors.bright_orange, guibg = nil, gui = 'none', guisp = nil }
hi.TSOperator           = { guifg = colors.grey4, guibg = nil, gui = 'none', guisp = nil }
hi.TSParameter          = { guifg = colors.grey4, guibg = nil, gui = 'none', guisp = nil }
hi.TSParameterReference = { guifg = colors.grey4, guibg = nil, gui = 'none', guisp = nil }
hi.TSProperty           = { guifg = colors.grey4, guibg = nil, gui = 'none', guisp = nil }
hi.TSPunctDelimiter     = { guifg = colors.faded_orange, guibg = nil, gui = 'none', guisp = nil }
hi.TSPunctBracket       = { guifg = colors.grey4, guibg = nil, gui = 'none', guisp = nil }
hi.TSPunctSpecial       = { guifg = colors.grey4, guibg = nil, gui = 'none', guisp = nil }
hi.TSRepeat             = { guifg = colors.bright_purple, guibg = nil, gui = 'none', guisp = nil }
hi.TSString             = { guifg = colors.bright_green, guibg = nil, gui = 'none', guisp = nil }
hi.TSStringRegex        = { guifg = colors.bright_aqua, guibg = nil, gui = 'none', guisp = nil }
hi.TSStringEscape       = { guifg = colors.bright_aqua, guibg = nil, gui = 'none', guisp = nil }
hi.TSSymbol             = { guifg = colors.bright_green, guibg = nil, gui = 'none', guisp = nil }
hi.TSTag                = { guifg = colors.bright_yellow, guibg = nil, gui = 'none', guisp = nil }
hi.TSTagDelimiter       = { guifg = colors.faded_orange, guibg = nil, gui = 'none', guisp = nil }
hi.TSText               = { guifg = colors.grey4, guibg = nil, gui = 'none', guisp = nil }
hi.TSStrong             = { guifg = nil, guibg = nil, gui = 'bold', guisp = nil }
hi.TSEmphasis           = { guifg = colors.bright_orange, guibg = nil, gui = 'italic', guisp = nil }
hi.TSUnderline          = { guifg = colors.black, guibg = nil, gui = 'underline', guisp = nil }
hi.TSStrike             = { guifg = colors.black, guibg = nil, gui = 'strikethrough', guisp = nil }
hi.TSTitle              = { guifg = colors.bright_blue, guibg = nil, gui = 'none', guisp = nil }
hi.TSLiteral            = { guifg = colors.bright_orange, guibg = nil, gui = 'none', guisp = nil }
hi.TSURI                = { guifg = colors.bright_orange, guibg = nil, gui = 'underline', guisp = nil }
hi.TSType               = { guifg = colors.bright_yellow, guibg = nil, gui = 'none', guisp = nil }
hi.TSTypeBuiltin        = { guifg = colors.bright_yellow, guibg = nil, gui = 'italic', guisp = nil }
hi.TSVariable           = { guifg = colors.bright_red, guibg = nil, gui = 'none', guisp = nil }
hi.TSVariableBuiltin    = { guifg = colors.bright_red, guibg = nil, gui = 'italic', guisp = nil }

hi.TSDefinition      = { guifg = nil, guibg = nil, gui = 'underline', guisp = colors.grey3 }
hi.TSDefinitionUsage = { guifg = nil, guibg = nil, gui = 'underline', guisp = colors.grey3 }
hi.TSCurrentScope    = { guifg = nil, guibg = nil, gui = 'bold', guisp = nil }

hi.NvimInternalError = { guifg = colors.black, guibg = colors.bright_red, gui = 'none', guisp = nil }

hi.NormalFloat  = { guifg = colors.grey4, guibg = nil, gui = nil, guisp = nil }
hi.FloatBorder  = { guifg = colors.grey4, guibg = nil, gui = nil, guisp = nil }
hi.NormalNC     = { guifg = colors.grey4, guibg = nil, gui = nil, guisp = nil }
hi.TermCursor   = { guifg = colors.black, guibg = colors.grey4, gui = 'none', guisp = nil }
hi.TermCursorNC = { guifg = colors.black, guibg = colors.grey4, gui = nil, guisp = nil }

hi.User1 = { guifg = colors.bright_red, guibg = colors.grey1, gui = 'none', guisp = nil }
hi.User2 = { guifg = colors.bright_purple, guibg = colors.grey1, gui = 'none', guisp = nil }
hi.User3 = { guifg = colors.grey4, guibg = colors.grey1, gui = 'none', guisp = nil }
hi.User4 = { guifg = colors.bright_aqua, guibg = colors.grey1, gui = 'none', guisp = nil }
hi.User5 = { guifg = colors.grey4, guibg = colors.grey1, gui = 'none', guisp = nil }
hi.User6 = { guifg = colors.grey4, guibg = colors.grey0, gui = 'none', guisp = nil }
hi.User7 = { guifg = colors.grey4, guibg = colors.grey1, gui = 'none', guisp = nil }
hi.User8 = { guifg = colors.black, guibg = colors.grey1, gui = 'none', guisp = nil }
hi.User9 = { guifg = colors.black, guibg = colors.grey1, gui = 'none', guisp = nil }

hi.TreesitterContext = { guifg = nil, guibg = colors.grey0, gui = 'italic', guisp = nil }

-- telescope
if utils.hex_re:match_str(colors.black) and utils.hex_re:match_str(colors.grey0) and
    utils.hex_re:match_str(colors.grey1) then
  local darkerbg           = utils.darken(colors.black, 0.1)
  local darkercursorline   = utils.darken(colors.grey0, 0.1)
  local darkerstatusline   = utils.darken(colors.grey1, 0.1)
  hi.TelescopeBorder       = { guifg = darkerbg, guibg = darkerbg, gui = nil, guisp = nil }
  hi.TelescopePromptBorder = { guifg = darkerstatusline, guibg = darkerstatusline, gui = nil, guisp = nil }
  hi.TelescopePromptNormal = { guifg = colors.grey4, guibg = darkerstatusline, gui = nil, guisp = nil }
  hi.TelescopePromptPrefix = { guifg = colors.bright_red, guibg = darkerstatusline, gui = nil, guisp = nil }
  hi.TelescopeNormal       = { guifg = nil, guibg = darkerbg, gui = nil, guisp = nil }
  hi.TelescopePreviewTitle = { guifg = darkercursorline, guibg = colors.bright_green, gui = nil, guisp = nil }
  hi.TelescopePromptTitle  = { guifg = darkercursorline, guibg = colors.bright_red, gui = nil, guisp = nil }
  hi.TelescopeResultsTitle = { guifg = darkerbg, guibg = darkerbg, gui = nil, guisp = nil }
  hi.TelescopeSelection    = { guifg = nil, guibg = darkerstatusline, gui = nil, guisp = nil }
  hi.TelescopePreviewLine  = { guifg = nil, guibg = colors.grey2, gui = 'none', guisp = nil }
end

-- nvim-notify
hi.NotifyERRORBorder = { guifg = colors.bright_red, guibg = nil, gui = 'none', guisp = nil }
hi.NotifyWARNBorder  = { guifg = colors.bright_purple, guibg = nil, gui = 'none', guisp = nil }
hi.NotifyINFOBorder  = { guifg = colors.grey4, guibg = nil, gui = 'none', guisp = nil }
hi.NotifyDEBUGBorder = { guifg = colors.bright_aqua, guibg = nil, gui = 'none', guisp = nil }
hi.NotifyTRACEBorder = { guifg = colors.bright_aqua, guibg = nil, gui = 'none', guisp = nil }
hi.NotifyERRORIcon   = { guifg = colors.bright_red, guibg = nil, gui = 'none', guisp = nil }
hi.NotifyWARNIcon    = { guifg = colors.bright_purple, guibg = nil, gui = 'none', guisp = nil }
hi.NotifyINFOIcon    = { guifg = colors.grey4, guibg = nil, gui = 'none', guisp = nil }
hi.NotifyDEBUGIcon   = { guifg = colors.bright_aqua, guibg = nil, gui = 'none', guisp = nil }
hi.NotifyTRACEIcon   = { guifg = colors.bright_aqua, guibg = nil, gui = 'none', guisp = nil }
hi.NotifyERRORTitle  = { guifg = colors.bright_red, guibg = nil, gui = 'none', guisp = nil }
hi.NotifyWARNTitle   = { guifg = colors.bright_purple, guibg = nil, gui = 'none', guisp = nil }
hi.NotifyINFOTitle   = { guifg = colors.grey4, guibg = nil, gui = 'none', guisp = nil }
hi.NotifyDEBUGTitle  = { guifg = colors.bright_aqua, guibg = nil, gui = 'none', guisp = nil }
hi.NotifyTRACETitle  = { guifg = colors.bright_aqua, guibg = nil, gui = 'none', guisp = nil }
hi.NotifyERRORBody   = 'Normal'
hi.NotifyWARNBody    = 'Normal'
hi.NotifyINFOBody    = 'Normal'
hi.NotifyDEBUGBody   = 'Normal'
hi.NotifyTRACEBody   = 'Normal'

-- indentblankline
hi.IndentBlanklineChar        = { guifg = colors.grey1, gui = 'nocombine' }
hi.IndentBlanklineContextChar = { guifg = colors.grey3, gui = 'nocombine' }

-- nvim-cmp
hi.CmpDocumentationBorder   = { guifg = colors.grey4, guibg = colors.black, gui = nil, guisp = nil }
hi.CmpDocumentation         = { guifg = colors.grey4, guibg = colors.black, gui = nil, guisp = nil }
hi.CmpItemAbbr              = { guifg = colors.grey4, guibg = colors.grey0, gui = nil, guisp = nil }
hi.CmpItemAbbrDeprecated    = { guifg = colors.grey2, guibg = nil, gui = 'strikethrough', guisp = nil }
hi.CmpItemAbbrMatch         = { guifg = colors.bright_blue, guibg = nil, gui = nil, guisp = nil }
hi.CmpItemAbbrMatchFuzzy    = { guifg = colors.bright_blue, guibg = nil, gui = nil, guisp = nil }
hi.CmpItemKindDefault       = { guifg = colors.grey4, guibg = nil, gui = nil, guisp = nil }
hi.CmpItemMenu              = { guifg = colors.grey3, guibg = nil, gui = nil, guisp = nil }
hi.CmpItemKindKeyword       = { guifg = colors.bright_purple, guibg = nil, gui = nil, guisp = nil }
hi.CmpItemKindVariable      = { guifg = colors.bright_red, guibg = nil, gui = nil, guisp = nil }
hi.CmpItemKindConstant      = { guifg = colors.bright_orange, guibg = nil, gui = nil, guisp = nil }
hi.CmpItemKindReference     = { guifg = colors.bright_red, guibg = nil, gui = nil, guisp = nil }
hi.CmpItemKindValue         = { guifg = colors.bright_orange, guibg = nil, gui = nil, guisp = nil }
hi.CmpItemKindFunction      = { guifg = colors.bright_blue, guibg = nil, gui = nil, guisp = nil }
hi.CmpItemKindMethod        = { guifg = colors.bright_blue, guibg = nil, gui = nil, guisp = nil }
hi.CmpItemKindConstructor   = { guifg = colors.bright_blue, guibg = nil, gui = nil, guisp = nil }
hi.CmpItemKindClass         = { guifg = colors.bright_yellow, guibg = nil, gui = nil, guisp = nil }
hi.CmpItemKindInterface     = { guifg = colors.bright_yellow, guibg = nil, gui = nil, guisp = nil }
hi.CmpItemKindStruct        = { guifg = colors.bright_yellow, guibg = nil, gui = nil, guisp = nil }
hi.CmpItemKindEvent         = { guifg = colors.bright_yellow, guibg = nil, gui = nil, guisp = nil }
hi.CmpItemKindEnum          = { guifg = colors.bright_yellow, guibg = nil, gui = nil, guisp = nil }
hi.CmpItemKindUnit          = { guifg = colors.bright_yellow, guibg = nil, gui = nil, guisp = nil }
hi.CmpItemKindModule        = { guifg = colors.grey4, guibg = nil, gui = nil, guisp = nil }
hi.CmpItemKindProperty      = { guifg = colors.bright_red, guibg = nil, gui = nil, guisp = nil }
hi.CmpItemKindField         = { guifg = colors.bright_red, guibg = nil, gui = nil, guisp = nil }
hi.CmpItemKindTypeParameter = { guifg = colors.bright_yellow, guibg = nil, gui = nil, guisp = nil }
hi.CmpItemKindEnumMember    = { guifg = colors.bright_yellow, guibg = nil, gui = nil, guisp = nil }
hi.CmpItemKindOperator      = { guifg = colors.grey4, guibg = nil, gui = nil, guisp = nil }
hi.CmpItemKindSnippet       = { guifg = colors.grey3, guibg = nil, gui = nil, guisp = nil }

-- markdown
hi['@text.title'] = { guifg = colors.bright_aqua, guibg = nil, gui = 'bold', guisp = nil }
hi['@text.reference'] = { guifg = colors.bright_purple, guibg = nil, gui = nil, guisp = nil }
hi['@text.literal'] = { guifg = colors.bright_purple, guibg = nil, gui = nil, guisp = nil }
hi['@text.uri'] = { guifg = colors.bright_blue, guibg = nil, gui = nil, guisp = nil }
hi['@punctuation.delimiter'] = { guifg = colors.grey4, guibg = nil, gui = nil, guisp = nil }
hi['@punctuation.special'] = { guifg = colors.bright_blue, guibg = nil, gui = nil, guisp = nil }
hi['@none'] = { guifg = colors.bright_yellow, guibg = nil, gui = nil, guisp = nil }

-- highlight groups
vim.cmd('set background=' .. colors.mode)
vim.cmd('hi! SignColumn guibg=None')
vim.cmd('hi! Conceal guifg=' .. (colors.mode == "light" and colors.faded_blue or colors.bright_blue) .. ' guibg = ' .. colors.black)

-- Neovim LSP virtual diagnostics
vim.cmd('sign define DiagnosticSignError text= texthl=LspDiagnosticsDefaultError       linehl= numhl=')
vim.cmd('sign define DiagnosticSignWarn  text= texthl=LspDiagnosticsDefaultWarning     linehl= numhl=')
vim.cmd('sign define DiagnosticSignInfo  text= texthl=LspDiagnosticsDefaultInformation linehl= numhl=')
vim.cmd('sign define DiagnosticSignHint  text= texthl=LspDiagnosticsDefaultHint        linehl= numhl=')
