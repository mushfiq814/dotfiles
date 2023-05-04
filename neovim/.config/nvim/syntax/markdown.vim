" Load html and css syntax
" runtime! syntax/html.vim
" unlet! b:current_syntax

" " don't use standard HiLink, it will not work with included syntax files
" if version < 508
" 	command! -nargs=+ HtmlHiLink hi link <args>
" else
" 	command! -nargs=+ HtmlHiLink hi def link <args>
" endif

" Embedded Latex syntax using $ or $$
syn include @tex syntax/tex.vim
syn region mkdMath start="\\\@<!\$" end="\$" skip="\\\$" contains=@tex keepend
syn region mkdMath start="\\\@<!\$\$" end="\$\$" skip="\\\$" contains=@tex keepend

" Headings: # Heading OR ### Heading
syn region markdownH1 matchgroup=markdownHeadingIcon start='\s*# '      end='$' keepend oneline
syn region markdownH2 matchgroup=markdownHeadingIcon start='\s*## '     end='$' keepend oneline
syn region markdownH3 matchgroup=markdownHeadingIcon start='\s*### '    end='$' keepend oneline
syn region markdownH4 matchgroup=markdownHeadingIcon start='\s*#### '   end='$' keepend oneline
syn region markdownH5 matchgroup=markdownHeadingIcon start='\s*##### '  end='$' keepend oneline
syn region markdownH6 matchgroup=markdownHeadingIcon start='\s*###### ' end='$' keepend oneline

" Lists: * list item OR - list item OR + list item
" Conceal will show fancy chars instead of [-+*]
syn match markdownList '^[-+*] 'me=e-1 conceal cchar=◉
syn match markdownList /^\(\(\t\)\|\(  \)\)[-+*] /ms=e-1,me=e-1 conceal cchar=▨
syn match markdownList /^\(\(\t\t\)\|\(    \)\)[-+*] /ms=e-1,me=e-1 conceal cchar=◑
syn match markdownList /^\(\(\t\t\t\)\|\(      \)\)[-+*] /ms=e-1,me=e-1 conceal cchar=□
syn match markdownList /^\(\(\t\t\t\t\)\|\(      \)\)[-+*] /ms=e-1,me=e-1 conceal cchar=⨁

" Numbered Lists
syn match markdownNumberList '^\s*\d\+\. '

" Any url
syntax match markdownGeneralUrl
	\ '\(https\?:\/\/\(\w\+\(:\w\+\)\?@\)\?\([A-Za-z0-9][-_0-9A-Za-z]*\.\)\{1,}\(\w\{2,}\.\?\)\{1,}\(:[0-9]\{1,5}\)\?[^] \t]*\)'

" Markdown Links: [text](url) OR ![image-alt](url)
syntax region markdownLink start='\[' end='\](.*)' oneline contains=markdownLinkTitle
syntax region markdownLinkTitle matchgroup=markdownLinkTitleBracks
	\ start='!\?\[' end='\]' contained oneline nextgroup=markdownLinkUrl concealends
syntax region markdownLinkUrl matchgroup=markdownLinkUrlParans
	\ start='(' end=')' contained conceal

" Italic: *italicized*
syn region markdownItalic
	\ start='\%(^\|\s\)\zs\*\ze[^\\\*\t ]\%(\%([^*]\|\\\*\|\n\)*[^\\\*\t ]\)\?\*\_W'ms=s+1
	\ end='[^\\\*\t ]\zs\*\ze\_W'me=e-1 keepend contains=@Spell oneline
" Italic: _italicized_
syn region markdownItalic
	\ start='\%(^\|\s\)\zs_\ze[^\\_\t ]'ms=s+1
	\ end='[^\\_\t ]\zs_\ze\_W'me=e-1 keepend contains=@Spell oneline

" Bold: **Bold**
syn region markdownBold
	\ start='\%(^\|\s\)\zs\*\*\ze\S'ms=s+2
	\ end='\S\zs\*\*'me=e-2 keepend contains=@Spell oneline
" Bold: __Bold__
syn region markdownBold
	\ start='\%(^\|\s\)\zs__\ze\S'ms=s+2
	\ end='\S\zs__'me=e-2 keepend contains=@Spell oneline

" BoldItalic: ***BoldItalic***
syn region markdownBoldItalic
	\ start='\%(^\|\s\)\zs\*\*\*\ze\S'ms=s+3
	\ end='\S\zs\*\*\*'me=e-3 keepend contains=@Spell oneline
