return {
  "wojciech-kulik/xcodebuild.nvim",
  cmd = "Xcodebuild",
  dependencies = {
    "ibhagwan/fzf-lua",

    "MunifTanjim/nui.nvim",
    "nvim-treesitter/nvim-treesitter", -- (optional) for Quick tests support (required Swift parser)
  },
  config = function()
    require("xcodebuild").setup({
      -- put some options here or leave it empty to use default settings
    })
  end,
}
