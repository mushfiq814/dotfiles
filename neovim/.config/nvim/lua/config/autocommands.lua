-- follow markdown links
vim.cmd('au FileType markdown nnoremap <buffer> <CR> :call FollowMarkdownLink()<CR>')
-- go backwards
vim.cmd('au FileType markdown nnoremap <buffer> <BS> <C-o>')
-- align tables using Tabular
vim.cmd('au FileType markdown nnoremap <buffer> <leader>a :Tabularize /\\|<CR>')

local augroupMarkdown = vim.api.nvim_create_augroup('markdownFileEnter', { clear = true })
vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  pattern = "*.md",
  group = augroupMarkdown,
  callback = function()
    vim.opt.shiftwidth = 2 -- of spaces to use for each step of (auto)indent (>>, <<)
    vim.opt.tabstop = 2 -- of spaces that a <Tab> counts for
    vim.opt.softtabstop = 2 -- of spaces that a <Tab> counts while editing
  end
})

-- assign filetype to jsonc for json files to enable comments
vim.cmd('au FileType json set filetype=jsonc')

vim.api.nvim_create_autocmd({ "BufEnter" }, {
    pattern = { "*" },
    command = "normal zx zR",
})
