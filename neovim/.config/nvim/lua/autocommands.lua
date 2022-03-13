-- follow markdown links
vim.cmd('au FileType markdown nnoremap <buffer> <CR> :call FollowMarkdownLink()<CR>')
-- go backwards
vim.cmd('au FileType markdown nnoremap <buffer> <BS> <C-o>')
-- align tables using Tabular
vim.cmd('au FileType markdown nnoremap <buffer> <leader>a :Tabularize /\\|<CR>')

