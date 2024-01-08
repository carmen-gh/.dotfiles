-- NOTE: Keympas
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),

	callback = function(ev)
		-- TODO: add descriptions see git.lua
		local opts = { buffer = ev.buf }
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "gI", vim.lsp.buf.implementation, opts)
		vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
		vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, opts)
		vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "<leader>xd", "<cmd>Telescope diagnostics theme=ivy<cr>", opts)
		vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references theme=ivy path_display={'tail'}<cr>", opts)
		vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float)
		vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
		vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
	end,
})

-- NOTE: Server list
local server_list = {
	"bashls",
	"eslint",
	"lua_ls",
	"gopls",
	"html",
	"jsonls",
	"marksman",
	"yamlls",
	"kotlin_language_server",
	"rust_analyzer",
	"lemminx",
}

return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"b0o/schemastore.nvim",
			{ "j-hui/fidget.nvim", opts = {} },
			{ "folke/neodev.nvim", opts = {} },
		},
		config = function()
			local lspconfig = require("lspconfig")
			local mason = require("mason")
			local mason_lsp = require("mason-lspconfig")
			local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

			mason.setup({
				ui = {
					border = "rounded",
				},
			})

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
			}

			mason_lsp.setup({
				ensure_installed = server_list,
				handlers = handlers,
			})

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
					prefix = "",
				},
			}
			vim.diagnostic.config(default_diagnostic_config)
			for _, sign in ipairs(vim.tbl_get(vim.diagnostic.config(), "signs", "values") or {}) do
				vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
			end

			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })
			vim.lsp.handlers["textDocument/signatureHelp"] =
				vim.lsp.with(vim.lsp.handlers.signature_help, { border = "single" })
		end,
	},
}
