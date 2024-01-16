-- TODO: add lsp, linter, formatter
-- TODO: add go plugin
return {
	{
		"leoluz/nvim-dap-go",
		opts = {},
	},
	-- { "nvim-neotest/neotest-go" } see testing.lua
	{
		"crispgm/nvim-go",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"neovim/nvim-lspconfig",
		},
		config = function()
			require("go").setup({
				notify = false,
				auto_format = true,
				auto_lint = true,
				-- linters: revive, errcheck, staticcheck, golangci-lint
				linter = "golangci-lint",
				-- linter_flags: e.g., {revive = {'-config', '/path/to/config.yml'}}
				linter_flags = {},
				-- lint_prompt_style: qf (quickfix), vt (virtual text)
				lint_prompt_style = "vt",
				-- formatter: goimports, gofmt, gofumpt, lsp
				formatter = "goimports",
				-- maintain cursor position after formatting loaded buffer
				maintain_cursor_pos = true,
				-- test flags: -count=1 will disable cache
				test_flags = { "-v" },
				test_timeout = "30s",
				test_env = {},
				-- show test result with popup window
				test_popup = false,
				test_popup_auto_leave = false,
				test_popup_width = 80,
				test_popup_height = 10,
				-- test open
				test_open_cmd = "edit",
				-- struct tags
				tags_name = "json",
				tags_options = { "json=omitempty" },
				tags_transform = "snakecase",
				tags_flags = { "-skip-unexported" },
				-- quick type
				quick_type_flags = { "--just-types" },
			})
		end,
	}, --NOTE: :GoInstallBinaries after plugin installed.
}
