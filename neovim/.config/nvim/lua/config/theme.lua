local colorsFound, colors = pcall(require, 'config/colors')
if not colorsFound then
  vim.notify('please generate colors file using the colorscheme script')
  return
end

vim.bo.syntax = 'ON'
vim.opt.termguicolors = true

local utils = require('config/utils/color-utils')

if vim.fn.exists('syntax_on') then
  vim.cmd('syntax reset')
end
local hl                              = utils.highlight
local darkerbg                        = utils.darken(colors.black, 0.1)
local darkercursorline                = utils.darken(colors.grey0, 0.1)
local darkerstatusline                = utils.darken(colors.grey1, 0.1)
local darkeraccent                    = utils.darken(colors.accent, 0.1)

-- new treesitter highlights
hl["@comment.error"]                  = { link = "@text.danger" }
hl["@comment.hint"]                   = { link = "@text.note" }
hl["@comment.info"]                   = { link = "@text.note" }
hl["@comment.note"]                   = { link = "@text.note" }
hl["@comment.ok"]                     = { link = "@text.note" }
hl["@comment.todo"]                   = { link = "@text.todo" }
hl["@comment.warning"]                = { link = "@text.warning" }
hl["@diff.delta"]                     = { link = "@text.diff.change" }
hl["@diff.minus"]                     = { link = "@text.diff.delete" }
hl["@diff.plus"]                      = { link = "@text.diff.add" }
hl["@function.method"]                = { link = "@method" }
hl["@function.method.call"]           = { link = "@method.call" }
hl["@keyword.conditional"]            = { link = "@conditional" }
hl["@keyword.debug"]                  = { link = "@debug" }
hl["@keyword.directive"]              = { link = "@define" }
hl["@keyword.directive"]              = { link = "@preproc" }
hl["@keyword.exception"]              = { link = "@exception" }
hl["@keyword.import"]                 = { link = "@include" }
hl["@keyword.repeat"]                 = { link = "@repeat" }
hl["@keyword.storage"]                = { link = "@storageclass" }
hl["@markup.environment"]             = { link = "@text.environment" }
hl["@markup.environment.name"]        = { link = "@text.environment.name" }
hl["@markup.heading"]                 = { link = "@text.title" }
hl["@markup.italic"]                  = { link = "@text.emphasis" }
hl["@markup.link"]                    = { link = "@text.reference" }
hl["@markup.link.label"]              = { link = "@string.special" }
hl["@markup.link.url"]                = { link = "@text.uri" }
hl["@markup.list"]                    = { link = "@punctuation.special" }
hl["@markup.math"]                    = { link = "@text.math" }
hl["@markup.quote"]                   = { link = "@text.quote" }
hl["@markup.raw"]                     = { link = "@text.literal" }
hl["@markup.raw.block"]               = { link = "@text.literal.block" }
hl["@markup.strikethrough"]           = { link = "@text.strike" }
hl["@markup.strong"]                  = { link = "@text.strong" }
hl["@markup.underline"]               = { link = "@text.underline" } -- note: some are changed to @string.special
hl["@module"]                         = { link = "@namespace" }
hl["@number.float"]                   = { link = "@float" }
hl["@string.regexp"]                  = { link = "@string.regex" }
hl["@string.special.symbol"]          = { link = "@symbol" }
hl["@string.special.url"]             = { link = "@text.uri" }
hl["@variable.member"]                = { link = "@field" }
hl["@variable.parameter"]             = { link = "@parameter" }

