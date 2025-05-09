-- NOTE: Keympas
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),

  callback = function(event)
    local function map(mode, l, r, desc)
      vim.keymap.set(mode, l, r, { buffer = event.buf, desc = desc })
    end

    map("n", "gD", vim.lsp.buf.declaration, "go to declaration")
    map("n", "gd", vim.lsp.buf.definition, "go to definition")
    map("n", "gI", vim.lsp.buf.implementation, "go to implementation")
    map("n", "<C-k>", vim.lsp.buf.signature_help, "singnature help")
    map("n", "<leader>cr", vim.lsp.buf.rename, "rename")
    map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "code action")
    map("n", "<leader>xd", "<cmd>Telescope diagnostics theme=ivy<cr>", "diagnostics")
    map("n", "gr", "<cmd>Telescope lsp_references theme=ivy<cr>", "go to references")
    map("n", "<leader>fr", "<cmd>Telescope lsp_references theme=ivy<cr>", "references")

    -- The following two autocommands are used to highlight references of the
    -- word under your cursor when your cursor rests there for a little while.
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client.server_capabilities.documentHighlightProvider then
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = event.buf,
        callback = vim.lsp.buf.document_highlight,
      })

      -- When you move your cursor, the highlights will be cleared
      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = event.buf,
        callback = vim.lsp.buf.clear_references,
      })
    end

    -- inlay hins
    if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
      -- stylua: ignore
      map("n", "<leader>ch", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, "toggle inlay hints")
    end

    -- codelens
    if client and client.supports_method("textDocument/codeLens") and vim.lsp.codelens then
      vim.lsp.codelens.refresh()
      vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
        buffer = event.buf,
        callback = vim.lsp.codelens.refresh,
      })
    end
  end,
})

return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    -- Mason must be loaded before its dependencies, so we need to set it up here
    { "williamboman/mason.nvim", opts = {} },
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "b0o/schemastore.nvim",
  },
  config = function()
    local server_list = {
      bashls = {},
      elixirls = {},
      gopls = { settings = require("plugins.lsp-settings.gopls") },
      html = {},
      jsonls = { settings = require("plugins.lsp-settings.jsonls") },
      kotlin_language_server = {},
      lemminx = {},
      lua_ls = { setttings = require("plugins.lsp-settings.lua_ls") },
      marksman = {},
      rust_analyzer = {},
      tailwindcss = { settings = require("plugins.lsp-settings.tailwindcss") },
      yamlls = { settings = require("plugins.lsp-settings.yamlls") },
    }

    -- extend the list with tools
    vim.list_extend(server_list, {
      "codelldb",
      "delve",
      "detekt",
      "eslint",
      "gofumpt",
      "goimports",
      "golangci-lint",
      "golines",
      "gomodifytags",
      "gotests",
      "iferr",
      "impl",
      "isort",
      "ktlint",
      "kotlin-debug-adapter",
      "markdownlint",
      "marksman",
      "misspell",
      "prettier",
      "shellcheck",
      "shfmt",
      "stylua",
      "sqlfluff",
      "yamlls",
    })
    require("mason-tool-installer").setup({ ensure_installed = server_list })

    -- NOTE: Some servers still require the nvim-lspconfig setup until they are updated
    -- Add this template inside the handler function after initializing config if you encounter issues with any lsp
    --
    -- if server_name == 'example_server' or server_name == 'example_server2' then
    --   -- This handles overriding only values explicitly passed
    --   -- by the server configuration above. Useful when disabling
    --   -- certain features of an LSP (for example, turning off formatting for ts_ls)
    --   local capabilities = require('blink.cmp').get_lsp_capabilities()
    --   config.capabilities = vim.tbl_deep_extend('force', {}, capabilities, config.capabilities or {})
    --   require('mason-lspconfig')[server_name].setup(config)
    --   return
    -- end

    require("mason-lspconfig").setup({
      ensure_installed = {}, -- explicitly set to an empty table (will be installed via mason-tool-installer)
      automatic_installation = false,
      handlers = {
        function(server_name)
          local config = server_list[server_name] or {}
          vim.lsp.config(server_name, config)
          vim.lsp.enable(server_name)
        end,
      },
    })
  end,
}
