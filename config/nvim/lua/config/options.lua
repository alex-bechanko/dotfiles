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

local opt = vim.opt
local opt_global = vim.opt_global


vim.g.mapleader = [[ ]]
vim.g.maplocalleader = [[\]]

opt.number = true
opt.relativenumber = true

opt.splitright = true
opt.splitbelow = true

opt.signcolumn = 'yes'

opt_global.completeopt = { 'menu', 'menuone', 'noselect' }

opt.wrap = false
opt.textwidth = 120


-- highlight matching braces
opt.showmatch = true

opt.cursorline = true
opt.cursorcolumn = true
opt.ruler = true

opt.incsearch = true

opt.timeout = true
opt.timeoutlen = 300

opt.tabstop = 4
opt.softtabstop = -1
opt.shiftwidth = 4
opt.expandtab = true

opt.autoindent = true
opt.smarttab = true

-- enable case-insensitive search
opt.ignorecase = true
-- ... unless if we don't want that and put a capital letter in the search
opt.smartcase = true

-- case insensitive auto completion
opt.wildignorecase = true

-- make diff mode always open in vertical split
opt_global.diffopt:append({ 'vertical' })

-- use visual (not audio) bell
opt.visualbell = true

-- use treesitter for folds
opt.foldmethod = 'expr'
opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
-- dont fold everything at start
opt.foldenable = false
opt.foldminlines = 5

opt.timeoutlen = 500
opt.updatetime = 100
