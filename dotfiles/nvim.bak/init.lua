vim.g.mapleader = ";"
vim.g.maplocalleader = ";"

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.termguicolors = true

vim.opt.fillchars = {
  eob = " ", -- Substitui o `~` por um espaço em branco
}

vim.opt.mouse = "a"

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Configure how new splits should be opened
-- vim.opt.splitright = true
-- vim.opt.splitbelow = true
--
-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- vim.opt.shiftwidth = 2
vim.opt.clipboard = "unnamedplus"

-- Hightligh when yanking (copying) text Try it with 'yap' in normal mode
-- See ':help vim.highlight.on_yank()'
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Keybinds
vim.keymap.set("n", ";x", "<cmd>source %<CR>")

-- vim.keymap.set("n", ";x", ":.lua<CR>")

vim.keymap.set("v", ";x", ":lua<CR>")

vim.keymap.set("n", "<M-j>", "<cmd>cnext<CR>")

vim.keymap.set("n", "<M-k>", "<cmd>cprev<CR>")

vim.keymap.set("n", ";st", function()
  vim.cmd("bel vnew")
  vim.cmd.term()
  vim.api.nvim_win_set_width(0, 42)
end)

vim.keymap.set("n", "grn", vim.lsp.buf.rename)

vim.keymap.set("n", "gra", vim.lsp.buf.code_action)

vim.keymap.set("n", "grr", vim.lsp.buf.references, { desc = "references" })

vim.keymap.set("n", "-", "<cmd>Oil<CR>")

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

require("config.lazy")

-------------------------------------------------------------------------------

require("notify")("Hello Ravi! Happy Coding!")
-- print("Advent of Neovim")

-- Define the function
MyCoolFunction = function()
  print("Hello Ravi, Welcome to Advent of Neovim")
end

-- Call the function
MyCoolFunction()