-- Vim editor colors
hl.Bold                               = { bold = true, }
hl.ColorColumn                        = { bg = colors.grey0, }
hl.Conceal                            = { fg = colors.bright_blue, bg = colors.black, }
hl.Cursor                             = { fg = colors.black, bg = colors.grey4, }
hl.CursorColumn                       = { bg = colors.grey0, }
hl.CursorLine                         = { bg = colors.grey0, }
hl.CursorLineNr                       = { fg = colors.grey3, bg = colors.grey0, }
hl.Debug                              = { fg = colors.bright_red, }
hl.Directory                          = { fg = colors.bright_blue, }
hl.EndOfBuffer                        = { fg = colors.grey2, }
hl.Error                              = { fg = colors.black, bg = colors.bright_red, bold = true, }
hl.ErrorMsg                           = { fg = colors.bright_red, bg = colors.black, }
hl.Exception                          = { fg = colors.bright_red, }
hl.FoldColumn                         = { fg = colors.bright_aqua, bg = colors.black, }
hl.Folded                             = { fg = colors.grey2, bg = colors.grey0, }
hl.IncSearch                          = { fg = colors.grey0, bg = colors.bright_orange, }
hl.Italic                             = { standout = true }
hl.LineNr                             = { fg = colors.grey3, }
hl.LineNrAbove                        = { fg = colors.grey4, }
hl.LineNrBelow                        = { fg = colors.grey4, }
hl.Macro                              = { fg = colors.bright_red, }
hl.MatchParen                         = { bg = colors.grey2, }
hl.ModeMsg                            = { fg = colors.bright_green, }
hl.MoreMsg                            = { fg = colors.bright_green, }
hl.NonText                            = { fg = colors.grey2, }
hl.Normal                             = { fg = colors.grey4, }
hl.PMenu                              = { fg = colors.grey4, bg = colors.grey0, }
hl.PMenuSel                           = { fg = colors.grey0, bg = colors.grey4, }
hl.Question                           = { fg = colors.bright_blue, }
hl.QuickFixLine                       = { bg = colors.grey0, }
hl.Search                             = { fg = colors.grey0, bg = colors.bright_yellow, }
hl.SignColumn                         = { fg = colors.grey3, }
hl.SpecialKey                         = { fg = colors.grey2, }
hl.StatusLine                         = { fg = colors.grey4, bg = colors.grey1, }
hl.StatusLineNC                       = { fg = colors.grey3, bg = colors.grey0, }
hl.Substitute                         = { fg = colors.grey0, bg = colors.bright_yellow, }
hl.TabLine                            = { fg = colors.grey2, bg = colors.grey0, }
hl.TabLineFill                        = { fg = colors.grey2, bg = colors.grey0, }
hl.TabLineSel                         = { fg = colors.bright_green, bg = colors.grey0, }
hl.Title                              = { fg = colors.bright_blue, }
hl.TooLong                            = { fg = colors.bright_red, }
hl.Underlined                         = { fg = colors.bright_red, }
hl.VertSplit                          = { fg = colors.grey2, }
hl.Visual                             = { bg = colors.grey1, }
hl.VisualNOS                          = { fg = colors.bright_red, }
hl.WarningMsg                         = { fg = colors.bright_red, }
hl.WildMenu                           = { fg = colors.bright_red, bg = colors.bright_yellow, }
hl.WinBar                             = { fg = colors.grey4, }
hl.WinBarNC                           = { fg = colors.grey3, }

-- Standard syntax highlighting
hl.Boolean                            = { fg = colors.bright_orange, }
hl.Character                          = { fg = colors.bright_red, }
hl.Comment                            = { fg = colors.grey2, italic = true, }
hl.Conditional                        = { fg = colors.bright_purple, }
hl.Constant                           = { fg = colors.bright_orange, }
hl.Define                             = { fg = colors.bright_purple, }
hl.Delimiter                          = { fg = colors.faded_orange, }
hl.Float                              = { fg = colors.bright_orange, bg = darkerbg, }
hl.Function                           = { fg = colors.bright_blue, }
hl.Identifier                         = { fg = colors.bright_red, }
hl.Include                            = { fg = colors.bright_blue, }
hl.Keyword                            = { fg = colors.bright_purple, }
hl.Label                              = { fg = colors.bright_yellow, }
hl.Number                             = { fg = colors.bright_orange, }
hl.Operator                           = { fg = colors.grey4, }
hl.PreProc                            = { fg = colors.bright_yellow, }
hl.Repeat                             = { fg = colors.bright_yellow, }
hl.Special                            = { fg = colors.bright_aqua, }
hl.SpecialChar                        = { fg = colors.faded_orange, }
hl.Statement                          = { fg = colors.bright_red, }
hl.StorageClass                       = { fg = colors.bright_yellow, }
hl.String                             = { fg = colors.bright_green, }
hl.Structure                          = { fg = colors.bright_purple, }
hl.Tag                                = { fg = colors.bright_yellow, }
hl.Todo                               = { fg = colors.bright_yellow, bg = colors.grey0, bold = true, }
hl.Type                               = { fg = colors.bright_yellow, }
hl.Typedef                            = { fg = colors.bright_yellow, }

-- Diff highlighting
hl.DiffAdd                            = { fg = colors.black, bg = colors.bright_green, }
hl.DiffChange                         = { fg = colors.grey2, bg = colors.bright_blue, }
hl.DiffDelete                         = { fg = colors.black, bg = colors.bright_red, }
hl.DiffText                           = { fg = colors.black, bg = colors.neutral_blue, }
hl.DiffAdded                          = { fg = colors.bright_green, bg = colors.black, }
hl.DiffChanged                        = { fg = colors.bright_blue, bg = colors.black, }
hl.DiffFile                           = { fg = colors.bright_red, bg = colors.black, }
hl.DiffNewFile                        = { fg = colors.bright_green, bg = colors.black, }
hl.DiffOldFile                        = { fg = colors.bright_red, bg = colors.black, }
hl.DiffLine                           = { fg = colors.bright_blue, bg = colors.black, }
hl.DiffRemoved                        = { fg = colors.bright_red, bg = colors.black, }

