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

local mappings = {
  -- these are applied when a language server attaches to the buffer
  lsp = {
    { keys = 'K',    mode = 'n',          action = vim.lsp.buf.hover },
    { keys = 'gd',   mode = 'n',          action = vim.lsp.buf.definition },
    { keys = 'gD',   mode = 'n',          action = vim.lsp.buf.declaration },
    { keys = 'gi',   mode = 'n',          action = vim.lsp.buf.implementation },
    { keys = 'go',   mode = 'n',          action = vim.lsp.buf.type_definition },
    { keys = 'gr',   mode = 'n',          action = vim.lsp.buf.references },
    { keys = 'gs',   mode = 'n',          action = vim.lsp.buf.signature_help },
    { keys = '<F2>', mode = 'n',          action = vim.lsp.buf.rename },
    { keys = '<F3>', mode = { 'n', 'x' }, action = vim.lsp.buf.format,           args = { async = true } },
    { keys = '<F4>', mode = 'n',          action = vim.lsp.buf.code_action },
    { keys = '<F4>', mode = 'x',          action = vim.lsp.buf.range_code_action },
    { keys = 'gl',   mode = 'n',          action = vim.diagnostic.open_float },
    { keys = '[d',   mode = 'n',          action = vim.diagnostic.goto_prev },
    { keys = ']d',   mode = 'n',          action = vim.diagnostic.goto_next },

  },
  cmp = {

  },
}
