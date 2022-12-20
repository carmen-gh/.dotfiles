local status, lualine = pcall(require, "lualine")
if not status then
    return
end

--local C = require("catppuccin.palettes").get_palette()
local Icons = require("camina.icons")

local config = {
    options = {
        theme = "onedark",
        globalstatus = true,
        component_separators = { left = " ", right = " " },
        section_separators = { left = " ", right = " " },
        disabled_filetypes = {
            statusline = {},
            winbar = { "packer", "neo-tree" },
        },
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = {
            {
                "branch",
                icon = Icons.git.Branch,
            },
            {
                "diagnostics",
                symbols = {
                    error = Icons.diagnostics.BoldError,
                    warn = Icons.diagnostics.BoldWarning,
                    info = Icons.diagnostics.BoldInformation,
                    hint = Icons.diagnostics.BoldHint
                },
            },
        },
        lualine_c = {},
        lualine_x = {},
        lualine_y = { "progress" },
        lualine_z = { "location" },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    },
    winbar = {
        lualine_a = {
            {
                "filetype",
                colored = true,
                icon_only = true,
                --color = { bg = C.surface0 },
            },
            {
                "filename",
                --color = { fg = C.blue, bg = C.mantle },
            },
        },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    },
    inactive_winbar = {
        lualine_a = {
            {
                "filetype",
                colored = true,
                icon_only = true,
                --color = { bg = C.surface1 },
            },
            {
                "filename",
                --color = { fg = C.blue, bg = C.surface0 },
            },
        },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    },
    extension = { "neo-tree" },
}

local function ins_right(component)
    table.insert(config.sections.lualine_x, component)
end

local function ins_left(component)
    table.insert(config.sections.lualine_c, component)
end

ins_right({
    -- Lsp server name
    function()
        local msg = "-"
        local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
        local clients = vim.lsp.get_active_clients()
        if next(clients) == nil then
            return msg
        end
        for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 and client.name ~= "null-ls" then
                return client.name
            end
        end
        return msg
    end,
    icon = Icons.ui.Gears,
    --color = { fg = C.text },
})

ins_right({
    "lsp_progress",
    -- display_components = { 'lsp_client_name', { 'title', 'percentage', 'message' }},
    -- With spinner
    -- display_components = { 'lsp_client_name', 'spinner', { 'title', 'percentage', 'message' }},
    display_components = { "spinner" },
    -- colors = {
    --   percentage  = colors.cyan,
    --   title  = colors.cyan,
    --   message  = colors.cyan,
    --   spinner = colors.cyan,
    --   lsp_client_name = colors.magenta,
    --   use = true,
    -- },
    -- separators = {
    --     component = " ",
    --     progress = " | ",
    --     message = { pre = "(", post = ")" },
    --     percentage = { pre = "", post = "%% " },
    --     title = { pre = "", post = ": " },
    --     lsp_client_name = { pre = "[", post = "]" },
    --     spinner = { pre = "", post = "" },
    --     message = { commenced = "In Progress", completed = "Completed" },
    -- },
    -- display_components = { 'lsp_client_name', 'spinner', { 'title', 'percentage', 'message' } },
    -- timer = { progress_enddelay = 500, spinner = 1000, lsp_client_name_enddelay = 1000 },
    spinner_symbols = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
})

lualine.setup(config)
