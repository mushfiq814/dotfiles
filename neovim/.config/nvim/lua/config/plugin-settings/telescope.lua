local success, telescope = pcall(require, 'telescope')
if not success then return end

telescope.setup({
  defaults = {
    layout_config = {
      vertical = { width = 0.9 },
      horizontal = { width = 0.9 },
      -- other layout configuration here
    },
    -- borderchars = { "▔", "▕", "▁", "▏", "🭽", "🭾", "🭿", "🭼" }
    borderchars = { " ", " ", " ", " ", " ", " ", " ", " " }
    -- other defaults configuration here
  },
  -- other configuration values here
})
