return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    animate = { enabled = false },
    bigfile = { enabled = true },
    bufdelete = { enabled = false },
    explorer = { enabled = true },
    image = { enabled = true },
    indent = { enabled = false }, -- TODO
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
    styles = { notification = { wo = { wrap = true } } },
  },
  keys = {
    -- stylua: ignore start
    { "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
    { "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffers" },
    { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep" },
    { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
    { "<leader>fg", function() Snacks.picker.git_status() end, desc = "Find Git Files" },
    { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },
    { "<leader>gb", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
    -- {"<leader>lg", function() Snacks.lazygit() end, desc = "Lazygit",},
    -- {"<leader>gl", function() Snacks.git.blame_line() end, desc = "Git Blame Line",},
    -- {"<leader>gB", function() Snacks.gitbrowse() end, desc = "Open Git Browser",},
    -- {"<leader>gh", function() Snacks.lazygit.log_file() end, desc = "Lazygit Current File History",},
    -- {"<leader>gL", function() Snacks.lazygit.log() end, desc = "Lazygit Log (cwd)",},
    -- {"<leader>cR", function() Snacks.rename() end, desc = "Rename File",},
    { "<leader>n", function() Snacks.picker.notifications() end, desc = "Notification History" },
    { "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },
    -- {"<leader>fn", function() Snacks.notifier.show_history() end, desc ="notifications",},
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
