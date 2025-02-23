-- local textColorLight = "#6c7086"

local components = {
  mode = {
    "mode",
    separator = { left = "", right = "" },
    color = { gui = "bold" },
  },
  branch = {
    "b:gitsigns_head",
    icon = " ",
  },
  diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    symbols = { error = " ", warn = " ", info = " ", hint = " " },
  },
  flutter_device = {
    function()
      local device = vim.g.flutter_tools_decorations.device
      local device_name = device and (device.name or device.id) or ""
      if device_name ~= "" then
        return " " .. device_name
      else
        return ""
      end
    end,
  },
  dap = {
    function()
      return "  " .. require("dap").status()
    end,
    cond = function()
      return package.loaded["dap"] and require("dap").status() ~= ""
    end,
  },
  lsp_status = {
    function()
      if rawget(vim, "lsp") then
        local buf_clients = vim.lsp.get_clients()
        local buf_client_names = {}

        if #buf_clients == 0 then
          return ""
        end

        for _, client in ipairs(buf_clients) do
          if client.attached_buffers[vim.api.nvim_get_current_buf()] and client.name ~= "null-ls" then
            table.insert(buf_client_names, client.name)
          end
        end

        local unique_client_names = table.concat(buf_client_names, ", ")
        return string.format(" %s", unique_client_names)
      end
    end,
  },
  harpoon = {
    "harpoon2",
    icon = "",
    _separator = " ",
    no_harpoon = "",
  },
}

return {
  -- use incline for better winbar settings then lualine offers
  {
    "b0o/incline.nvim",
    event = "VeryLazy",
    config = function()
      local devicons = require("mini.icons")
      require("incline").setup({
        hide = { only_win = true },
        highlight = {
          groups = {
            InclineNormal = { default = false, group = "Title" },
            InclineNormalNC = { default = true, group = "FloatTitle" },
          },
        },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          if filename == "" then
            filename = "[No Name]"
          end
          local ft_icon, ft_color = devicons.get("file", filename)
          local modified = vim.bo[props.buf].modified
          return {
            ft_icon and { ft_icon, " ", guibg = "none", group = ft_color } or "",
            { filename, gui = modified and "bold,italic" or "bold" },
          }
        end,
        --
      })
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "letieu/harpoon-lualine",
    },
    opts = function()
      return {
        options = {
          theme = "catppuccin",
          component_separators = "",
          section_separators = { left = "", right = "" },
          globalstatus = true,
          disabled_filetypes = {
            "alpha",
            "dap-repl",
            "dapui*",
            "dashboard",
            "neo-tree",
            "oil",
            "outline",
          },
        },
        sections = {
          lualine_a = { components.mode },
          lualine_b = {},
          lualine_c = {
            components.branch,
            { "filetype", icon_only = true, colored = true, padding = { left = 2, right = 1 } },
            { "filename", padding = { left = 0, right = 2 } },
            components.diagnostics,
          },
          lualine_z = {},
          lualine_y = {},
          lualine_x = {
            components.dap,
            components.flutter_device,
            components.harpoon,
            -- components.lsp_status,
            {
              "progress",
              left_padding = 2,
              right_padding = 2,
            },
          },
        },
        extensions = {
          "lazy",
          "mason",
          "neo-tree",
          "nvim-dap-ui",
          "oil",
          "quickfix",
        },
      }
    end,
  },
}