" BoldItalic: ___BoldItalic___
syn region markdownBoldItalic
	\ start='\%(^\|\s\)\zs___\ze\S'ms=s+3
	\ end='\S\zs___'me=e-3 keepend contains=@Spell oneline

" Strikethrough: ~~strike 3~~
syn region markdownStrike
	\ start='\%(^\|\s\)\zs\~\~\ze\S'ms=s+2
	\ end='\S\zs\~\~'me=e-2 keepend contains=@Spell oneline
" Code: `monospace font`
syn region markdownCode
	\ start='\%(^\|\s\)\zs`\ze\S'ms=s+1
	\ end='\S\zs`'me=e-1 keepend contains=@Spell oneline

" BlockQuote: > This is a quote
syn region markdownBlockQuote start='^\s*> ' end='$'
	\ contains=markdownCode,markdownStrike,markdownBoldItalic,markdownBold,markdownItalic,
	\ markdownList,markdownNumberList keepend oneline

" Fenced Code Blocks: ```javascript\nThis is a code block\n```
syn region markdownCodeBlock matchgroup=markdownCodeDelimiter
	\ start='^\s*```\+.*$' end='^\s*```\+\s*$' keepend

" Table Alternating Rows Highlight
syn match Oddlines  "^|.*|$" contains=ALL nextgroup=Evenlines skipnl
syn match Evenlines "^|.*|$" contains=ALL nextgroup=Oddlines skipnl

syn match markdownQuoteStart /"\w/me=e-1 conceal cchar=“
syn match markdownQuoteEnd /\w"/ms=s+1 conceal cchar=”

" Horizontal Rule: ---

" Footnote: [^1]: Text

" Checkbox: * [ ] Not Done OR - [X] Done OR + [x] also done
syn match markdownCheckboxFull  /^\(\t\|\s\)*\zs[-+*] \[X\] /me=e-1 conceal cchar=
syn match markdownCheckboxFull  /^\(\t\|\s\)*\zs[-+*] \[x\] /me=e-1 conceal cchar=
syn match markdownCheckboxEmpty /^\(\t\|\s\)*\zs[-+*] \[ \] /me=e-1 conceal cchar=
syn match markdownCheckboxNext  /^\(\t\|\s\)*\zs[-+*] \[>\] /me=e-1 conceal cchar=
syn match markdownCheckboxNext  /^\(\t\|\s\)*\zs[-+*] \[<\] /me=e-1 conceal cchar=

" Custom coloring and rendering
hi! markdownHeadingIcon   guifg=#7C6F64  guibg=#282828  gui=bold
hi! markdownH1            guifg=#BFF1DE  guibg=#282828  gui=bold
hi! markdownH2            guifg=#96BEAF  guibg=#282828  gui=bold
hi! markdownH3            guifg=#96BEAF  guibg=#282828  gui=bold
hi! markdownH4            guifg=#83A598  guibg=#282828  gui=bold
hi! markdownH5            guifg=#83A598  guibg=#282828  gui=bold
hi! markdownH6            guifg=#83A598  guibg=#282828  gui=bold
hi! markdownBold          guifg=#8EC07C                 gui=bold
hi! markdownItalic        guifg=#8EC07C                 gui=italic
hi! markdownBoldItalic    guifg=#8EC07C                 gui=bold,italic
hi! markdownStrike        guifg=#8EC07C                 gui=strikethrough
hi! markdownGeneralUrl    guifg=#FABD2F                 gui=underline
hi! markdownLinkTitle     guifg=#FABD2F                 gui=underline
hi! markdownLinkUrl       guifg=#7C6F64                 gui=underline
hi! Oddlines              guifg=None     guibg=#2d2d2d
" Conceal Highlight Color
" hi! Conceal               guifg=#BCFFA4                 gui=bold

" Highlight Groups
hi! def link markdownBlockQuote         Comment
hi! def link markdownList               GruvboxRed
hi! def link markdownNumberList         GruvboxRed
hi! def link markdownCode               GruvboxPurple
hi! def link markdownCodeBlock          GruvboxPurple
hi! def link markdownCodeDelimiter      GruvboxBlue
hi! def link markdownLinkTitleBracks    GruvboxAqua
hi! def link markdownLinkUrlParans      GruvboxAqua



set conceallevel=2

let b:current_syntax = "markdown"
