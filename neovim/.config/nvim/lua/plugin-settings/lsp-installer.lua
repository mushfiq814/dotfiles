local success, lsp_installer = pcall(require, 'nvim-lsp-installer')
if not success then return end

-- Register a handler that will be called for each installed server when it's
-- ready (i.e. when installation is finished or if the server is already
-- installed).
lsp_installer.on_server_ready(function(server)
  local opts = {}

  -- Customize the options passed to the server
  if server.name == "tsserver" then
    opts.root_dir = vim.loop.cwd
  end

  if server.name == "sumneko_lua" then
    opts = {
      settings = {
        Lua = {
          diagnostics = {
            globals = { 'vim', 'use' }
          }
        }
      }
    }
  end
  -- This setup() function will take the provided server configuration and
  -- decorate it with the necessary properties before passing it onwards to
  -- lspconfig.
  -- Refer to
  -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
  server:setup(opts)
end)
