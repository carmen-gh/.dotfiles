return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    -- language specfic adapters
    "nvim-neotest/neotest-go",
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-go")({
          recursive_run = true, -- By default go test runs for currecnt package only. If you want to run it recursively you need to set this to true
        }),
      },
    })
  end,
}
