return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    commit = vim.fn.has("nvim-0.12") == 0 and "7caec274fd19c12b55902a5b795100d21531391f" or nil,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup()

      local ensure_installed = {
        "bash",
        "c",
      }
      require("nvim-treesitter").install(ensure_installed)
    end,
    --   require('nvim-treesitter').install(ensure_installed)
    -- end
    --       ---@diagnostic disable-next-line: missing-fields
    --       require("nvim-treesitter").setup({
    --         ensure_installed = {
    --           "bash",
    --           "dart",
    --           "diff",
    --           "html",
    --           "javascript",
    --           "json",
    --           "eex",
    --           "elixir",
    --           "go",
    --           "gomod",
    --           "gosum",
    --           "gowork",
    --           "heex",
    --           "kotlin",
    --           "lua",
    --           "markdown",
    --           "markdown_inline",
    --           "python",
    --           "rust",
    --           "sql",
    --           "swift",
    --           "toml",
    --           "xml",
    --           "yaml",
    --         },
    --         highlight = {
    --           enable = true,
    --           disable = {},
    --           additional_vim_regex_highlighting = false,
    --         },
    --         incremental_selection = {
    --           enable = true,
    --           keymaps = {
    --             init_selection = "<C-space>",
    --             node_incremental = "<C-space>",
    --             scope_incremental = false,
    --             node_decremental = "<bs>",
    --           },
    --         },
    --       })
    --     end,
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
