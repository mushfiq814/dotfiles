return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-jest",
      "nvim-neotest/neotest-go",
    },
    keys = {
      { "<leader>tn", "<CMD>lua require(\"neotest\").summary.open()<CR>",                desc = "open [t]est summary sidebar me[n]u" },
      { "<leader>tf", "<CMD>lua require(\"neotest\").run.run(vim.fn.expand(\"%\"))<CR>", desc = "[t]est entire [f]ile" },
      { "<leader>tr", "<CMD>lua require(\"neotest\").run.run()<CR>",                     desc = "[t]est [r]un nearest" },
      { "<leader>ts", "<CMD>lua require(\"neotest\").run.stop()<CR>",                    desc = "[t]est [s]top nearest" },
      { "<leader>ta", "<CMD>lua require(\"neotest\").run.attach()<CR>",                  desc = "[t]est [a]ttach nearest" },
    },
    config = function()
      -- get neotest namespace (api call creates or returns namespace)
      local neotest_ns = vim.api.nvim_create_namespace("neotest")
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            local message =
                diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
            return message
          end,
        },
      }, neotest_ns)

      require("neotest").setup({
        adapters = {
          require('neotest-jest')({
            jestCommand = require('neotest-jest.jest-util').getJestCommand(vim.fn.expand '%:p:h') .. ' --watch',
            jestConfigFile = "jest.config.js",
            env = { CI = false },
            cwd = function(path) return vim.fn.getcwd() end,
          }),
          require("neotest-go"),
        },
      })
    end,
  }
}
