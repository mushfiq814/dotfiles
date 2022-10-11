-- Put matched groups in search into register for stringing multiple objects use:
-- %s//\=setreg('A', submatch(1) . ": " . submatch(2), "V")/n
-- command! GetMatch execute "%s//\=setreg('A', submatch(1), \"V\")/n"

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

