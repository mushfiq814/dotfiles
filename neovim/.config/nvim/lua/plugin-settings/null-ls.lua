local success, null_ls = pcall(require, 'null-ls')
if not success then return end

null_ls.setup({
  sources = {
    null_ls.builtins.code_actions.eslint,
    null_ls.builtins.diagnostics.eslint,
    null_ls.builtins.formatting.prettier,
    -- null_ls.builtins.diagnostics.luacheck,
    -- null_ls.builtins.diagnostics.mdl,
  },
})
