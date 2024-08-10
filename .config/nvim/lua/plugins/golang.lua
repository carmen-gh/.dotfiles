return {
  -- gotestsum
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    build = function()
      vim.cmd.GoInstallDeps()
    end,
    config = function()
      require("gopher").setup({
        commands = {
          go = "go",
          gomodifytags = "gomodifytags",
          impl = "impl",
          iferr = "iferr",
          dlv = "dlv",
        },
      })

      -- NOTE: https://github.com/golang/go/issues/54531#issuecomment-1464982242
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("GoLspAttach", {}),

        callback = function(event)
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client.name == "gopls" and not client.server_capabilities.semanticTokensProvider then
            -- only for gopls lsp client

            local semantic = client.config.capabilities.textDocument.semanticTokens
            client.server_capabilities.semanticTokensProvider = {
              full = true,
              legend = { tokenModifiers = semantic.tokenModifiers, tokenTypes = semantic.tokenTypes },
              range = true,
            }
            vim.keymap.set("n", "<leader>ce", "<cmd>GoIfErr<cr>", { desc = "if error" })
            vim.keymap.set("n", "<leader>cj", "<cmd>GoTagAdd json<cr>", { desc = "json tag" })
            vim.keymap.set("n", "<leader>cg", "<cmd>GoTestsAll<cr>", { desc = "generate tests for file" })
          end
        end,
      })
    end,
  },
}
