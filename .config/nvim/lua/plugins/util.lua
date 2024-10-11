return {
  { "tpope/vim-sleuth" },
  { "windwp/nvim-ts-autotag" },
  {
    "folke/ts-comments.nvim",
    opts = {},
    event = "VeryLazy",
  },
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
    config = function()
      local wk = require("which-key")
      wk.setup({
        preset = "modern",
        spec = {
          { "<leader>c", group = "code" },
          { "<leader>d", group = "debug" },
          { "<leader>f", group = "file" },
          { "<leader>g", group = "git" },
          { "<leader>q", group = "quit" },
          { "<leader>x", group = "quickfix" },
        },
        win = {
          title = false,
        },
        icons = {
          rules = false,
        },
      })
    end,
  },
  {
    "echasnovski/mini.icons",
    lazy = true,
    opts = {},
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },
  {
    "echasnovski/mini.nvim",
    version = false,
    config = function()
      require("mini.ai").setup({ n_lines = 500 })
      require("mini.surround").setup()
      require("mini.misc").setup()
      require("mini.pairs").setup({
        modes = { insert = true, command = true, terminal = false },
        skip_next = [=[[%w%%%'%[%"%.%`%$]]=], -- skip autopair when next character is one of these
        skip_ts = { "string" }, -- skip autopair when the cursor is inside these treesitter nodes
        skip_unbalanced = true, -- skip autopair when next character is closing pair and there are more closing pairs than opening pairs
        markdown = true, -- better deal with markdown code blocks
      })
      require("mini.splitjoin").setup()
      require("mini.move").setup()
      require("mini.indentscope").setup({
        symbol = "▏",
        draw = { animation = require("mini.indentscope").gen_animation.none() },
      })
    end,
  },
}
-- TODO  Try out for bookmarking and quick navigation https://github.com/otavioschwanck/arrow.nvim
