return {
  "craftzdog/solarized-osaka.nvim",
  enabled = true,
  -- enabled = false,
  lazy = false,
  priority = 1000,
  opts = { transparent = false },
  config = function()
    vim.cmd.colorscheme "solarized-osaka"
  end
}
