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
    map("n", "gr", "<cmd>Telescope lsp_references theme=ivy path_display={'tail'}<cr>", "go to references")
    map("n", "<leader>fr", "<cmd>Telescope lsp_references theme=ivy path_display={'tail'}<cr>", "references")

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

    -- enable inlay hints in your, if the language server you are using supports them
    if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
      -- stylua: ignore
      map("n", "<leader>ch", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, "toggle inlay hints")
    end
  end,
})

return {
  {
    "j-hui/fidget.nvim", -- show lsp progress
    config = function()
      local fidget = require("fidget")
      fidget.setup({ notification = { window = { winblend = 0 } } })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "b0o/schemastore.nvim",
      { "folke/neodev.nvim", opts = {} },
    },
    config = function()
      require("mason").setup()
      local lspconfig = require("lspconfig")
      local mason_lsp = require("mason-lspconfig")
      local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

      local server_list = {
        "bashls",
        "gopls",
        "html",
        "jsonls",
        "kotlin_language_server",
        "lemminx",
        "lua_ls",
        "marksman",
        "rust_analyzer",
        "yamlls",
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
        "yamlls",
      })
      require("mason-tool-installer").setup({ ensure_installed = server_list })

      local handlers = {
        -- Default handler
        function(server_name)
          require("lspconfig")[server_name].setup({
            capabilities = lsp_capabilities,
          })
        end,

        -- Targeted overrides for specific servers.
        ["lua_ls"] = function()
          lspconfig.lua_ls.setup({
            settings = require("plugins.lsp-settings.lua_ls").settings,
          })
        end,

        ["jsonls"] = function()
          lspconfig.lua_ls.setup({
            settings = require("plugins.lsp-settings.jsonls").settings,
          })
        end,

        ["yamlls"] = function()
          lspconfig.lua_ls.setup({
            settings = require("plugins.lsp-settings.yamlls").settings,
          })
        end,

        ["gopls"] = function()
          lspconfig.gopls.setup({
            settings = require("plugins.lsp-settings.gopls").settings,
          })
        end,
      }
      mason_lsp.setup({ handlers = handlers })

      local default_diagnostic_config = {
        signs = {
          active = true,
          values = {
            { name = "DiagnosticSignError", text = " " },
            { name = "DiagnosticSignWarn", text = " " },
            { name = "DiagnosticSignHint", text = " " },
            { name = "DiagnosticSignInfo", text = " " },
          },
        },
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
        },
        severity_sort = true,
        float = {
          focusable = true,
          style = "minimal",
          border = "rounded",
          source = "always",
          header = "",
          prefix = " ",
        },
      }
      vim.diagnostic.config(default_diagnostic_config)
      for _, sign in ipairs(vim.tbl_get(vim.diagnostic.config(), "signs", "values") or {}) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
      end

      -- stylua: ignore
      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
    end,
  },
}
