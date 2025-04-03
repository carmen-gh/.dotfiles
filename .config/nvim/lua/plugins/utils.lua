return {
  { "tpope/vim-sleuth" },
  { "windwp/nvim-ts-autotag" },
  { "folke/ts-comments.nvim", event = "VeryLazy", opts = {} },
  { "stevearc/dressing.nvim", event = "VeryLazy", opts = {} },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "VeryLazy",
    main = "ibl",
    opts = {
      scope = { enabled = true, show_start = false },
    },
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
        preset = "helix",
        spec = {
          { "<leader>1", hidden = true },
          { "<leader>2", hidden = true },
          { "<leader>3", hidden = true },
          { "<leader>4", hidden = true },
          { "<leader>5", hidden = true },
          { "<leader>lg", hidden = true },
          { "<leader>o", hidden = true },
          { "<leader>c", group = "code" },
          { "<leader>d", group = "debug" },
          { "<leader>f", group = "file" },
          { "<leader>g", group = "git" },
          { "<leader>u", group = "toggle" },
          { "<leader>q", group = "quit" },
          { "<leader>x", group = "quickfix" },
        },
      })
    end,
  },
  {
    "echasnovski/mini.icons",
    opts = {},
    lazy = true,
    specs = {
      { "nvim-tree/nvim-web-devicons", enabled = false, optional = true },
    },
    init = function()
      -- support plugins which only support nvim-web-devicons
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },
  { "echasnovski/mini.ai", version = false, opts = { n_lines = 500 } },
  { "echasnovski/mini.surround", version = false, opts = {} },
  { "echasnovski/mini.splitjoin", version = false, opts = {} },
  { "echasnovski/mini.move", version = false, opts = {} },
  { "echasnovski/mini.pairs", version = false, opts = {} },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      animate = { enabled = false },
      bigfile = { enabled = true },
      bufdelete = { enabled = true },
      dashboard = { enabled = false },
      dim = { enabled = false },
      explorer = { enabled = false },
      git = { enabled = false },
      gitbrowse = { enabled = true },
      image = { enabled = true },
      indent = { enabled = false },
      input = { enabled = false },
      layout = { enabled = true },
      lazygit = { enabled = true },
      notifier = { enabled = true, timeout = 3000 },
      notify = { enabled = true },
      picker = { enabled = false },
      profiler = { enabled = false },
      quickfile = { enabled = true },
      rename = { enabled = false },
      scope = { enabled = false },
      scratch = { enabled = false },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      terminal = { enabled = true },
      toggle = { enabled = false },
      words = { enabled = true },
      zen = { enabled = false },
    },
    keys = {
      -- stylua: ignore start
      -- gitbrowse
      {"<leader>gB", function() Snacks.gitbrowse() end, desc = "Open Git Browser",},
      -- lazygit
      {"<leader>lg", function() Snacks.lazygit() end, desc = "Lazygit",},
      {"<leader>gh", function() Snacks.lazygit.log_file() end, desc = "Lazygit Current File History",},
      {"<leader>gL", function() Snacks.lazygit.log() end, desc = "Lazygit Log (cwd)",},
      -- Notifier
      {"<leader>fn", function() Snacks.notifier.show_history() end, desc ="notifications",},
      -- terminal
      {"<C-t>", function() Snacks.terminal() end, { desc = "Open terminal" }},
      {"<C-t>", "<cmd>close<cr>", mode="t", { desc = "Hide Terminal" }},
      -- words
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
      -- LSP Progress notifier
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
