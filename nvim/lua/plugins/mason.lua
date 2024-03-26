return {

  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        ui = {
          border = "rounded",
        },
      })
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {
      "williamboman/mason.nvim",
    },
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
          "bash-language-server",
          "bashls",
          "black",
          "codelldb",
          "delve",
          "detekt",
          "eslint",
          "gofumpt",
          "goimports",
          "golangci-lint",
          "golines",
          "gomodifytags",
          "gopls",
          "html",
          "impl",
          "isort",
          "jsonls",
          "kotlin_language_server",
          "ktlint",
          "lemminx",
          "lua_ls",
          "markdownlint",
          "marksman",
          "misspell",
          "prettier",
          "rust-analyzer",
          "shellcheck",
          "shfmt",
          "stylua",
          "yamlls",
          "gotests",
          "iferr",
        },
      })
    end,
  },
}
