return {
  "saghen/blink.cmp",
  version = "1.*",
  event = { "InsertEnter", "CmdlineEnter" },
  dependencies = {
    {
      "saghen/blink.compat",
      optional = true, -- make optional so it's only enabled if any extras need it
      opts = {},
      version = "*",
    },
    "rafamadriz/friendly-snippets",
    "folke/lazydev.nvim",
    "kristijanhusak/vim-dadbod-completion",
  },
  opts = {
    keymap = {
      preset = "default",
    },
    appearance = {
      nerd_font_variant = "mono",
    },
    completion = {
      documentation = { auto_show = true, auto_show_delay_ms = 500 },
      menu = {
        draw = {
          treesitter = { "lsp" },
        },
      },
    },
    sources = {
      default = { "lsp", "buffer", "snippets", "path" },
      per_filetype = {
        sql = { "snippets", "dadbod", "buffer" },
        lua = { inherit_defaults = true, "lazydev" },
      },
      providers = {
        dadbod = { module = "vim_dadbod_completion.blink" },
        lazydev = { module = "lazydev.integrations.blink", score_offset = 100 },
      },
    },
    cmdline = {
      enabled = true,
      keymap = { preset = "cmdline" },
      completion = {
        list = { selection = { preselect = false } },
        menu = {
          auto_show = function(ctx)
            return vim.fn.getcmdtype() == ":"
          end,
        },
        ghost_text = { enabled = true },
      },
    },
    -- snippets = { preset = "luasnip" },
    fuzzy = { implementation = "lua" },
    signature = { enabled = true },
  },
}
