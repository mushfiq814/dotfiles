local success, colorizer = pcall(require, 'colorizer')
if not success then return end

colorizer.setup{
  filetypes = {
    "markdown",
    "shell",
    "sh",
    "json",
    "javascript",
    "typescript",
    "javascriptreact",
    "css",
    "html",
  },
  user_default_options = {
    RGB = true, -- #RGB hex codes
    RRGGBB = true, -- #RRGGBB hex codes
    names = false, -- "Name" codes like Blue or blue
    RRGGBBAA = false, -- #RRGGBBAA hex codes
    AARRGGBB = true, -- 0xAARRGGBB hex codes
    rgb_fn = true, -- CSS rgb() and rgba() functions
    hsl_fn = false, -- CSS hsl() and hsla() functions
    css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
    css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
    -- Available modes for `mode`: foreground, background,  virtualtext
    mode = "virtualtext", -- Set the display mode.
    virtualtext = "",
    -- Available methods are false / true / "normal" / "lsp" / "both"
    -- True is same as normal
    tailwind = false, -- Enable tailwind colors
    -- parsers can contain values used in |user_default_options|
    sass = { enable = false, parsers = { css }, }, -- Enable sass colors
  },
  -- all the sub-options of filetypes apply to buftypes
  buftypes = {},
}
