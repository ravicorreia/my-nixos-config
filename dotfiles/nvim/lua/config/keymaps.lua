-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Exit insert mode pressing 'jj'
keymap.set("i", "jj", "<ESC>")

-- Use H and L to go to beggining/end of the line
keymap.set("o", "H", "^", opts)
keymap.set("o", "L", "$", opts)
