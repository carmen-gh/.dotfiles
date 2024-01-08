-- Markdown specific settings
vim.opt.wrap = true -- Wrap text
vim.opt.breakindent = true -- Match indent on line break
vim.opt.linebreak = true -- Line break on whole words
vim.opt.conceallevel = 3 -- Hide * markup for bold and italic

-- Allow j/k when navigating wrapped lines
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")

-- Spell check
vim.opt.spelllang = "en_us"
vim.opt.spell = true

vim.g.markdown_fenced_languages = { "html", "kotlin", "go", "rust", "dart" } -- enable code highlight in markdown code snippets
