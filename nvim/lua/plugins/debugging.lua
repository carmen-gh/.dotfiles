return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    { "theHamsta/nvim-dap-virtual-text", opts = {} },
    "williamboman/mason.nvim",
    -- special debuggers
    -- { "leoluz/nvim-dap-go", config = true },
  },
  config = function()
    require("dapui").setup()

    local dap, dapui = require("dap"), require("dapui")

    vim.fn.sign_define("DapBreakpoint", { text = " ", texthl = "DiagnosticSignError", linehl = "", numhl = "" })
    vim.fn.sign_define("DapStopped", { text = "󰁕 ", texthl = "DiagnosticWarn", linehl = "", numhl = "" })
    vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

    vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Start/Continue" })
    vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "step into" })
    vim.keymap.set("n", "<leader>do", dap.step_out, { desc = "step out" })
    vim.keymap.set("n", "<leader>dO", dap.step_over, { desc = "step over" })
    vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "toggle Breakpoint" })
    vim.keymap.set("n", "<leader>dB", function()
      dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
    end, { desc = "Set Breakpoint with condition" })
    vim.keymap.set("n", "<leader>dr", dap.repl.toggle, { desc = "toggle REPL" })
    vim.keymap.set("n", "<leader>dt", dap.terminate, { desc = "terminate" })
    vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "toggle UI" })
    vim.keymap.set({ "n", "v" }, "<leader>de", dapui.eval, { desc = "eval UI" })

    dap.listeners.after.event_initialized["dapui_config"] = dapui.open
    dap.listeners.before.event_terminated["dapui_config"] = dapui.close
    dap.listeners.before.event_exited["dapui_config"] = dapui.close

    -- Install language specific config
    require("gopher.dap").setup()
  end,
}