-- Git highlighting
hl.gitcommitOverflow                  = { fg = colors.bright_red, }
hl.gitcommitSummary                   = { fg = colors.bright_green, }
hl.gitcommitComment                   = { fg = colors.grey2, }
hl.gitcommitUntracked                 = { fg = colors.grey2, }
hl.gitcommitDiscarded                 = { fg = colors.grey2, }
hl.gitcommitSelected                  = { fg = colors.grey2, }
hl.gitcommitHeader                    = { fg = colors.bright_purple, }
hl.gitcommitSelectedType              = { fg = colors.bright_blue, }
hl.gitcommitUnmergedType              = { fg = colors.bright_blue, }
hl.gitcommitDiscardedType             = { fg = colors.bright_blue, }
hl.gitcommitBranch                    = { fg = colors.bright_orange, bold = true, }
hl.gitcommitUntrackedFile             = { fg = colors.bright_yellow, }
hl.gitcommitUnmergedFile              = { fg = colors.bright_red, bold = true, }
hl.gitcommitDiscardedFile             = { fg = colors.bright_red, bold = true, }
hl.gitcommitSelectedFile              = { fg = colors.bright_green, bold = true, }

-- GitGutter highlighting
hl.GitGutterAdd                       = { fg = colors.bright_green, bg = colors.black, }
hl.GitGutterChange                    = { fg = colors.bright_blue, bg = colors.black, }
hl.GitGutterDelete                    = { fg = colors.bright_red, bg = colors.black, }
hl.GitGutterChangeDelete              = { fg = colors.bright_purple, bg = colors.black, }

-- Spelling highlighting
hl.SpellBad                           = { undercurl = true, sp = colors.bright_red }
hl.SpellLocal                         = { undercurl = true, sp = colors.bright_aqua }
hl.SpellCap                           = { undercurl = true, sp = colors.bright_blue }
hl.SpellRare                          = { undercurl = true, sp = colors.bright_purple }

hl.DiagnosticError                    = { fg = colors.bright_red, }
hl.DiagnosticWarn                     = { fg = colors.bright_yellow, }
hl.DiagnosticInfo                     = { fg = colors.bright_blue, }
hl.DiagnosticHint                     = { fg = colors.bright_aqua, }
hl.DiagnosticUnderlineError           = { undercurl = true, sp = colors.bright_red }
hl.DiagnosticUnderlineWarning         = { undercurl = true, sp = colors.bright_purple }
hl.DiagnosticUnderlineWarn            = { undercurl = true, sp = colors.bright_purple }
hl.DiagnosticUnderlineInformation     = { undercurl = true, sp = colors.faded_orange }
hl.DiagnosticUnderlineHint            = { undercurl = true, sp = colors.bright_aqua }

hl.LspReferenceText                   = { underline = true, sp = colors.grey3 }
hl.LspReferenceRead                   = { underline = true, sp = colors.grey3 }
hl.LspReferenceWrite                  = { underline = true, sp = colors.grey3 }
hl.LspDiagnosticsDefaultError         = { fg = colors.bright_red, sp = colors.grey3 }    -- 'DiagnosticError'
hl.LspDiagnosticsDefaultWarning       = { fg = colors.bright_yellow, sp = colors.grey3 } -- 'DiagnosticWarn'
hl.LspDiagnosticsDefaultInformation   = { fg = colors.bright_blue, sp = colors.grey3 }   -- 'DiagnosticInfo'
hl.LspDiagnosticsDefaultHint          = { fg = colors.bright_aqua, sp = colors.grey3 }   -- 'DiagnosticHint'
hl.LspDiagnosticsUnderlineError       = { link = 'DiagnosticUnderlineError' }
hl.LspDiagnosticsUnderlineWarning     = { link = 'DiagnosticUnderlineWarning' }
hl.LspDiagnosticsUnderlineInformation = { link = 'DiagnosticUnderlineInformation' }
hl.LspDiagnosticsUnderlineHint        = { link = 'DiagnosticUnderlineHint' }

