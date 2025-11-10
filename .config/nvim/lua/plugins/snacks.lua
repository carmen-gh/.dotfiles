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
    },
    input = { enabled = true },
    lazygit = { enabled = false },
    notifier = { enabled = true, timeout = 3000 },
    picker = {
      enabled = true,
      ui_select = true,
      layouts = {
        select = {
          layout = {
            relative = "cursor", -- TODO: only for spelling and code actions
            width = 70,
            min_width = 0,
            row = 1,
          },
        },
        dropdown = {
          hidden = { "preview" },
          layout = {
            backdrop = false,
            width = 0.5,
            min_width = 80,
            height = 0.4,
            min_height = 3,
            box = "vertical",
            border = "rounded",
            title = "{title}",
            title_pos = "center",
            { win = "input", height = 1, border = "bottom" },
            { win = "list", border = "none" },
            { win = "preview", title = "{preview}", height = 0.4, border = "top" },
          },
        },
      },
    },
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
    { "<leader>fh", function() Snacks.picker.help() end, desc = "Help" },
    { "<leader>fk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
    { "<leader>fu", function() Snacks.picker.undo({layout = "ivy"}) end, desc = "Undo" },
    { "<leader>fr", function() Snacks.picker.resume() end, desc = "Resume" },

    -- grep
    { "<leader>/", function() Snacks.picker.grep_buffers({layout = "ivy"}) end, desc = "Grep Buffers" },
    { "<leader>fg", function() Snacks.picker.grep() end, desc = "Grep" },
    { "<leader>fw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },

    -- files
    { "<leader>,", function() Snacks.picker.buffers({layout = "dropdown"}) end, desc = "Buffers" },
    { "<leader><space>", function() Snacks.picker.smart({layout = "ivy"}) end, desc = "Smart Find Files" },
    { "<leader>ff", function() Snacks.picker.files() end, desc = "Files" },
    { "<leader>fo", function() Snacks.picker.recent({layout = "dropdown"}) end, desc = "Old Files" },

    -- git
    { "<leader>fm", function() Snacks.picker.git_status() end, desc = "Modified Git Files" },
    { "<leader>gb", function() Snacks.picker.git_branches({layout = "ivy"}) end, desc = "Branches" },
    { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Browse", mode = { "n", "v" } },

    -- lsp
    { "<leader>fd", function() Snacks.picker.diagnostics_buffer({layout = "ivy"}) end, desc = "Buffer Diagnostics" },
    { "<leader>fD", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
    { "<leader>cs", function() Snacks.picker.lsp_symbols({layout = "right"}) end, desc = "LSP Symbols" },
    { "<leader>cS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
    { "gr", function() Snacks.picker.lsp_references({layout = "ivy"}) end, nowait = true, desc = "References" },
    { "<leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename file (lsp aware)" },


    { "<leader>n", function() Snacks.picker.notifications({layout = "ivy"}) end, desc = "Notification History" },
    { "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },

    -- words
    {"]]", function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" },},
    {"[[", function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" },},


    -- Github
    { "<leader>gi", function() Snacks.picker.gh_issue() end, desc = "GitHub Issues (open)" },
    { "<leader>gI", function() Snacks.picker.gh_issue({ state = "all" }) end, desc = "GitHub Issues (all)" },
    { "<leader>gp", function() Snacks.picker.gh_pr() end, desc = "GitHub Pull Requests (open)" },
    { "<leader>gP", function() Snacks.picker.gh_pr({ state = "all" }) end, desc = "GitHub Pull Requests (all)" },
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
