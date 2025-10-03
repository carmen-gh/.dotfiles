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
      local lsp = vim.lsp.util.get_progress_messages()[1]
      if lsp then
        local name = lsp.name or ""
        local title = lsp.title or ""
        -- local msg = lsp.message or ""
        local percentage = lsp.percentage or 0
        -- return string.format(" %%<%s: %s %s (%s%%%%) ", name, title, msg, percentage)
        return string.format(" 󰲽 %%<%s: %s (%s%%%%) ", name, title, percentage)
      end
    end,
  },
  bookmark = {
    function()
      return " " .. require("grapple").name_or_index()
    end,
    cond = function()
      return package.loaded["grapple"] and require("grapple").exists()
    end,
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
        hide = { only_win = false },
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
            "dap-repl",
            "dapui*",
            "neo-tree",
            "oil",
            "outline",
          },
        },
        sections = {
          lualine_a = { components.mode },
          lualine_b = {},
          lualine_c = {
            { "filename", path = 1, padding = { left = 2, right = 1 }, icon = "" },
            -- { "filetype", icon_only = true, colored = true, padding = { left = 1, right = 0 } },
            components.diagnostics,
          },
          lualine_z = {},
          lualine_y = {},
          lualine_x = {
            components.lsp_status,
            components.dap,
            components.flutter_device,
            components.bookmark,
            components.branch,
            {
              "progress",
              left_padding = 2,
              right_padding = 2,
            },
          },
        },
        extensions = {
          "fzf",
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