hl.TSAnnotation                       = { fg = colors.faded_orange, }
hl.TSAttribute                        = { fg = colors.bright_yellow, }
hl.TSBoolean                          = { fg = colors.bright_orange, }
hl.TSCharacter                        = { fg = colors.bright_red, }
hl.TSComment                          = { fg = colors.grey2, standout = true, }
hl.TSConstructor                      = { fg = colors.bright_blue, }
hl.TSConditional                      = { fg = colors.bright_purple, }
hl.TSConstant                         = { fg = colors.bright_orange, }
hl.TSConstBuiltin                     = { fg = colors.bright_orange, standout = true, }
hl.TSConstMacro                       = { fg = colors.bright_red, }
hl.TSError                            = { fg = colors.bright_red, }
hl.TSException                        = { fg = colors.bright_red, }
hl.TSField                            = { fg = colors.grey4, }
hl.TSFloat                            = { fg = colors.bright_orange, }
hl.TSFunction                         = { fg = colors.bright_blue, }
hl.TSFuncBuiltin                      = { fg = colors.bright_blue, standout = true, }
hl.TSFuncMacro                        = { fg = colors.bright_red, }
hl.TSInclude                          = { fg = colors.bright_blue, }
hl.TSKeyword                          = { fg = colors.bright_purple, }
hl.TSKeywordFunction                  = { fg = colors.bright_purple, }
hl.TSKeywordOperator                  = { fg = colors.bright_purple, }
hl.TSLabel                            = { fg = colors.bright_yellow, }
hl.TSMethod                           = { fg = colors.bright_blue, }
hl.TSNamespace                        = { fg = colors.bright_red, }
hl.TSNone                             = { fg = colors.grey4, }
hl.TSNumber                           = { fg = colors.bright_orange, }
hl.TSOperator                         = { fg = colors.grey4, }
hl.TSParameter                        = { fg = colors.grey4, }
hl.TSParameterReference               = { fg = colors.grey4, }
hl.TSProperty                         = { fg = colors.grey4, }
hl.TSPunctDelimiter                   = { fg = colors.faded_orange, }
hl.TSPunctBracket                     = { fg = colors.grey4, }
hl.TSPunctSpecial                     = { fg = colors.grey4, }
hl.TSRepeat                           = { fg = colors.bright_purple, }
hl.TSString                           = { fg = colors.bright_green, }
hl.TSStringRegex                      = { fg = colors.bright_aqua, }
hl.TSStringEscape                     = { fg = colors.bright_aqua, }
hl.TSSymbol                           = { fg = colors.bright_green, }
hl.TSTag                              = { fg = colors.bright_yellow, }
hl.TSTagDelimiter                     = { fg = colors.faded_orange, }
hl.TSText                             = { fg = colors.grey4, }
hl.TSStrong                           = { bold = true, }
hl.TSEmphasis                         = { fg = colors.bright_orange, italic = true, }
hl.TSUnderline                        = { fg = colors.black, underline = true, }
hl.TSStrike                           = { fg = colors.black, strikethrough = true, }
hl.TSTitle                            = { fg = colors.bright_blue, }
hl.TSLiteral                          = { fg = colors.bright_orange, }
hl.TSURI                              = { fg = colors.bright_orange, underline = true, }
hl.TSType                             = { fg = colors.bright_yellow, }
hl.TSTypeBuiltin                      = { fg = colors.bright_yellow, standout = true, }
hl.TSVariable                         = { fg = colors.bright_red, }
hl.TSVariableBuiltin                  = { fg = colors.bright_red, standout = true, }

hl.TSDefinition                       = { underline = true, sp = colors.grey3 }
hl.TSDefinitionUsage                  = { underline = true, sp = colors.grey3 }
hl.TSCurrentScope                     = { bold = true, }

hl.NvimInternalError                  = { fg = colors.black, bg = colors.bright_red, }

hl.NormalFloat                        = { fg = colors.grey4, bg = darkerbg, }
hl.FloatBorder                        = { fg = colors.grey2, bg = darkerbg, }
hl.NormalNC                           = { fg = colors.grey4, }
hl.TermCursor                         = { fg = colors.black, bg = colors.grey4, }
hl.TermCursorNC                       = { fg = colors.black, bg = colors.grey4, }

hl.User1                              = { fg = colors.bright_red, bg = colors.grey1, }
hl.User2                              = { fg = colors.bright_purple, bg = colors.grey1, }
hl.User3                              = { fg = colors.grey4, bg = colors.grey1, }
hl.User4                              = { fg = colors.bright_aqua, bg = colors.grey1, }
hl.User5                              = { fg = colors.grey4, bg = colors.grey1, }
hl.User6                              = { fg = colors.grey4, bg = colors.grey0, }
hl.User7                              = { fg = colors.grey4, bg = colors.grey1, }
hl.User8                              = { fg = colors.black, bg = colors.grey1, }
hl.User9                              = { fg = colors.black, bg = colors.grey1, }

hl.TreesitterContext                  = { bg = colors.grey0, standout = true, }

