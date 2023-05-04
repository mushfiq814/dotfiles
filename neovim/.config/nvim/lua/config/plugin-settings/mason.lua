local status_ok_1, mason_lsp_config = pcall(require, "mason-lspconfig")
if not status_ok_1 then return end
local status_ok_2, mason = pcall(require, "mason")
if not status_ok_2 then return end

mason.setup()
mason_lsp_config.setup({
  ensure_installed = {
    "tsserver",
    "jsonls",
    "marksman",
  },
  automatic_installation = false
})
