return {
  "craftzdog/solarized-osaka.nvim",
  enabled = false,
  lazy = false,
  priority = 1000,
  opts = { transparent = true },
  config = function()
    vim.cmd.colorscheme("solarized-osaka")
  end,
}
