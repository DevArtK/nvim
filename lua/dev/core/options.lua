-- Backspace key
vim.o.backspace = "indent,eol,start"


-- Appearance
vim.opt.termguicolors = true
vim.o.pumheight = 10   -- Max items to show in pop up menu
vim.o.cmdheight = 1    -- Max items to show in command menu
vim.o.conceallevel = 0 -- For markdown like elements


-- Files and Others
vim.o.fileencoding = "utf-8" -- File Encoding
vim.cmd("filetype plugin indent on")
vim.g.loaded_netrw = 1       -- Helps opening links in the internet (probabilly -_-)
vim.g.loaded_netrwPlugin = 1
vim.opt.autochdir = true
vim.o.shortmess = vim.o.shortmess .. "c"
vim.o.hidden = true
vim.o.whichwrap = "b,s,<,>,[,],h,l"
vim.opt.iskeyword:append("-,_")
vim.opt.virtualedit = "block"

-- Wrapping / Line Numbs / Columns / Cursor
vim.wo.wrap = false
vim.wo.number = true
vim.wo.relativenumber = true
vim.o.cursorline = true
vim.o.cursorcolumn = false
vim.wo.signcolumn = "yes"


-- Tabs and indentations
local indent = 4
vim.o.tabstop = indent
vim.bo.tabstop = indent
vim.o.showtabline = indent
vim.o.softtabstop = indent
vim.o.shiftwidth = indent
vim.bo.shiftwidth = indent

vim.o.smartindent = true
vim.bo.smartindent = true
vim.o.autoindent = true
vim.bo.autoindent = true
vim.o.expandtab = true
vim.bo.expandtab = true

vim.opt.smartindent = true


-- Search
vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true


-- Mouse and Scrolling
vim.o.scrolloff = 5
vim.o.sidescrolloff = 5
vim.o.mouse = "a"


vim.api.nvim_set_hl(0, "Normal", { bg = "#eba0ac" })

-- Options based on filetypes
-- markdown
vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
        vim.opt.wrap = true
        vim.opt.linebreak = true
    end,
})

-- keep cursor unchanged after quiting
vim.api.nvim_create_autocmd("ExitPre", {
    group = vim.api.nvim_create_augroup("Exit", { clear = true }),
    command = "set guicursor=a:ver90",
    desc = "Set cursor back to beam when leaving Neovim.",
})

require("kanagawa").load("dragon")
