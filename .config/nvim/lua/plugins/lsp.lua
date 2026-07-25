return {
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "bashls",
        "copilot",
        "elixirls",
        "gopls",
        "html",
        "jsonls",
        "kotlin_language_server",
        "lemminx",
        "lua_ls",
        "marksman",
        "rust_analyzer",
        "tailwindcss",
        "yamlls",
      },
    },
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
  },
}
