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

vim.g.markdown_fenced_languages = { "bash", "html", "kotlin", "go", "rust", "dart" } -- enable code highlight in markdown code snippets

-- toggle checkbox
function ToggleCheckbox()
  local currentBuffer = vim.api.nvim_get_current_buf()
  local currentLine = vim.api.nvim_win_get_cursor(0)[1]
  local lineContent = vim.api.nvim_buf_get_lines(currentBuffer, currentLine - 1, currentLine, false)[1]

  -- Toggle the checkbox in the current line
  if lineContent:find("%[x%]") then
    lineContent = lineContent:gsub("%[x%]", "[ ]")
  elseif lineContent:find("%[ %]") then
    lineContent = lineContent:gsub("%[ %]", "[x]")
  end

  vim.api.nvim_buf_set_lines(currentBuffer, currentLine - 1, currentLine, false, { lineContent })
end

vim.keymap.set(
  "n",
  "<leader>t",
  ":lua ToggleCheckbox()<CR>",
  { noremap = true, silent = true, desc = "toggle checkbox" }
)
