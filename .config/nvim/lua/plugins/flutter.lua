return {
  "akinsho/flutter-tools.nvim",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "stevearc/dressing.nvim",
  },
  config = function()
    require("flutter-tools").setup({
      fvm = true,
      decorations = {
        statusline = {
          app_version = true,
          device = true,
          project_config = false,
        },
      },
      dev_tools = {
        autostart = false,
        auto_open_browser = true,
      },
      dev_log = {
        enabled = false,
        filter = nil,
        notify_errors = false,
        open_cmd = "15split",
        focus_on_open = true,
      },
    })

    vim.keymap.set("n", "<leader>Fr", "<cmd>FlutterRun<cr>", { desc = "run" })
    vim.keymap.set("n", "<leader>Ft", "<cmd>FlutterDevTools<cr>", { desc = "dev tools" })
    vim.keymap.set("n", "<leader>Fl", "<cmd>FlutterLogToggle<cr>", { desc = "logs toggle" })
    vim.keymap.set("n", "<leader>Fd", "<cmd>FlutterDebug<cr>", { desc = "debug mode" })
    vim.keymap.set("n", "<leader>Fo", "<cmd>FlutterOutlineToggle<cr>", { desc = "outline toggle" })
  end,
}
