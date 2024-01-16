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
					"black",
					"bashls",
					"eslint",
					"html",
					"codelldb",
					"delve",
					"gofumpt",
					"golangci-lint",
					"golines",
					"gomodifytags",
					"gopls",
					"goimports",
					--"gotest",
					"impl",
					"jsonls",
					"lemminx",
					"lua_ls",
					"ktlint",
					"kotlin_language_server",
					"detekt",
					"isort",
					"misspell",
					"markdownlint",
					"marksman",
					"shellcheck",
					"shfmt",
					"stylua",
					"prettier",
					"yamlls",
					"rust-analyzer",
				},
			})
		end,
	},
}
