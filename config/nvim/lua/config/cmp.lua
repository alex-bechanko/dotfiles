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

local cmp = require('cmp')

local keymaps = require('config.keymaps')

cmp.setup({
    snippet = {
        expand = function(args) require('luasnip').lsp_expand(args.body) end,
    },
    mapping = keymaps.cmp.mapping(),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    }, { { name = 'buffer' } }),
})
