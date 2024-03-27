vim.g.mapleader = " "

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = false }

-- Indenting
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)
map("n", "<", "<gv", opts)
map("n", ">", ">gv", opts)

-- Copy-Pasting
map("v", "<C-c>", '"+y', opts)
map("n", "<C-s>", '"+P', opts)

-- Remapping Escape key
map("i", "jk", "<Esc>", opts)
map("n", "jk", "<Esc>", opts)
map("v", "jk", "<Esc>", opts)

-- Unhighlight searched elements
map("n", "<CR>", ":nohlsearch<CR>", opts)

-- Exchange colon and semi-colon
map("n", ";", ":", opts)
map("n", ":", ";", opts)

-- Beginning / end of line using L and H
map('n', 'L', '$', opts);
map('n', 'H', '0', opts);

-- Save file with Ctrl + s
map("n", "<C-s>", ":w<CR>", opts)
map("i", "<C-s>", "<ESC> :w<CR>", opts)

-- Don't yank on char delete (x)
map("n", "x", '"_x', opts)
map("n", "X", '"_X', opts)
map("v", "x", '"_x', opts)
map("v", "X", '"_X', opts)

-- Sensible clipboard paste in insert mode
map('i', '<C-v>', '<C-r>*', opts)

-- Center jumping to next/prev match
map("n", "n", "nzz", opts)
map("n", "N", "Nzz", opts)

-- Move selected lines with shift+j or shift+k
map("v", "J", ":m '>+1<CR>gv=gv", opts)
map("v", "K", ":m '<-2<CR>gv=gv", opts)

-- Join line while keeping the cursor in the same position
map("n", "J", "mzJ`z", opts)

-- Keep cursor centred while scrolling up and down
map("n", "<C-d>", "<C-d>zz", opts)
map("n", "<C-u>", "<C-u>zz", opts)

-- Next and previous instance of the highlighted letter
map("n", "n", "nzzzv", opts)
map("n", "N", "Nzzzv", opts)

-- Better paste (prevents new paste buffer)
map("x", "<leader>p", [["_dP]], opts)