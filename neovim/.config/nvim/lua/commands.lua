-- Put matched groups in search into register for stringing multiple objects use:
-- %s//\=setreg('A', submatch(1) . ": " . submatch(2), "V")/n

-- command! GetMatch execute "%s//\=setreg('A', submatch(1), \"V\")/n"

-- change windows terminal theme
vim.cmd [[
function! ChangeTerminalTheme() abort
lua << EOF
  local terminalSettings = '/mnt/c/Users/mushf/AppData/Local/Packages/Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe/LocalState/settings.json'
  local sedRegex = '0,/\"colorScheme\"/s/^\\([^\\/]*\\)\\/*\\s*\\(\"colorScheme\"\\s*:\\s*\"\\).*\\(\"\\)/\1\2' .. themeName .. '\3/'
  local command = 'sed -i ' .. sedRegex .. ' ' .. terminalSettings
  print(command)
EOF
endfunction
]]

-- WSL yank support
vim.cmd [[
let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
if executable(s:clip)
	augroup WSLYank
		autocmd!
		autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
	augroup END
endif
]]

-- Exec
-- call as follows `:put =Exec('command')`. e.g. `:put =Exec('ls')`
vim.cmd [[
function! Exec(command)
	redir => output
	silent exec a:command
	redir END
	return output
endfunction!
]]

-- My_orgmode {{{
-- The following function tries to implement execution of a markdown code blocks
-- A bulk of the vimscript here is "borrowed" from vim-markdown by gabrielelana
-- I have tried to trim the code to fit my particular needs and have made a few
-- additions as well.
-- function! My_orgmode ()
-- 	" regex for start and end of fenced code blocks
-- 	let upper_delimiter = '^\s*`\{3,}\(\w\+\)\%(\s.*$\|$\)'
-- 	let lower_delimiter = '^\s*`\{3,}\s*$'

-- 	" preoperties to keep track of populated with default values
-- 	let code_block = {
-- 		\ 'from': 0,
-- 		\ 'to': 0,
-- 		\ 'language': 'txt',
-- 		\ 'indentation': ''
-- 	\ }

-- 	" get current position
-- 	let initial_position = getpos('.')
-- 	" make copy of initial_position
-- 	let search_position = copy(initial_position)
-- 	let search_position[1] = a:firstline
-- 	let search_position[2] = 0
-- 	cal setpos('.', search_position)

-- 	" get line number for previous code block end
-- 	let end_code_block_backward = search(lower_delimiter, 'cbnW')
-- 	" get line number for closest code block start
-- 	let start_code_block_backward = search(upper_delimiter, 'cbnW')
-- 	" get line number for closest code block end
-- 	let end_code_block_forward = search(lower_delimiter, 'cnW')

-- 	" whether code block was found
-- 	let found_code_block =
-- 		\ start_code_block_backward > 0 && end_code_block_forward > 0
-- 	" whether current line is between two code blocks
-- 	let between_two_code_blocks =
-- 		\ start_code_block_backward < end_code_block_backward &&
-- 		\ end_code_block_backward <= a:firstline
-- 	" whether current line is within a code block
-- 	let starting_inside_code_block =
-- 		\ found_code_block &&
-- 		\ !between_two_code_blocks &&
-- 		\ start_code_block_backward <= a:firstline &&
-- 		\ end_code_block_forward >= a:firstline

-- 	" get language for code block
-- 	let code_block_lang = substitute(
-- 		\ getline(start_code_block_backward),
-- 		\ upper_delimiter, '\1', '')

-- 	" get indentation level for code block
-- 	let code_block_indent = substitute(
-- 		\ getline(start_code_block_backward),
-- 		\ '\(^\s*\).\+$', '\1', '')

-- 	" If we are not inside a code block, exit
-- 	if !starting_inside_code_block
-- 		echo "Not inside a code block"
-- 		return
-- 	endif

-- 	" update properties and continue
-- 	let code_block['language'] = code_block_lang
-- 	let code_block['indentation'] = code_block_indent
-- 	let code_block['back_to_position'] = initial_position
-- 	let code_block['back_to_position'][1] = start_code_block_backward
-- 	let code_block['back_to_position'][2] = 0
-- 	let code_block['from'] = start_code_block_backward + 1
-- 	let code_block['to'] = end_code_block_forward - 1

-- 	" set default file extension as language name
-- 	let code_block['file_extension'] = '.' . code_block['language']

-- 	" if known extension exists in list, update
-- 	if has_key(s:extensions_and_envs, code_block['language'])
-- 		let code_block['file_extension'] =
-- 			\ s:extensions_and_envs[code_block['language']][0]
-- 	endif

-- 	" create temp file with extension
-- 	let code_block['file_path'] = tempname() . code_block['file_extension']
-- 	" extract code block contents
-- 	let code_block['content'] = getline(code_block['from'], code_block['to'])

-- 	" unindent code block contents (based on full block indent)
-- 	let code_block['content'] = map(
-- 			\ code_block['content'],
-- 			\ 'substitute(v:val, ''^' . code_block['indentation'] . ''', '''', ''g'')'
-- 		\ )

-- 	" save code block contents to temp file
-- 	call writefile(code_block['content'], code_block['file_path'])

-- 	" find code environment
-- 	let code_block['env'] = ''
-- 	if has_key(s:extensions_and_envs, code_block['language'])
-- 		let code_block['env'] =
-- 			\ s:extensions_and_envs[code_block['language']][1]
-- 	else
-- 		echo "No specified environment for " . code_block['language']
-- 		return
-- 	endif

-- 	" path to where code output is stored
-- 	let code_block['output_file'] = '/home/mushfiq/downloads/out.txt'

-- 	" execute code in environment and save to output file
-- 	" TODO: handle errors in output
-- 	call system(
-- 		\   code_block['env'] . ' '
-- 		\ . code_block['file_path']
-- 		\ . ' > ' . code_block['output_file'])
	
-- 	" write output file contents back into original markdown file right after
-- 	" the code block. TODO: a result block with specific syntax could be created
-- 	" for this and if one doesn't exist, it will be created. If one exists
-- 	" however, its contents will have to be replaced

-- 	" starting delimiter
-- 	let code_block['output'] = ['```solution']
-- 	" code block result contents as a list
-- 	let code_block['output'] += readfile(code_block['output_file'])
-- 	" ending delimiter and newline
-- 	let code_block['output'] += ['```', '']

-- 	" indent the result code block as necessary
-- 	let code_block['output'] = map(
-- 		\ code_block['output'],
-- 		\ 'substitute(v:val, ''^'', ''' . code_block['indentation'] . ''', ''g'')'
-- 	\ )

-- 	" insert result after code block
-- 	call append(end_code_block_forward + 1, code_block['output'])

-- endfunction
-- }}}
