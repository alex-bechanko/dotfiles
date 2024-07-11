-- Dotfiles and configurations for my machines.
-- Copyright (C) 2023 Alex Bechanko
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <https://www.gnu.org/licenses/>.

vim.opt_global.completeopt = { 'menu', 'menuone', 'noselect' }

-- make diff mode always open in vertical split
vim.opt_global.diffopt:append({ 'vertical' })

vim.g.mapleader = [[ ]]
vim.g.maplocalleader = [[\]]

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.signcolumn = 'yes'

vim.opt.wrap = false
vim.opt.textwidth = 120


-- highlight matching braces
vim.opt.showmatch = true

vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.opt.ruler = true

vim.opt.incsearch = true

vim.opt.timeout = true
vim.opt.timeoutlen = 500
vim.opt.updatetime = 100

vim.opt.tabstop = 4
vim.opt.softtabstop = -1
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.autoindent = true
vim.opt.smarttab = true

-- enable case-insensitive search
vim.opt.ignorecase = true
-- ... unless if we don't want that and put a capital letter in the search
vim.opt.smartcase = true

-- case insensitive auto completion
vim.opt.wildignorecase = true


-- use visual (not audio) bell
vim.opt.visualbell = true

-- folding
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldtext = ''
vim.opt.foldcolumn = '1'
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 0
vim.opt.foldnestmax = 4
vim.opt.foldenable = true