-- telescope
hl.TelescopeBorder                    = { link = 'FloatBorder' }
hl.TelescopePromptBorder              = { link = 'FloatBorder' }
hl.TelescopePromptNormal              = { fg = colors.grey4, bg = darkerbg, }
hl.TelescopePromptPrefix              = { fg = colors.bright_red, bg = darkerbg, }
hl.TelescopeNormal                    = { bg = darkerbg, }
hl.TelescopePreviewTitle              = { fg = darkercursorline, bg = colors.bright_green, bold = true, }
hl.TelescopePromptTitle               = { fg = darkercursorline, bg = colors.bright_red, bold = true, }
hl.TelescopeResultsTitle              = { fg = darkerbg, bg = darkerbg, bold = true, }
hl.TelescopeSelection                 = { bg = darkerstatusline, }
hl.TelescopePreviewLine               = { bg = colors.grey1, }

-- nvim-notify
hl.NotifyDEBUGBody                    = { link = 'Float' }
hl.NotifyDEBUGBorder                  = { link = 'FloatBorder' }
hl.NotifyDEBUGIcon                    = { fg = colors.bright_aqua, bg = darkerbg, }
hl.NotifyDEBUGTitle                   = { fg = colors.bright_aqua, bg = darkerbg, bold = true, }

hl.NotifyERRORBody                    = { link = 'Float' }
hl.NotifyERRORBorder                  = { link = 'FloatBorder' }
hl.NotifyERRORIcon                    = { fg = colors.bright_red, bg = darkerbg, }
hl.NotifyERRORTitle                   = { fg = colors.bright_red, bg = darkerbg, bold = true, }

hl.NotifyINFOBody                     = { link = 'Float' }
hl.NotifyINFOBorder                   = { link = 'FloatBorder' }
hl.NotifyINFOIcon                     = { fg = colors.bright_green, bg = darkerbg, }
hl.NotifyINFOTitle                    = { fg = colors.bright_green, bg = darkerbg, bold = true, }

hl.NotifyTRACEBody                    = { link = 'Float' }
hl.NotifyTRACEBorder                  = { link = 'FloatBorder' }
hl.NotifyTRACEIcon                    = { fg = colors.bright_aqua, bg = darkerbg, }
hl.NotifyTRACETitle                   = { fg = colors.bright_aqua, bg = darkerbg, bold = true, }

hl.NotifyWARNBody                     = { link = 'Float' }
hl.NotifyWARNBorder                   = { link = 'FloatBorder' }
hl.NotifyWARNIcon                     = { fg = colors.bright_purple, bg = darkerbg, }
hl.NotifyWARNTitle                    = { fg = colors.bright_purple, bg = darkerbg, bold = true, }

hl.NotifyBackground                   = { fg = colors.bright_aqua, bg = darkerbg, }

-- indentblankline
hl.IndentBlanklineChar                = { fg = colors.grey1, nocombine = true, }
hl.IndentBlanklineContextChar         = { fg = colors.grey3, nocombine = true, }
hl.IndentBlanklineSpaceChar           = { fg = colors.grey2, nocombine = true, }
hl.IndentBlanklineSpaceCharBlankline  = { fg = colors.white, nocombine = true, }

-- nvim-cmp
hl.CmpDocumentationBorder             = { fg = colors.grey4, bg = colors.black, }
hl.CmpDocumentation                   = { fg = colors.grey4, bg = colors.black, }
hl.CmpItemAbbr                        = { fg = colors.grey4, bg = colors.grey0, }
hl.CmpItemAbbrDeprecated              = { fg = colors.grey2, strikethrough = true, }
hl.CmpItemAbbrMatch                   = { fg = colors.bright_blue, }
hl.CmpItemAbbrMatchFuzzy              = { fg = colors.bright_blue, }
hl.CmpItemKindDefault                 = { fg = colors.grey4, }
hl.CmpItemMenu                        = { fg = colors.grey3, }
hl.CmpItemKindKeyword                 = { fg = colors.black, bg = colors.bright_purple, }
hl.CmpItemKindVariable                = { fg = colors.black, bg = colors.bright_red, }
hl.CmpItemKindConstant                = { fg = colors.black, bg = colors.bright_orange, }
hl.CmpItemKindReference               = { fg = colors.black, bg = colors.bright_red, }
hl.CmpItemKindValue                   = { fg = colors.black, bg = colors.bright_orange, }
hl.CmpItemKindFunction                = { fg = colors.black, bg = colors.bright_blue, }
hl.CmpItemKindMethod                  = { fg = colors.black, bg = colors.bright_blue, }
hl.CmpItemKindConstructor             = { fg = colors.black, bg = colors.bright_blue, }
hl.CmpItemKindClass                   = { fg = colors.black, bg = colors.bright_yellow, }
hl.CmpItemKindInterface               = { fg = colors.black, bg = colors.bright_yellow, }
hl.CmpItemKindStruct                  = { fg = colors.black, bg = colors.bright_yellow, }
hl.CmpItemKindEvent                   = { fg = colors.black, bg = colors.bright_yellow, }
hl.CmpItemKindEnum                    = { fg = colors.black, bg = colors.bright_yellow, }
hl.CmpItemKindUnit                    = { fg = colors.black, bg = colors.bright_yellow, }
hl.CmpItemKindModule                  = { fg = colors.black, bg = colors.grey4, }
hl.CmpItemKindProperty                = { fg = colors.black, bg = colors.bright_red, }
hl.CmpItemKindField                   = { fg = colors.black, bg = colors.bright_red, }
hl.CmpItemKindTypeParameter           = { fg = colors.black, bg = colors.bright_yellow, }
hl.CmpItemKindText                    = { fg = colors.black, bg = colors.bright_green, }
hl.CmpItemKindEnumMember              = { fg = colors.black, bg = colors.bright_yellow, }
hl.CmpItemKindOperator                = { fg = colors.black, bg = colors.grey4, }
hl.CmpItemKindSnippet                 = { fg = colors.black, bg = colors.grey3, }
hl.CmpItemKindColor                   = { fg = colors.black, bg = colors.bright_blue, }
hl.CmpItemKindFile                    = { fg = colors.black, bg = colors.bright_purple, }
hl.CmpItemKindFolder                  = { fg = colors.black, bg = colors.bright_yellow, }

