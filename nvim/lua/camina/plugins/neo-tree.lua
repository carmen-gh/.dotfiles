local status_ok, neotree = pcall(require, "neo-tree")
if not status_ok then return end

neotree.setup {
  close_if_last_window = true,
  enable_diagnostics = false,
  source_selector = {
    winbar = true,
    content_layout = "center",
  },
  default_component_configs = {
    indent = {
      padding = 0,
    },
  },
  window = {
    width = 40,
    mappings = {
      ["o"] = "open",
    },
  },
  filesystem = {
    follow_current_file = true,
    hijack_netrw_behavior = "open_current",
    use_libuv_file_watcher = true,
  },
  event_handlers = {
    { event = "neo_tree_buffer_enter", handler = function(_) vim.opt_local.signcolumn = "auto" end },
  },
}
