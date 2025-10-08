return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    animate = { enabled = true },
    bigfile = { enabled = true },
    bufdelete = { enabled = false },
    explorer = {
      enabled = true,
      replace_netrw = true,
      auto_close = true,
      jump = { close = true },
    },
    image = { enabled = true },
    indent = {
      enabled = true,
      animate = {
        enabled = false,
      },
    }, -- TODO
    input = { enabled = true },
    lazygit = { enabled = false },
    notifier = { enabled = true, timeout = 3000 },
    picker = { enabled = true },
    quickfile = { enabled = true },
    rename = { enabled = true },
    scope = { enabled = true },
    scratch = { enabled = false },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    styles = {
      notification = { wo = { wrap = true } },
      input = { relative = "cursor" },
    },
  },
  keys = {
    -- stylua: ignore start
    { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },
    { "<leader>fh", function() Snacks.picker.help() end, desc = "Help" },
    { "<leader>fk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
    { "<leader>fu", function() Snacks.picker.undo() end, desc = "Undo" },

    -- grep
    { "<leader>/", function() Snacks.picker.grep_buffers() end, desc = "Grep Buffers" },
    { "<leader>fg", function() Snacks.picker.grep() end, desc = "Grep" },
    { "<leader>fw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },

    -- files
    { "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffers" },
    { "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
    { "<leader>ff", function() Snacks.picker.files() end, desc = "Files" },

    -- git
    { "<leader>fm", function() Snacks.picker.git_status() end, desc = "Modified Git Files" },
    { "<leader>gb", function() Snacks.picker.git_branches() end, desc = "Branches" },
    { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Browse", mode = { "n", "v" } },

    -- lsp
    { "<leader>fD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
    { "<leader>fd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
    { "<leader>cs", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
    { "<leader>cS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
    { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },

    { "<leader>n", function() Snacks.picker.notifications() end, desc = "Notification History" },
    { "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },

    -- words
    {"]]", function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" },},
    {"[[", function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" },},
    -- stylua: ignore end
  },
  init = function()
    -- LSP Progress
    vim.api.nvim_create_autocmd("LspProgress", {
      ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
      callback = function(ev)
        local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
        vim.notify(vim.lsp.status(), "info", {
          id = "lsp_progress",
          title = "LSP Progress",
          opts = function(notif)
            notif.icon = ev.data.params.value.kind == "end" and " "
              or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
          end,
        })
      end,
    })
  end,
}
