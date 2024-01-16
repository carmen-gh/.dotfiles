return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		{ "theHamsta/nvim-dap-virtual-text", opts = {} },
	},
	config = function()
		require("dapui").setup()
		require("nvim-dap-virtual-text").setup()

		local dap, dapui = require("dap"), require("dapui")

		dap.listeners.after.event_initialized.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

		vim.fn.sign_define("DapBreakpoint", { text = " ", texthl = "DiagnosticSignError", linehl = "", numhl = "" })
		vim.fn.sign_define("DapStopped", { text = "󰁕 ", texthl = "DiagnosticWarn", linehl = "", numhl = "" })
		vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

		vim.keymap.set("n", "<Leader>db", "<cmd>DapToggleBreakpoint<CR>", { desc = "toggle Breakpoint" })
		vim.keymap.set("n", "<Leader>dc", "<cmd>DapContinue<CR>", { desc = "continue or start" })
		vim.keymap.set("n", "<Leader>do", "<cmd>DapStepOver<CR>", { desc = "step over" })
		vim.keymap.set("n", "<Leader>dt", "<cmd>DapTerminate<CR>", { desc = "terminate" })
		vim.keymap.set("n", "<leader>du", function()
			require("dapui").toggle()
		end, { desc = "toggle debugging UI" })
	end,
}
