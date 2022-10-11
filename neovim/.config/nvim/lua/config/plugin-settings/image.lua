local success, image = pcall(require, 'image')
if not success then return end

image.setup {
  render = {
    min_padding = 5,
    show_label = true,
    use_dither = true,
  },
  events = {
    update_on_nvim_resize = true,
  },
}
