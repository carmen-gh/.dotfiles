local greyColor = "#949cbb"

local modes = {
  ["n"] = { "NORMAL", "St_NormalMode" },
  ["no"] = { "NORMAL (no)", "St_NormalMode" },
  ["nov"] = { "NORMAL (nov)", "St_NormalMode" },
  ["noV"] = { "NORMAL (noV)", "St_NormalMode" },
  ["noCTRL-V"] = { "NORMAL", "St_NormalMode" },
  ["niI"] = { "NORMAL i", "St_NormalMode" },
  ["niR"] = { "NORMAL r", "St_NormalMode" },
  ["niV"] = { "NORMAL v", "St_NormalMode" },
  ["nt"] = { "NTERMINAL", "St_NTerminalMode" },
  ["ntT"] = { "NTERMINAL (ntT)", "St_NTerminalMode" },

  ["v"] = { "VISUAL", "St_VisualMode" },
  ["vs"] = { "V-CHAR (Ctrl O)", "St_VisualMode" },
  ["V"] = { "V-LINE", "St_VisualMode" },
  ["Vs"] = { "V-LINE", "St_VisualMode" },
  [""] = { "V-BLOCK", "St_VisualMode" },

  ["i"] = { "INSERT", "St_InsertMode" },
  ["ic"] = { "INSERT (completion)", "St_InsertMode" },
  ["ix"] = { "INSERT completion", "St_InsertMode" },

  ["t"] = { "TERMINAL", "St_TerminalMode" },

  ["R"] = { "REPLACE", "St_ReplaceMode" },
  ["Rc"] = { "REPLACE (Rc)", "St_ReplaceMode" },
  ["Rx"] = { "REPLACEa (Rx)", "St_ReplaceMode" },
  ["Rv"] = { "V-REPLACE", "St_ReplaceMode" },
  ["Rvc"] = { "V-REPLACE (Rvc)", "St_ReplaceMode" },
  ["Rvx"] = { "V-REPLACE (Rvx)", "St_ReplaceMode" },

  ["s"] = { "SELECT", "St_SelectMode" },
  ["S"] = { "S-LINE", "St_SelectMode" },
  [""] = { "S-BLOCK", "St_SelectMode" },
  ["c"] = { "COMMAND", "St_CommandMode" },
  ["cv"] = { "COMMAND", "St_CommandMode" },
  ["ce"] = { "COMMAND", "St_CommandMode" },
  ["r"] = { "PROMPT", "St_ConfirmMode" },
  ["rm"] = { "MORE", "St_ConfirmMode" },
  ["r?"] = { "CONFIRM", "St_ConfirmMode" },
  ["x"] = { "CONFIRM", "St_ConfirmMode" },
  ["!"] = { "SHELL", "St_TerminalMode" },
}

local components = {
  mode = {
    function()
      local m = vim.api.nvim_get_mode().mode
      return "   " .. modes[m][1] .. " "
    end,
    padding = { left = 0, right = 0 },
    color = { gui = "bold" },
    cond = nil,
  },
  branch = {
    "b:gitsigns_head",
    icon = " ",
    color = { fg = greyColor, gui = "bold" },
  },
  diff = {
    "diff",
    colored = false,
    symbols = {
      added = " ",
      modified = " ",
      removed = " ",
    },
    -- padding = { left = 2, right = 1 },
    color = { fg = greyColor },
  },
  filename = {
    "filename",
    color = { fg = greyColor },
    cond = nil,
  },
  diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    symbols = { error = " ", warn = " ", info = " ", hint = " " },
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
        return string.format("  %s", unique_client_names)
      end
    end,
    color = { fg = greyColor },
  },
  lsp_progress = {
    function()
      local Lsp = vim.lsp.status()[1]

      if vim.o.columns < 120 or not Lsp then
        return ""
      end

      if Lsp.done then
        vim.defer_fn(function()
          vim.cmd.redrawstatus()
        end, 1000)
      end

      local msg = Lsp.message or ""
      local percentage = Lsp.percentage or 0
      local title = Lsp.title or ""
      local spinners = { "", "󰪞", "󰪟", "󰪠", "󰪢", "󰪣", "󰪤", "󰪥" }
      local ms = vim.loop.hrtime() / 1000000
      local frame = math.floor(ms / 120) % #spinners
      local content = string.format(" %%<%s %s %s (%s%%%%) ", spinners[frame + 1], title, msg, percentage)

      return ("%#St_LspProgress#" .. content) or ""
    end,
    color = { fg = greyColor, gui = "bold" },
  },
}

-- Lualine Config
return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function()
      return {
        options = {
          theme = "auto",
          globalstatus = true,
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          disabled_filetypes = { "Outline", "dashboard", "neo-tree" },
        },
        sections = {
          lualine_a = { components.mode },
          lualine_b = {},
          lualine_c = { components.branch, components.diff },
          lualine_x = {
            components.diagnostics,
            components.lsp_progress,
            components.lsp_status,
          },
          lualine_y = {},
        },
        winbar = {
          lualine_x = { { "filetype", icon_only = true, colored = true }, "filename" },
        },
        inactive_winbar = {
          lualine_y = { { "filetype", icon_only = true, colored = false }, "filename" },
        },
        extensions = { "neo-tree", "lazy", "trouble", "quickfix", "fugitive" },
      }
    end,
  },
}
