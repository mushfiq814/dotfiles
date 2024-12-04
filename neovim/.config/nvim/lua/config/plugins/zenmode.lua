return {
  {
    'folke/zen-mode.nvim',
    keys = {
      { "<leader>x", "<CMD>ZenMode<CR>", desc = "Toggle ZenMode" },
    },
    opts = {
      window = {
        -- height and width can be:
        -- * an absolute number of cells when > 1
        -- * a percentage of the width / height of the editor when <= 1
        -- * a function that returns the width or the height
        width = 80,
        height = 1,
      },
      plugins = {
        tmux = { enabled = true },
      },
      -- callback where you can add custom code when the Zen window opens
      on_open = function(win)
        vim.opt.signcolumn = "no"
        vim.o.laststatus = 0
        vim.opt.number = false
        vim.opt.wrap = true
        vim.opt.list = false
        vim.opt.scrolloff = 999
        vim.opt.cursorline = false
      end,
      -- callback where you can add custom code when the Zen window closes
      on_close = function()
        vim.opt.signcolumn = "auto"
        vim.o.laststatus = 3
        vim.opt.number = true
        vim.opt.wrap = false
        vim.opt.list = true
        vim.opt.scrolloff = 0
        vim.opt.cursorline = true
        vim.fn.system([[tmux set status on]])
      end,
    },
  },
}
