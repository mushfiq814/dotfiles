local success, telescope = pcall(require, 'telescope')
if not success then return end

local border_loaded, borders = pcall(require, 'config/utils/border')
if not border_loaded then return end

telescope.setup({
  defaults = {
    layout_config = {
      vertical = { width = 0.9 },
      horizontal = { width = 0.9 },
    },
    borderchars = {
      borders[2],
      borders[6],
      borders[8],
      borders[4],
      borders[1],
      borders[3],
      borders[9],
      borders[7],
    },
  },
  pickers = {
    find_files = {
      find_command = {
        "rg",
        "--hidden", -- include hidden files
        "--glob", "!.git/", -- don't include .git directory
        "--files",  -- include only files
      },
    },
    live_grep = {
      additional_args = {
        "--hidden", -- include hidden files
        "--glob", "!.git/", -- don't include .git directory
      },
    },
  },
})
