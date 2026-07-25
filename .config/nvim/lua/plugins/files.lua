return {
  "nvim-mini/mini.files",
  opts = {
    windows = {
      preview = false,
      width_focus = 30,
    },
    options = {
      use_as_default_explorer = true,
    },
  },
  keys = {
    {
      "<leader>e",
      function()
        require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
      end,
      desc = "Open mini.files (Directory of Current File)",
    },
  },
  config = function(_, opts)
    require("mini.files").setup({

      mappings = {
        go_in_plus = "<CR>",
        go_out_plus = "-",
        mark_goto = "'",
        mark_set = "m",
        reveal_cwd = ".",
        show_help = "g?",
        synchronize = "=",
        trim_left = "<",
        trim_right = ">",
      },
    })

    -- toggle dotfiles
    local show_dotfiles = true
    local filter_show = function(fs_entry)
      return true
    end
    local filter_hide = function(fs_entry)
      return not vim.startswith(fs_entry.name, ".")
    end
    local toggle_dotfiles = function()
      show_dotfiles = not show_dotfiles
      local new_filter = show_dotfiles and filter_show or filter_hide
      MiniFiles.refresh({ content = { filter = new_filter } })
    end

    -- Yank in register full path of entry under cursor
    local yank_path = function()
      local path = (MiniFiles.get_fs_entry() or {}).path
      if path == nil then
        return vim.notify("Cursor is not on valid entry")
      end
      vim.fn.setreg(vim.v.register, path)
    end

    -- Open path with system default handler (useful for non-text files)
    local ui_open = function()
      vim.ui.open(MiniFiles.get_fs_entry().path)
    end

    local map_split = function(buf_id, lhs, direction)
      local rhs = function()
        local cur_target = MiniFiles.get_explorer_state().target_window
        local new_target = vim.api.nvim_win_call(cur_target, function()
          vim.cmd(direction .. " split")
          return vim.api.nvim_get_current_win()
        end)
        MiniFiles.set_target_window(new_target)
      end

      local desc = "Split " .. direction
      vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = desc })
    end

    vim.api.nvim_create_autocmd("User", {
      pattern = "MiniFilesBufferCreate",
      callback = function(args)
        local buf_id = args.data.buf_id
        map_split(buf_id, "<C-s>", "belowright horizontal")
        map_split(buf_id, "<C-v>", "belowright vertical")
        vim.keymap.set("n", "g.", toggle_dotfiles, { buffer = buf_id, desc = "Toggle hidden files" })
        vim.keymap.set("n", "gy", yank_path, { buffer = b, desc = "Yank path" })
        vim.keymap.set("n", "gX", ui_open, { buffer = b, desc = "OS open" })
      end,
    })

    -- vim.api.nvim_create_autocmd("User", {
    --   pattern = "MiniFilesActionRename",
    --   callback = function(event)
    --     Snacks.rename.on_rename_file(event.data.from, event.data.to)
    --   end,
    -- })
  end,
}
