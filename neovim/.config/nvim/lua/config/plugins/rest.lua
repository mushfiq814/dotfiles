return {
  {
    "rest-nvim/rest.nvim",
    ft = 'http',
    cmd = 'Rest',
    keys = {
      { "<leader>hr", "<cmd>Rest run<cr>",                  "[h]ttp [r]un request under the cursor", },
      { "<leader>he", "<cmd>Telescope rest select_env<cr>", "[h]ttp Pick [e]nv using telescope", },
    },
    config = function()
      require("telescope").load_extension("rest")
    end
  },
}
