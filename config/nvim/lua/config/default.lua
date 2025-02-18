-- Dotfiles and configurations for my machines.
-- Copyright (C) 2024 Alex Bechanko
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

vim.go.completeopt = 'menu,menuone,noselect'

-- make diff mode always open in vertical split
-- the other options being set are the defaults
-- it's a pain that there isn't a way to append an option 
vim.go.diffopt = 'internal,filler,closeoff,vertical'

vim.g.mapleader = [[ ]]
vim.g.maplocalleader = [[\]]

vim.wo.number = true
vim.wo.relativenumber = true

vim.o.splitright = true
vim.o.splitbelow = true

vim.wo.signcolumn = 'yes'

vim.wo.wrap = false
vim.bo.textwidth = 120
vim.wo.colorcolumn = '-2'

-- highlight matching braces
vim.o.showmatch = true

vim.wo.cursorline = true
vim.o.ruler = true

vim.o.incsearch = true
vim.o.timeout = true
vim.o.timeoutlen = 500
vim.o.updatetime = 100

vim.bo.tabstop = 4
vim.bo.softtabstop = -1
vim.bo.shiftwidth = 4
vim.bo.expandtab = true

vim.bo.autoindent = true
vim.o.smarttab = true

-- enable case-insensitive search
vim.o.ignorecase = true
-- ... unless if we don't want that and put a capital letter in the search
vim.o.smartcase = true

-- case insensitive auto completion
vim.o.wildignorecase = true


-- use visual (not audio) bell
vim.o.visualbell = true
