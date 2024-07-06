local textColor = "#181823"
local textColorLight = "#6c7086"

local components = {
  mode = {
    "mode",
    padding = { left = 2, right = 2 },
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
}

-- Lualine Config
return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function()
      return {
        options = {
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
          lualine_c = {},
          lualine_x = {},
          lualine_z = {},
          lualine_y = {
            components.diagnostics,
            components.dap,
            components.flutter_device,
            components.lsp_status,
            components.branch,
            {
              "progress",
              left_padding = 2,
              right_padding = 2,
            },
          },
        },
        winbar = {
          lualine_x = {
            { "filetype", icon_only = true, colored = true, padding = { right = 1 } },
            {
              "filename",
              padding = { left = 0, right = 2 },
            },
          },
        },
        inactive_winbar = {
          lualine_x = {
            { "filetype", icon_only = true, colored = false, color = { fg = textColorLight } },
            {
              "filename",
              padding = { right = 1 },
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