-- markdown
local function getMdTitleHighlight(level)
  local darkenFactor = 0.05
  local titleDarkenFactors = {
    darkenFactor * 0,
    darkenFactor * 1,
    darkenFactor * 2,
    darkenFactor * 3,
    darkenFactor * 4,
    darkenFactor * 5,
  }

  return {
    fg = utils.darken(colors.bright_aqua, titleDarkenFactors[level]),
    bg = nil,
    bold = true,
  }
end

hl['@text.title.1']                        = getMdTitleHighlight(1)
hl['@text.title.2']                        = getMdTitleHighlight(2)
hl['@text.title.3']                        = getMdTitleHighlight(3)
hl['@text.title.4']                        = getMdTitleHighlight(4)
hl['@text.title.5']                        = getMdTitleHighlight(5)
hl['@text.title.6']                        = getMdTitleHighlight(6)

hl['@text.title.1.marker']                 = { fg = colors.grey3, bold = true, }
hl['@text.title.2.marker']                 = { fg = colors.grey3, bold = true, }
hl['@text.title.3.marker']                 = { fg = colors.grey3, bold = true, }
hl['@text.title.4.marker']                 = { fg = colors.grey3, bold = true, }
hl['@text.title.5.marker']                 = { fg = colors.grey3, bold = true, }
hl['@text.title.6.marker']                 = { fg = colors.grey3, bold = true, }

hl['@text.reference']                      = { fg = colors.bright_purple, }
hl['@text.literal']                        = { fg = colors.bright_purple, }
hl['@text.uri']                            = { fg = colors.bright_blue, }

hl['@markdown_check_undone']               = { fg = colors.bright_yellow, }
hl['@markdown_check_done']                 = { fg = colors.bright_green, }
hl['@markdown_list_marker']                = { fg = darkeraccent, }
hl['@none']                                = { fg = colors.bright_yellow, }
hl['@punctuation.bracket']                 = { fg = darkeraccent, }
hl['@punctuation.delimiter']               = { fg = colors.grey4, }
hl['@punctuation.special']                 = { fg = darkeraccent, }
hl['@puntuation.strikethrough']            = { fg = darkeraccent, strikethrough = true, }
hl['@text.emphasis']                       = { fg = darkeraccent, italic = true, }
hl['@text.quote']                          = { fg = darkeraccent, bg = colors.grey0, italic = true, }
hl['@markdown_quote_marker']               = { fg = darkeraccent, bg = colors.grey0, }
hl['@text.strike']                         = { fg = darkeraccent, strikethrough = true, }
hl['@text.strong']                         = { fg = darkeraccent, bold = true, }

