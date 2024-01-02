local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
    return
end

-- configure treesitter
treesitter.setup {
    -- enable syntax highlighting
    highlight = {
        enable = true,
    },
    -- enable rainbow brackets
    rainbow = {
        enable = true,
        extended_mode = true,
    },
    -- enable indentation
    indent = { enable = true },
    autotag = { enable = true },
    -- ensure these language parsers are installed
    --auto_install = true,
}
