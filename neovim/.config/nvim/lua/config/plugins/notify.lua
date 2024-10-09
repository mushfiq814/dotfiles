return {
  {
    'rcarriga/nvim-notify',
    keys = {
      { "<leader>dd", "<CMD>lua require(\"notify\").dismiss()<CR>", desc = "Dismiss notifcation" },
    },
    event = 'VeryLazy',
    opts = function()
      local border_loaded, b = pcall(require, 'config/utils/border')
      if not border_loaded then return end

      -- set nvim-notify as default notify function for other plugins
      vim.notify = require("notify")
      vim.opt.termguicolors = true

      return {
        fps = 60,
        stages = "fade",
        render = "compact",
        on_open = function(win)
          if vim.api.nvim_win_is_valid(win) then
            vim.api.nvim_win_set_config(win, {
              border = b.borders,
            })
          end
        end,
      }
    end
  },
}
