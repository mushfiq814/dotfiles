return {
  {
    "ThePrimeagen/harpoon",
    event = "VeryLazy",
    keys = {
      {
        "<leader>ho",
        "<CMD>lua require(\"harpoon.ui\").toggle_quick_menu()<CR>",
        desc = "(h)arpoon (o)pen menu",
      },
      {
        "<leader>ha",
        "<CMD>lua require(\"harpoon.mark\").add_file()<CR>",
        desc = "(h)arpoon (a)dd mark for current file",
      },
    }
  },
}
