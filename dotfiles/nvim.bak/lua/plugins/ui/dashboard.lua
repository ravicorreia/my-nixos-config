return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  config = function()
    require("dashboard").setup({
      -- config
      hide = {
        "statusline",
      },
    })
  end,
  dependencies = { { "nvim-tree/nvim-web-devicons" } },
}
