return {
  { "tpope/vim-sleuth" },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
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
        ["<leader>f"] = { name = "file" },
        ["<leader>c"] = { name = "code" },
        ["<leader>d"] = { name = "debug" },
        ["<leader>g"] = { name = "git" },
        ["<leader>h"] = { name = "harpoon" },
        ["<leader>m"] = { name = "marks" },
        ["<leader>q"] = { name = "quit" },
        ["<leader>x"] = { name = "quickfix" },
      })
    end,
  },
  {
    "echasnovski/mini.nvim",
    version = false,
    config = function()
      require("mini.ai").setup({ n_lines = 500 })
      require("mini.surround").setup()
      require("mini.comment").setup()
      require("mini.misc").setup()
      require("mini.pairs").setup()
      require("mini.splitjoin").setup()
      -- require("mini.animate").setup({ cursor = { enable = false } })
      -- require("mini.notify").setup({ lsp_progress = { enable = false } })
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
