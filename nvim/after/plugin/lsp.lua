require("mason").setup({
    ui = {
        border = "rounded",
    }
})


local lsp = require('lsp-zero')

local Icons = require("camina.icons")

lsp.set_preferences({
    suggest_lsp_servers = true,
    setup_servers_on_start = true,
    set_lsp_keymaps = true,
    configure_diagnostics = true,
    cmp_capabilities = true,
    manage_nvim_cmp = true,
    call_servers = 'local',
    sign_icons = {
        error = Icons.diagnostics.BoldError,
        warn = Icons.diagnostics.BoldWarning,
        hint = Icons.diagnostics.BoldHint,
        info = Icons.diagnostics.BoldInformation,
    }
})

lsp.nvim_workspace()

local lspkind = require('lspkind')
lsp.setup_nvim_cmp({
    formatting = {
        format = lspkind.cmp_format()
    },
})

lsp.configure('sourcekit', {
    force_setup = true,
})

lsp.setup()

vim.diagnostic.config({
    virtual_text = {
        prefix = Icons.git.FileUnstaged,
    },
    signs = true,
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = true,
})

local _border = "single"

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover, {
    border = _border
}
)

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
    vim.lsp.handlers.signature_help, {
    border = _border
}
)

vim.diagnostic.config {
    float = { border = _border }
}

require('lspconfig.ui.windows').default_options.border = _border
