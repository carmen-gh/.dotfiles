-- TODO disable for markdown files (lsp marksman)
return {
  "nvim-neotest/neotest",
  lazy = true,
  dependencies = {
    "nvim-neotest/nvim-nio",
    "jfpedroza/neotest-elixir",
    "fredrikaverpil/neotest-golang",
    "sidlatau/neotest-dart",
  },
  opts = {
    adapters = {
      ["neotest-elixir"] = {},
      ["neotest-golang"] = {
        dap_go_enabled = true, -- requires leoluz/nvim-dap-go
        go_test_args = { "-v", "-race", "-count=1", "-timeout=60s" },
      },
      ["neotest-dart"] = {
        command = "flutter",
        use_lsp = true,
      },
    },
    status = { virtual_text = false },
    output = { open_on_run = true },
    -- quickfix = {
    --   open = function()
    --     vim.cmd("copen")
    --   end,
    -- },
    icons = {
      running_animated = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
      passed = "",
      failed = "",
      running = "󱥸",
      skipped = "",
      unknown = "",
    },
  },
  config = function(_, opts)
    local neotest_ns = vim.api.nvim_create_namespace("neotest")
    vim.diagnostic.config({
      virtual_text = {
        format = function(diagnostic)
          -- Replace newline and tab characters with space for more compact diagnostics
          local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
          return message
        end,
      },
    }, neotest_ns)

    if opts.adapters then
      local adapters = {}
      for name, config in pairs(opts.adapters or {}) do
        if type(name) == "number" then
          if type(config) == "string" then
            config = require(config)
          end
          adapters[#adapters + 1] = config
        elseif config ~= false then
          local adapter = require(name)
          if type(config) == "table" and not vim.tbl_isempty(config) then
            local meta = getmetatable(adapter)
            if adapter.setup then
              adapter.setup(config)
            elseif adapter.adapter then
              adapter.adapter(config)
              adapter = adapter.adapter
            elseif meta and meta.__call then
              adapter(config)
            else
              error("Adapter " .. name .. " does not support setup")
            end
          end
          adapters[#adapters + 1] = adapter
        end
      end
      opts.adapters = adapters
    end

    require("neotest").setup(opts)
  end,
  -- stylua: ignore
  keys = {
    {"<leader>t", "", desc = "+test"},
    { "<leader>tt", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run File" },
    { "<leader>tT", function() require("neotest").run.run(vim.uv.cwd()) end, desc = "Run All Test Files" },
    { "<leader>tr", function() require("neotest").run.run() end, desc = "Run Nearest" },
    { "<leader>tl", function() require("neotest").run.run_last() end, desc = "Run Last" },
    { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle Summary" },
    { "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Show Output" },
    { "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "Toggle Output Panel" },
    { "<leader>tS", function() require("neotest").run.stop() end, desc = "Stop" },
    { "<leader>tw", function() require("neotest").watch.toggle(vim.fn.expand("%")) end, desc = "Toggle Watch for buffer" },
    { "<leader>dt", function() require("neotest").run.run({ suite = false, strategy = "dap" }) end, desc = "Debug nearest test" },
  },
}

-- simpler but output is not in quickfix list
-- also inline hinting is not great which test failed
-- lack of running all tests and get all results marked as diagnostic
-- return {
--   "quolpr/quicktest.nvim",
--   config = function()
--     require("quicktest").setup({
--       adapters = {
--         require("quicktest.adapters.golang")({
--           additional_args = function()
--             return { "-v", "-race", "-count=1", "timeout=60s" }
--           end,
--         }),
--         require("quicktest.adapters.elixir"), -- adaption see: https://github.com/quolpr/quicktest.nvim/issues/24
--         require("quicktest.adapters.dart"),
--       },
--       default_win_mode = "split",
--       use_baleia = false,
--     })
--   end,
--   dependencies = {
--     "nvim-lua/plenary.nvim",
--     "MunifTanjim/nui.nvim",
--   },
--   --stylua: ignore
--   keys = {
--     { "<leader>tr", function() require("quicktest").run_line() end, desc = "Run nearest", },
--     { "<leader>tf", function() require("quicktest").run_file() end, desc = "Run file", },
--     { "<leader>td", function() require("quicktest").run_dir() end, desc = "Run dir", },
--     { "<leader>tT", function() require("quicktest").run_all() end, desc = "Run all", },
--     { "<leader>tl", function() require("quicktest").run_previous() end, desc = "Run last", },
--     { "<leader>to", function() require("quicktest").toggle_win("split") end, desc = "toggle output", },
--     { "<leader>tc", function() require("quicktest").cancel_current_run() end, desc = "cancel current Run", },
--   },
-- }
