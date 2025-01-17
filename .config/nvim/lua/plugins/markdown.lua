return {
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = function()
      require("lazy").load({ plugins = { "markdown-preview.nvim" } })
      vim.fn["mkdp#util#install"]()
    end,
    keys = {
      {
        "<leader>cp",
        ft = "markdown",
        "<cmd>MarkdownPreviewToggle<cr>",
        desc = "Markdown Preview",
      },
    },
    -- config = function()
    --   vim.cmd([[do FileType]])
    -- end,
    ft = "markdown, puml",
    init = function()
      local g = vim.g
      g.mkdp_auto_start = 0
      g.mkdp_auto_close = 1
      g.mkdp_refresh_slow = 0
      g.mkdp_command_for_global = 0
      g.mkdp_open_to_the_world = 0
      g.mkdp_open_ip = ""
      g.mkdp_browser = "chrome"
      g.mkdp_echo_preview_url = 0
      g.mkdp_browserfunc = ""
      g.mkdp_theme = "dark"
      g.mkdp_filetypes = { "markdown", "puml" }
      g.mkdp_preview_options = {
        disable_sync_scroll = 0,
        disable_filename = 1,
      }
    end,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      code = {
        sign = false,
        width = "block",
        right_pad = 1,
      },
      heading = {
        sign = false,
        icons = {},
      },
    },
    ft = { "markdown", "norg", "rmd", "org" },
    config = function(_, opts)
      require("render-markdown").setup(opts)
      Snacks.toggle({
        name = "Render Markdown",
        get = function()
          return require("render-markdown.state").enabled
        end,
        set = function(enabled)
          local m = require("render-markdown")
          if enabled then
            m.enable()
          else
            m.disable()
          end
        end,
      }):map("<leader>um")
    end,
  },
}
