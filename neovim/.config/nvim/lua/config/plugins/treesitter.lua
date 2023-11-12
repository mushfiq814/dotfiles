local afterFileOpen = { "BufReadPre", "BufNewFile" }

vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'


return {
  {
    -- lazy load only during specified treesitter parser filetypes are loaded
    'nvim-treesitter/nvim-treesitter',
    event = afterFileOpen,
    config = function()
      local success, nvim_treesitter = pcall(require, 'nvim-treesitter.configs')
      if not success then return end

      nvim_treesitter.setup {
        ensure_installed = {
          'typescript',
          'javascript',
          'lua',
          'query',
          'jsdoc',
          'json',
          'jsonc',
          'markdown',
          'markdown_inline',
          'bash',
          'yaml',
          'comment',
          'diff',
        },
        highlight = { enable = true },
        incremental_selection = { enable = true },
        indent = { enable = true },
      }
    end
  },
  {
    'nvim-treesitter/playground',
    cmd = { 'TSPlaygroundToggle', 'TSHighlightCapturesUnderCursor' },
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
  },
}

-- WIP
-- add directive for conceal char for code block language defined in highlights file
-- local function conceal_as_devicon(match, _, bufnr, pred, metadata)
--   if #pred == 2 then
--     -- (#as_devicon! @capture)
--     local capture_id = pred[2]
--     local lang = vim.treesitter.get_node_text(match[capture_id], bufnr)
--
--     local icon, color = require("nvim-web-devicons").get_icon_color_by_filetype(lang, { default = true })
--     metadata["conceal"] = icon
--     metadata["color"] = color
--     print(color)
--   end
-- end
--
-- vim.treesitter.query.add_directive("as_devicon!", conceal_as_devicon, true)
