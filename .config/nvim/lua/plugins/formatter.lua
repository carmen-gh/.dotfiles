return {
  "stevearc/conform.nvim",
  lazy = true,
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    conform.setup({
      notify_on_error = false,
      formatters_by_ft = {
        go = { "goimports" },
        html = { "prettier" },
        json = { "prettier" },
        kotlin = { "ktlint " },
        lua = { "stylua" },
        markdown = { "prettier" },
        sql = { "sql-formatter" },
        yaml = { "prettier" },
      },
      format_on_save = {
        lsp_fallback = true,
        timeout_ms = 500,
      },
    })

    vim.keymap.set({ "n", "v" }, "<leader>cf", function()
      conform.format({ lsp_fallback = true, async = false, timeout_ms = 1000 })
    end, { desc = "Format file or range (in visual mode)" })
  end,
}
