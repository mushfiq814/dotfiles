local success, image = pcall(require, 'image')
if not success then return end

-- remember to `yay -S ascii-image-converter-git`
image.setup {
  render = {
    min_padding = 5,
    show_label = true,
    use_dither = true,
    foreground_color = true,
    background_color = true,
  },
  events = {
    update_on_nvim_resize = true,
  },
}
