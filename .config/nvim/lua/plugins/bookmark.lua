return {
  {
    "cbochs/grapple.nvim",
    dependencies = {
      { "nvim-tree/nvim-web-devicons", lazy = true },
    },
    opts = {
      scope = "git",
    },
    event = { "BufReadPost", "BufNewFile" },
    cmd = "Grapple",
    keys = {
      { "<leader>m", "<cmd>Grapple toggle<cr>", desc = "toggle mark" },
      { "<leader>M", "<cmd>Grapple toggle_tags<cr>", desc = "open marks window" },
      { "<leader>1", "<cmd>Grapple select index=1<cr>", desc = "Select first mark" },
      { "<leader>2", "<cmd>Grapple select index=2<cr>", desc = "Select second mark" },
      { "<leader>3", "<cmd>Grapple select index=3<cr>", desc = "Select third mark" },
      { "<leader>4", "<cmd>Grapple select index=4<cr>", desc = "Select fourth mark" },
    },
  },
}
