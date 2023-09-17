return {
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    opts = function(_, opts)
      require("gopher").setup(opts)
      vim.cmd([[silent! GoInstallDeps]])
    end,
  },
}
