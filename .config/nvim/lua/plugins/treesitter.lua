return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require("nvim-treesitter").setup({
        ensure_installed = {
          "bash",
          "dart",
          "diff",
          "html",
          "javascript",
          "json",
          "eex",
          "elixir",
          "go",
          "gomod",
          "gosum",
          "gowork",
          "heex",
          "kotlin",
          "lua",
          "markdown",
          "markdown_inline",
          "python",
          "rust",
          "sql",
          "swift",
          "toml",
          "xml",
          "yaml",
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = false,
            node_decremental = "<bs>",
          },
        },
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "VeryLazy",
    enabled = true,
    opts = { mode = "cursor", max_lines = 1 },
  },
  { "windwp/nvim-ts-autotag" },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    event = "VeryLazy",
    opts = {},
  },
}
