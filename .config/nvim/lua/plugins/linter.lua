return {
  "mfussenegger/nvim-lint",
  lazy = true,
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")
    lint.linters_by_ft = {
      elixir = { "credo" },
      go = { "golangcilint" },
      kotlin = { "ktlint" },
      sql = { "sqlfluff" },
    }

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })

    -- stylua: ignore
    vim.keymap.set("n", "<leader>cl", function() lint.try_lint() end, { desc = "linting for current file" })
  end,
}
