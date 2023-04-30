require("mason").setup({
    ui = {
        border = "rounded",
    }
})


local lsp = require('lsp-zero')

local Icons = require("camina.icons")

lsp.set_preferences({
    float_border = 'rounded',
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
local cmp = require('cmp')
lsp.setup_nvim_cmp({
    formatting = {
        preselect = cmp.PreselectMode.None,
        fields = { "abbr", "kind", "menu" },
        format = lspkind.cmp_format({
            mode = 'symbol_text',
            maxwidth = '30',
            symbol_map = { Codeium = Icons.misc.Robot, }
        }),
        window = {
            completion = {
                winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
                col_offset = -3,
                side_padding = 0,
            },
        },
    },
    confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
    },
    sources = cmp.config.sources {
        { name = "nvim_lsp", priority = 1000 },
        { name = "luasnip",  priority = 750 },
        { name = "buffer",   priority = 500 },
        { name = "codeium",  priority = 500 },
        { name = "path",     priority = 250 },
    },
})
-- disable codeium inline, only show cmp completion
vim.g['codeium_manual'] = true

-- Swift Lsp
lsp.configure('sourcekit', {
    force_setup = true,
})

lsp.setup()

-- diagnostic configuration

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
