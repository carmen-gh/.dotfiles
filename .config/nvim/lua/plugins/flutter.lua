return {
  "akinsho/flutter-tools.nvim",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "stevearc/dressing.nvim",
  },
  config = function()
    require("flutter-tools").setup({
      fvm = false,
      decorations = {
        statusline = {
          app_version = true,
          device = true,
          project_config = false,
        },
      },
      dev_tools = {
        autostart = true,
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
  end,
}
