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

local set = vim.keymap.set

local M = {}

M.global = function()
    set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostics' })
    set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Goto previous diagnostic' })
    set('n', ']d', vim.diagnostic.goto_next, { desc = 'Goto next diagnostic' })
    set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Add position to diagnostics' })
end

M.on_lsp_attach = function(_, b)
    set('n', 'K', vim.lsp.buf.hover, { buffer = b, desc = 'Display information about symbol under cursor' })
    set('n', 'gd', vim.lsp.buf.definition, { buffer = b, desc = 'Jump to definition of symbol under cursor' })
    set('n', 'gD', vim.lsp.buf.declaration, { buffer = b, desc = 'Jump to declaration of symbol under cursor' })
    set('n', 'gi', vim.lsp.buf.implementation, { buffer = b, desc = 'List implementations of symbol under cursor' })
    set('n', 'go', vim.lsp.buf.type_definition, { buffer = b, desc = 'Jump to type definition of symbol under cursor' })
    set('n', 'gr', vim.lsp.buf.references, { buffer = b, desc = 'List references to symbol under cursor' })
    set('n', 'gs', vim.lsp.buf.signature_help, { buffer = b, desc = 'Show signature for symbol under cursor' })
    set('n', 'gl', vim.diagnostic.open_float, { buffer = b, desc = 'Show diagnostics' })
    set('n', '[d', vim.diagnostic.goto_prev, { buffer = b, desc = 'Goto previous diagnostic' })
    set('n', ']d', vim.diagnostic.goto_next, { buffer = b, desc = 'Goto next diagnostic' })

    local format = function() vim.lsp.buf.format({ async = true }) end

    set('n', '<F2>', vim.lsp.buf.rename, { buffer = b, desc = 'Rename references to symbol under cursor' })
    set('n', '<F3>', format, { buffer = b, desc = 'Format buffer/selection with attached LSPs' })
    set('x', '<F3>', format, { buffer = b, desc = 'Format buffer/selection with attached LSPs' })
    set('n', '<F4>', vim.lsp.buf.code_action, { buffer = b, desc = 'Select code action at cursor position' })
    set('x', '<F4>', vim.lsp.buf.code_action, { buffer = b, desc = 'Select code action at cursor position' })
end

return M
