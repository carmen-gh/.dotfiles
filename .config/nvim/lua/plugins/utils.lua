return {
  { "tpope/vim-sleuth" },
  { "windwp/nvim-ts-autotag" },
  { "folke/ts-comments.nvim", event = "VeryLazy", opts = {} },
  { "stevearc/dressing.nvim", event = "VeryLazy", opts = {} },
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
    end,
  },
  {
    "echasnovski/mini.indentscope",
    version = false, -- wait till new 0.7.0 release to put it back on semver
    lazy = true,
    opts = {
      -- symbol = "▏",
      symbol = "│",
      options = { try_as_border = true },
      -- draw = { animation = MiniIndentscope.gen_animation.none },
    },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "Trouble",
          "alpha",
          "dashboard",
          "fzf",
          "help",
          "lazy",
          "mason",
          "neo-tree",
          "notify",
          "snacks_dashboard",
          "snacks_notif",
          "snacks_terminal",
          "snacks_win",
          "trouble",
          "toggleterm",
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      animate = { enabled = false },
      bigfile = { enabled = true },
      bufdelete = { enabled = false },
      notifier = { enabled = true, timeout = 3000 },
      quickfile = { enabled = true },
      rename = { enabled = false },
      scope = { enabled = false },
      scratch = { enabled = false },
      scroll = { enabled = false },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      styles = { notification = { wo = { wrap = true } } },
    },
    keys = {
  -- stylua: ignore start
      {"<leader>lg", function() Snacks.lazygit() end, desc = "Lazygit",},
      {"<leader>gl", function() Snacks.git.blame_line() end, desc = "Git Blame Line",},
      {"<leader>gB", function() Snacks.gitbrowse() end, desc = "Open Git Browser",},
      {"<leader>gh", function() Snacks.lazygit.log_file() end, desc = "Lazygit Current File History",},
      {"<leader>gL", function() Snacks.lazygit.log() end, desc = "Lazygit Log (cwd)",},
      -- {"<leader>cR", function() Snacks.rename() end, desc = "Rename File",},
      {"<leader>fn", function() Snacks.notifier.show_history() end, desc ="notifications",},
      {"]]", function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" },},
      {"[[", function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" },},
      -- stylua: ignore end
    },
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          -- Setup some globals for debugging (lazy-loaded)
          _G.dd = function(...)
            Snacks.debug.inspect(...)
          end
          _G.bt = function()
            Snacks.debug.backtrace()
          end
          vim.print = _G.dd -- Override print to use snacks for `:=` command

          -- Create some toggle mappings
          Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
          Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
          Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
          Snacks.toggle.diagnostics():map("<leader>ud")
          Snacks.toggle
            .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
            :map("<leader>uc")
          Snacks.toggle.treesitter():map("<leader>uT")
          Snacks.toggle.inlay_hints():map("<leader>uh")
        end,
      })
      -- LSP Progress
      vim.api.nvim_create_autocmd("LspProgress", {
        ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
        callback = function(ev)
          local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
          vim.notify(vim.lsp.status(), "info", {
            id = "lsp_progress",
            title = "LSP Progress",
            opts = function(notif)
              notif.icon = ev.data.params.value.kind == "end" and " "
                or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
            end,
          })
        end,
      })
    end,
  },
}
-- TODO  Try out for bookmarking and quick navigation https://github.com/otavioschwanck/arrow.nvim