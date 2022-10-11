local success, highlight_colors = pcall(require, "nvim-highlight-colors")
if not success then return end

highlight_colors.setup{
  render = "background" -- "background", "first_column" or "foreground"
}
