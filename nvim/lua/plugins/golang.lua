return {
	-- gotestsum
	{
		"olexsmir/gopher.nvim",
		dependencies = { -- dependencies
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("gopher").setup({
				commands = {
					go = "go",
					gomodifytags = "gomodifytags",
					gotests = "/home/carmen/Developer/go/bin/gotests", -- also you can set custom command path
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
						local semantic = client.config.capabilities.textDocument.semanticTokens
						client.server_capabilities.semanticTokensProvider = {
							full = true,
							legend = { tokenModifiers = semantic.tokenModifiers, tokenTypes = semantic.tokenTypes },
							range = true,
						}
					end
				end,
			})
		end,
	},
}
