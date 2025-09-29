return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      code = {
        sign = false,
        width = "block",
        right_pad = 1,
      },
      heading = {
        sign = false,
        icons = {},
      },
      render_modes = { "n", "c", "t" },
    },
    ft = { "markdown", "norg", "rmd", "org", "livebook" },
  },
}
