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
syn match markdownList /^\t[-+*] /ms=e-1,me=e-1 conceal cchar=▨
syn match markdownList /^\t\t[-+*] /ms=e-1,me=e-1 conceal cchar=◑
syn match markdownList /^\t\t\t[-+*] /ms=e-1,me=e-1 conceal cchar=□
syn match markdownList /^\t\t\t\t\+[-+*] /ms=e-1,me=e-1 conceal cchar=⨁

" Numbered Lists
syn match markdownNumberList '^\s*\d\+\. '

" Any url
syntax match markdownGeneralUrl
	\ '\(https\?:\/\/\(\w\+\(:\w\+\)\?@\)\?\([A-Za-z0-9][-_0-9A-Za-z]*\.\)\{1,}\(\w\{2,}\.\?\)\{1,}\(:[0-9]\{1,5}\)\?[^] \t]*\)'

" Markdown Links: [text](url) OR ![image-alt](url)
syntax region markdownLinkUrl matchgroup=markdownLinkUrlParans
	\ start='(' end=')' contains=markdownGeneralUrl keepend oneline conceal
syntax region markdownLinkTitle matchgroup=markdownLinkTitleBracks
	\ start='!\?\[' end='\]' keepend oneline

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

" Task List: * [ ] Not Done OR - [X] Done OR + [x] also done

" BlockQuote: > This is a quote
syn region markdownBlockQuote start='^\s*> ' end='$'
	\ contains=markdownCode,markdownStrike,markdownBoldItalic,markdownBold,markdownItalic,
	\ markdownList,markdownNumberList keepend oneline

" Fenced Code Blocks: ```javascript\nThis is a code block\n```
syn region markdownCodeBlock matchgroup=markdownCodeDelimiter
	\ start='^\s*```\+.*$' end='^\s*```\+\s*$' keepend

" Tables: | txt | txt |\n|--|--|\n| txt | txt |
syn region markdownTable1 matchgroup=markdownTableDividers
	\ start='|' end='|' keepend oneline

" Horizontal Rule: ---

" Footnote: [^1]: Text

" Custom coloring and rendering
hi! markdownH1         guifg=#FABD2F    gui=bold
hi! markdownH2         guifg=#FE8019    gui=bold
hi! markdownH3         guifg=#FE8019    gui=bold
hi! markdownH4         guifg=#B8BB26    gui=bold
hi! markdownH5         guifg=#B8BB26    gui=bold
hi! markdownH6         guifg=#B8BB26    gui=bold
hi! markdownBold       guifg=#83A598    gui=bold
hi! markdownItalic     guifg=#83A598    gui=italic
hi! markdownBoldItalic guifg=#83A598    gui=bold,italic
hi! markdownStrike     guifg=#83A598    gui=strikethrough
hi! markdownGeneralUrl guifg=#FFA3BD    gui=underline

" Highlight Groups
hi! def link markdownHeadingIcon        GruvboxFg4
hi! def link markdownBlockQuote         Comment
hi! def link markdownList               GruvboxRed
hi! def link markdownNumberList         GruvboxRed
hi! def link markdownCode               GruvboxPurple
hi! def link markdownCodeBlock          GruvboxPurple
hi! def link markdownCodeDelimiter      GruvboxBlue
hi! def link markdownLinkTitleBracks    GruvboxAqua
hi! def link markdownLinkUrlParans      GruvboxAqua
hi! def link markdownLinkTitle          GruvboxFg2
hi! def link markdownLinkUrl            GruvboxRed
hi! def link markdownTable1 GruvboxYellow
hi! markdownTableDividers guifg=#000000 guibg=#5E554B

" Conceal Highlight Color
hi! def link Conceal GruvboxRed

set conceallevel=2

let b:current_syntax = "markdown"
