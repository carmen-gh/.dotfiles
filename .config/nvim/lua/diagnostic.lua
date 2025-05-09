vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "󱐋 ",
      [vim.diagnostic.severity.WARN] = "󱐋 ",
      [vim.diagnostic.severity.HINT] = "» ",
      [vim.diagnostic.severity.INFO] = " ",
    },
  },
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
    prefix = " ● ",
  },
  document_highlight = {
    enabled = true,
  },
  codelens = {
    enabled = false,
  },
})
