if vim.g.loaded_vim_projectionist_elixir then
  return
end
vim.g.loaded_vim_projectionist_elixir = 1

local script_source_path_info = debug.getinfo(1, "S")
local script_source_path = script_source_path_info.source
local script_file_path

if script_source_path:sub(1, 1) == "@" then
  script_file_path = script_source_path:sub(2)
else
  script_file_path = script_source_path
end

local resolved_script_path = vim.fn.resolve(script_file_path)
local s_base_dir = vim.fn.fnamemodify(resolved_script_path, ":h")
local s_proj_jsn = s_base_dir .. "/projections.json"

local function s_setProjections()
  local l_json_lines
  local read_ok, result_or_err = pcall(vim.fn.readfile, s_proj_jsn)
  if read_ok then
    l_json_lines = result_or_err
  else
    l_json_lines = {}
  end

  local l_dict = vim.fn["projectionist#json_parse"](l_json_lines)
  vim.fn["projectionist#append"](vim.fn.getcwd(), l_dict)
end

local augroup_name = "elixir"
vim.api.nvim_create_augroup(augroup_name, { clear = true })

vim.api.nvim_create_autocmd("User", {
  pattern = "ProjectionistDetect", -- Das zu überwachende User-Event
  group = augroup_name,
  callback = s_setProjections, -- Die Lua-Funktion, die aufgerufen wird
})

vim.keymap.set("n", "ga", ":A<CR>", { noremap = true, silent = true, desc = "alternate" })
