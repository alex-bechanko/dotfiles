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


local catppuccin = require('catppuccin')
catppuccin.setup({
  flavour = 'mocha',
  styles = {
    keywords = { "bold" }
  },
  integrations = {
    cmp = true,
  },
})
vim.cmd.colorscheme('catppuccin')
vim.cmd.highlight({ 'link', 'LspInlayHint', 'Comment', bang = true })

require('nvim-treesitter.configs').setup({
  auto_install = false,
  highlight = {
    enable = true,
  },
  additional_vim_regex_highlighting = false,
})
