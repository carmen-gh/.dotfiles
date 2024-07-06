return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup({
        close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
        popup_border_style = "rounded",
        filesystem = {
          follow_current_file = { enabled = true },
        },
        enable_git_status = false,
        enable_diagnostics = false,
        default_component_configs = {
          indent = {
            with_markers = false,
            with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
            expander_collapsed = "",
            expander_expanded = "",
            expander_highlight = "NeoTreeExpander",
          },
        },
        event_handlers = {
          {
            event = "file_opened",
            handler = function(_)
              require("neo-tree.command").execute({ action = "close" }) -- auto close
            end,
          },
        },
      })

      vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle right<CR>", { desc = "explorer" })
      vim.keymap.set("n", "<leader>ge", "<cmd>Neotree git_status toggle right<CR>", { desc = "explorer" })
    end,
  },
  {
    "echasnovski/mini.files",
    opts = {
      mappings = {
        toggle_hidden = "g.",
        change_cwd = "gc",
        go_in_horizontal = "<C-w>s",
        go_in_vertical = "<C-w>v",
        go_in_horizontal_plus = "<C-w>S",
        go_in_vertical_plus = "<C-w>V",
      },
      windows = {
        preview = false,
        width_focus = 30,
        width_preview = 30,
      },
      options = {
        -- Whether to use for editing directories
        -- Disabled by default in LazyVim because neo-tree is used for that
        use_as_default_explorer = false,
      },
    },
    keys = {
      {
        "<leader>fe",
        function()
          require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
        end,
        desc = "Open mini.files (Directory of Current File)",
      },
      {
        "<leader>E",
        function()
          require("mini.files").open(vim.uv.cwd(), true)
        end,
        desc = "Open mini.files (cwd)",
      },
    },
    config = function(_, opts)
      require("mini.files").setup(opts)

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
        require("mini.files").refresh({ content = { filter = new_filter } })
      end

      local map_split = function(buf_id, lhs, direction, close_on_file)
        local rhs = function()
          local new_target_window
          local cur_target_window = require("mini.files").get_target_window()
          if cur_target_window ~= nil then
            vim.api.nvim_win_call(cur_target_window, function()
              vim.cmd("belowright " .. direction .. " split")
              new_target_window = vim.api.nvim_get_current_win()
            end)

            require("mini.files").set_target_window(new_target_window)
            require("mini.files").go_in({ close_on_file = close_on_file })
          end
        end

        local desc = "Open in " .. direction .. " split"
        if close_on_file then
          desc = desc .. " and close"
        end
        vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = desc })
      end

      local files_set_cwd = function()
        local cur_entry_path = MiniFiles.get_fs_entry().path
        local cur_directory = vim.fs.dirname(cur_entry_path)
        if cur_directory ~= nil then
          vim.fn.chdir(cur_directory)
        end
      end

      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesBufferCreate",
        callback = function(args)
          local buf_id = args.data.buf_id

          vim.keymap.set(
            "n",
            opts.mappings.toggle_hidden,
            toggle_dotfiles,
            { buffer = buf_id, desc = "Toggle hidden files" }
          )

          vim.keymap.set("n", opts.mappings.change_cwd, files_set_cwd, { buffer = args.data.buf_id, desc = "Set cwd" })

          map_split(buf_id, opts.mappings.go_in_horizontal, "horizontal", false)
          map_split(buf_id, opts.mappings.go_in_vertical, "vertical", false)
          map_split(buf_id, opts.mappings.go_in_horizontal_plus, "horizontal", true)
          map_split(buf_id, opts.mappings.go_in_vertical_plus, "vertical", true)
        end,
      })

      -- vim.api.nvim_create_autocmd("User", {
      --   pattern = "MiniFilesActionRename",
      --   callback = function(event)
      --     LazyVim.lsp.on_rename(event.data.from, event.data.to)
      --   end,
      -- })
    end,
  },
}