local mdCodeBlockBg                        = nil
hl['@markdown_code_block_marker']          = { fg = colors.bright_yellow, bg = mdCodeBlockBg, bold = true, }
hl['@markdown_code_block_lang_javascript'] = { fg = colors.bright_yellow, bg = mdCodeBlockBg, bold = true, }
hl['@markdown_code_block_lang_typescript'] = { fg = colors.bright_blue, bg = mdCodeBlockBg, bold = true, }
hl['@markdown_code_block_lang_lua']        = { fg = colors.bright_purple, bg = mdCodeBlockBg, bold = true, }
hl['@markdown_code_block_lang_bash']       = { fg = colors.bright_green, bg = mdCodeBlockBg, bold = true, }
hl['@markdown_code_block_lang_json']       = { fg = colors.bright_orange, bg = mdCodeBlockBg, bold = true, }
hl['@markdown_code_block_lang_diff']       = { fg = colors.bright_red, bg = mdCodeBlockBg, bold = true, }
hl['@markdown_code_block_lang_vim']        = { fg = colors.bright_aqua, bg = mdCodeBlockBg, bold = true, }
hl['@markdown_code_block_lang_yaml']       = { fg = colors.bright_orange, bg = mdCodeBlockBg, bold = true, }
hl['@markdown_code_block_lang_java']       = { fg = colors.bright_blue, bg = mdCodeBlockBg, bold = true, }
hl['@markdown_code_block_lang_html']       = { fg = colors.bright_purple, bg = colors.grey0, bold = true, }
hl['@markdown_code_block_lang_css']        = { fg = colors.bright_blue, bg = colors.grey0, bold = true, }
hl['@markdown_code_block_lang_sql']        = { fg = colors.bright_yellow, bg = colors.grey0, bold = true, }

-- comments
hl['@text.todo']                           = { fg = colors.black, bg = colors.bright_yellow, bold = true, }
hl['@text.note']                           = { fg = colors.black, bg = colors.bright_aqua, bold = true, }
hl['@text.danger']                         = { fg = colors.black, bg = colors.bright_red, bold = true, }
hl['@text.warning']                        = { fg = colors.black, bg = colors.bright_orange, bold = true, }

-- unlink todo checkbox highlights
-- hl['@text.todo.checked.markdown']          = {}
-- hl['@text.todo.unchecked.markdown']        = {}

-- gitsigns
hl.GitSignsAdd                             = { fg = colors.bright_green, }
hl.GitSignsChange                          = { fg = colors.bright_aqua, }
hl.GitSignsDelete                          = { fg = colors.bright_red, }
hl.GitSignsChangeDelete                    = { fg = colors.bright_aqua, bg = colors.bright_red }

-- diff
hl['@text.diff.delete']                    = { fg = colors.neutral_red, bold = true, }
hl['@text.diff.add']                       = { fg = colors.neutral_green, bold = true, }

-- highlight groups
vim.cmd('set background=' .. colors.mode)
vim.cmd('hi! SignColumn guibg=None')
vim.cmd('hi! Conceal guifg=' ..
  (colors.mode == "light" and colors.faded_orange or colors.bright_orange) .. ' guibg = ' .. 'None')

-- Neovim LSP virtual diagnostics
vim.cmd('sign define DiagnosticSignError text= texthl=LspDiagnosticsDefaultError       linehl= numhl=')
vim.cmd('sign define DiagnosticSignWarn  text= texthl=LspDiagnosticsDefaultWarning     linehl= numhl=')
vim.cmd('sign define DiagnosticSignInfo  text= texthl=LspDiagnosticsDefaultInformation linehl= numhl=')
vim.cmd('sign define DiagnosticSignHint  text= texthl=LspDiagnosticsDefaultHint        linehl= numhl=')

hl.healthSuccess          = { fg = colors.neutral_aqua, bold = true, }
hl.healthHelp             = { fg = colors.faded_blue, bold = true, }
hl.healthError            = { fg = colors.bright_red, bold = true, }
hl.healthWarning          = { fg = colors.bright_orange, bold = true, }

-- winbar
hl.winbarFileName         = { fg = colors.black, bg = colors.accent, bold = true, }
hl.winbarFileNameModified = { fg = colors.black, bg = colors.neutral_aqua, }

local function winbarTagHighlight(group, fg)
  hl[group] = { bg = colors.grey1, fg = fg }
end
local function winbarTagHighlightIcon(group)
  hl[group] = { bg = colors.grey1, fg = colors.bright_green }
end

winbarTagHighlight("winbarTags", colors.white)
winbarTagHighlight("NavicText", colors.white)
winbarTagHighlight("NavicSeparator", colors.bright_orange)

winbarTagHighlightIcon("NavicIconsArray")
winbarTagHighlightIcon("NavicIconsBoolean")
winbarTagHighlightIcon("NavicIconsClass")
winbarTagHighlightIcon("NavicIconsConstant")
winbarTagHighlightIcon("NavicIconsConstructor")
winbarTagHighlightIcon("NavicIconsEnum")
winbarTagHighlightIcon("NavicIconsEnumMember")
winbarTagHighlightIcon("NavicIconsEvent")
winbarTagHighlightIcon("NavicIconsField")
winbarTagHighlightIcon("NavicIconsFile")
winbarTagHighlightIcon("NavicIconsFunction")
winbarTagHighlightIcon("NavicIconsInterface")
winbarTagHighlightIcon("NavicIconsKey")
winbarTagHighlightIcon("NavicIconsMethod")
winbarTagHighlightIcon("NavicIconsModule")
winbarTagHighlightIcon("NavicIconsNamespace")
winbarTagHighlightIcon("NavicIconsNull")
winbarTagHighlightIcon("NavicIconsNumber")
winbarTagHighlightIcon("NavicIconsObject")
winbarTagHighlightIcon("NavicIconsOperator")
winbarTagHighlightIcon("NavicIconsPackage")
winbarTagHighlightIcon("NavicIconsProperty")
winbarTagHighlightIcon("NavicIconsString")
winbarTagHighlightIcon("NavicIconsStruct")
winbarTagHighlightIcon("NavicIconsTypeParameter")
winbarTagHighlightIcon("NavicIconsVariable")

