-- vim.lsp.inlay_hint.enable(true)

-- NOTE: Keympas
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),

  callback = function(event)
    local function map(mode, l, r, desc)
      vim.keymap.set(mode, l, r, { buffer = event.buf, desc = desc })
    end

    map("n", "gD", vim.lsp.buf.declaration, "go to declaration")
    map("n", "gd", vim.lsp.buf.definition, "go to definition")
    map("n", "gI", vim.lsp.buf.implementation, "go to implementation")
    map("n", "<C-k>", vim.lsp.buf.signature_help, "singnature help")
    map("n", "<leader>cr", vim.lsp.buf.rename, "rename")
    map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "code action")

    -- The following two autocommands are used to highlight references of the
    -- word under your cursor when your cursor rests there for a little while.
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client.server_capabilities.documentHighlightProvider then
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = event.buf,
        callback = vim.lsp.buf.document_highlight,
      })

      -- When you move your cursor, the highlights will be cleared
      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = event.buf,
        callback = vim.lsp.buf.clear_references,
      })
    end

    -- inlay hins
    if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
      -- stylua: ignore
      map("n", "<leader>ch", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, "toggle inlay hints")
    end

    -- codelens
    if client and client.supports_method("textDocument/codeLens") and vim.lsp.codelens then
      vim.lsp.codelens.refresh()
      vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
        buffer = event.buf,
        callback = vim.lsp.codelens.refresh,
      })
    end
  end,
})
