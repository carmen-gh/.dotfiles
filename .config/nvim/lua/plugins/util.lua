return {
  { "tpope/vim-sleuth" },
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    opts = {},
  },
  {
    "hiphish/rainbow-delimiters.nvim",
    url = "https://gitlab.com/HiPhish/rainbow-delimiters.nvim",
    event = "BufReadPost",
    config = function()
      local rainbow_delimiters = require("rainbow-delimiters")
      vim.g.rainbow_delimiters = {
        strategy = {
          [""] = rainbow_delimiters.strategy["global"],
          vim = rainbow_delimiters.strategy["local"],
        },
        query = {
          [""] = "rainbow-delimiters",
          lua = "rainbow-blocks",
        },
      }
    end,
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    config = function()
      local wk = require("which-key")
      wk.register({
        ["<leader>c"] = { name = "code" },
        ["<leader>d"] = { name = "debug" },
        ["<leader>f"] = { name = "file" },
        ["<leader>g"] = { name = "git" },
        ["<leader>q"] = { name = "quit" },
        ["<leader>x"] = { name = "quickfix" },
      })
    end,
  },
  {
    "rcarriga/nvim-notify",
    lazy = false,
    opts = {
      timeout = 3000,
      render = "wrapped-compact",
      stages = "fade",
    },
  },
  {
    "echasnovski/mini.nvim",
    version = false,
    config = function()
      require("mini.ai").setup({ n_lines = 500 })
      require("mini.surround").setup()
      require("mini.misc").setup()
      require("mini.pairs").setup()
      require("mini.splitjoin").setup()
      require("mini.move").setup()
      require("mini.indentscope").setup({
        symbol = "▏",
        draw = { animation = require("mini.indentscope").gen_animation.none() },
      })
      local hipatterns = require("mini.hipatterns")
      hipatterns.setup({
        highlighters = {
          warn = { pattern = "%f[%w]()WARN()%f[%W]", group = "MiniHipatternsHack" },
          fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
          error = { pattern = "%f[%w]()ERROR()%f[%W]", group = "MiniHipatternsFixme" },
          todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
          note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
      })
    end,
  },
}