-- statusline
local background                = colors.grey0
local foreground                = colors.white

hl.statusLineModeNormal         = { fg = colors.grey0, bg = colors.bright_aqua, bold = true }
hl.statusLineModeInsert         = { fg = colors.grey0, bg = colors.bright_blue, bold = true, }
hl.statusLineModeVisual         = { fg = colors.grey0, bg = colors.bright_orange, bold = true, }
hl.statusLineModeCommand        = { fg = colors.grey0, bg = colors.bright_yellow, bold = true, }
hl.statusLineModeTerminal       = { fg = colors.grey0, bg = colors.bright_purple, bold = true, }
hl.statusLineTabNormal          = { fg = foreground, bg = background, }
hl.statuslineTabActive          = { fg = background, bg = colors.accent, }
hl.statuslineTabInactive        = { fg = colors.white, bg = colors.grey2, }
hl.statusLineBranch             = { fg = foreground, bg = background, bold = true, }
hl.statusLineCwd                = { fg = colors.bright_blue, bg = background, }
hl.statusLineFileName           = { fg = colors.bright_aqua, bg = background, }
hl.statusLineFileNameModified   = { fg = colors.bright_red, bg = background, }
hl.statusLineSpacer             = { fg = foreground, bg = background, }
hl.statusLineDiagnosticsError   = { fg = colors.bright_red, bg = background, }
hl.statusLineDiagnosticsWarning = { fg = colors.bright_yellow, bg = background, }
hl.statusLineDiagnosticsInfo    = { bg = background, fg = colors.bright_aqua, }
hl.statusLineLspClient          = { bg = background, fg = colors.bright_orange, }
hl.statusLineFileType           = { fg = foreground, bg = background, }
hl.statusLineProgress           = { bg = colors.bright_yellow, fg = colors.grey3, }
hl.statusLineRowCol             = { fg = colors.bright_aqua, bg = background, bold = true, }
hl.flagBlue                     = { fg = colors.grey0, bg = colors.neutral_blue, bold = true, }
hl.flagYellow                   = { fg = colors.grey0, bg = colors.neutral_yellow, bold = true, }
hl.flagOrange                   = { fg = colors.grey0, bg = colors.neutral_orange, bold = true, }
hl.flagRed                      = { fg = colors.grey0, bg = colors.neutral_red, bold = true, }
hl.statusLineFileTypeIcon       = { bg = background }

-- add nvimtree highlights
hl.NvimTreeBookmark             = { fg = colors.bright_red }
hl.NvimTreeExecFile             = { fg = colors.bright_red, bold = true, }
hl.NvimTreeFileIcon             = {}
hl.NvimTreeFolderIcon           = { fg = colors.bright_blue }
hl.NvimTreeGitDeleted           = { fg = colors.bright_purple }
hl.NvimTreeGitDirty             = { fg = colors.bright_purple }
hl.NvimTreeGitMerge             = { fg = colors.bright_orange }
hl.NvimTreeGitNew               = { fg = colors.bright_yellow }
hl.NvimTreeGitRenamed           = { fg = colors.bright_purple }
hl.NvimTreeGitStaged            = { fg = colors.bright_red }
hl.NvimTreeImageFile            = { fg = colors.bright_purple, bold = true, }
hl.NvimTreeIndentMarker         = { fg = colors.bright_blue }
hl.NvimTreeLiveFilterPrefix     = { fg = colors.bright_purple, bold = true, }
hl.NvimTreeLiveFilterValue      = { bold = true, }
hl.NvimTreeModifiedFile         = { fg = colors.bright_red }
hl.NvimTreeOpenedFile           = { fg = colors.bright_red, bold = true, }
hl.NvimTreeRootFolder           = { fg = colors.bright_purple }
hl.NvimTreeSpecialFile          = { fg = colors.bright_yellow, bold = true, }
hl.NvimTreeSymlink              = { fg = colors.bright_purple, bold = true, }
hl.NvimTreeSymlinkIcon          = {}
hl.NvimTreeWindowPicker         = { fg = colors.white, bg = colors.neutral_blue, bold = true, }
