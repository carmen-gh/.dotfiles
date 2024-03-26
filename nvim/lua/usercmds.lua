vim.api.nvim_create_user_command("TermToggle", function()
  local is_open = vim.g.term_win_id ~= nil and vim.api.nvim_win_is_valid(vim.g.term_win_id)

  if is_open then
    vim.api.nvim_win_hide(vim.g.term_win_id)
    vim.g.term_win_id = nil
    return
  end

  -- Open new window 25 lines tall at the bottom of the screen
  vim.cmd("botright 25 new")
  vim.g.term_win_id = vim.api.nvim_get_current_win()

  local has_term_buf = vim.g.term_buf_id ~= nil and vim.api.nvim_buf_is_valid(vim.g.term_buf_id)

  if has_term_buf then
    vim.api.nvim_win_set_buf(vim.g.term_win_id, vim.g.term_buf_id)
  else
    vim.cmd.term()
    vim.g.term_buf_id = vim.api.nvim_get_current_buf()
  end

  vim.cmd.startinsert()
end, {})

vim.api.nvim_create_user_command("CloseAllOtherBuffers", function()
  vim.cmd([[up | %bd | e#]]) -- to save current buffer and close delete all open hidden buffers
end, {})
