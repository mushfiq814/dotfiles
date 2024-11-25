return {
  {
    "rest-nvim/rest.nvim",
    ft = 'http',
    cmd = 'Rest',
    keys = {
      { "<leader>hr", "<cmd>Rest run<cr>", "Run request under the cursor", },
      { "<leader>he", "<cmd>Telescope rest select_env<cr>", "Pick env using telescope", },
    },
    config = function()
      require("telescope").load_extension("rest")
    end
  },
}
