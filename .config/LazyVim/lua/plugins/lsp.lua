return {
  {
    "williamboman/mason.nvim",
    -- add more lsp to ensure installed
    opts = {
      ensure_installed = {
        "stylua",
        "shfmt",
      },
    },
  },
}
