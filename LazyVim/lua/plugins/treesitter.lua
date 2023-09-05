return { -- add more treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- add more languages to ensure installed
      vim.list_extend(opts.ensure_installed, {
        "kotlin",
        "toml",
      })
    end,
  },
  {
    "Wansmer/treesj",
    keys = {
      { "<leader>cj", ":lua require('treesj').toggle()<CR>", desc = "Join code block (toggle)" },
    },
  },
}
