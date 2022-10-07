local success, telescope = pcall(require, 'telescope')
if not success then return end

telescope.setup({
  defaults = {
    layout_config = {
      vertical = { width = 0.9 },
      horizontal = { width = 0.9 },
      -- other layout configuration here
    },
    -- other defaults configuration here
  },
  -- other configuration values here
  extensions = {
    media_files = {
      filetypes = {"png", "jpg", "pdf", "jpeg"},
      find_cmd = "rg"
    }
  }
})
