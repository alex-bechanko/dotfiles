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
local M = {}

function M.setup(language_modules)
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)

      if not client then return end

      for _, module in pairs(language_modules) do
        if module.lsp and module.lsp == client.name then
          module.lsp_attach(args)
        end
      end
    end
  })
end

function M.default_lsp_attach(args)
  local set = vim.keymap.set
  -- local client = vim.lsp.get_client_by_id(args.data.client_id)
  local buffer = args.buf

  set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostics' })
  set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Goto previous diagnostic' })
  set('n', ']d', vim.diagnostic.goto_next, { desc = 'Goto next diagnostic' })
  set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Add position to diagnostics' })

  set('n', 'K', vim.lsp.buf.hover, { buffer = buffer, desc = 'Display information about symbol under cursor' })
  set('n', 'gd', vim.lsp.buf.definition,
    { buffer = buffer, desc = 'Jump to definition of symbol under cursor' })
  set('n', 'gD', vim.lsp.buf.declaration,
    { buffer = buffer, desc = 'Jump to declaration of symbol under cursor' })
  set('n', 'gi', vim.lsp.buf.implementation,
    { buffer = buffer, desc = 'List implementations of symbol under cursor' })
  set('n', 'go', vim.lsp.buf.type_definition,
    { buffer = buffer, desc = 'Jump to type definition of symbol under cursor' })
  set('n', 'gr', vim.lsp.buf.references, { buffer = buffer, desc = 'List references to symbol under cursor' })
  set('n', 'gs', vim.lsp.buf.signature_help,
    { buffer = buffer, desc = 'Show signature for symbol under cursor' })
  set('n', 'gl', vim.diagnostic.open_float, { buffer = buffer, desc = 'Show diagnostics' })
  set('n', '[d', vim.diagnostic.goto_prev, { buffer = buffer, desc = 'Goto previous diagnostic' })
  set('n', ']d', vim.diagnostic.goto_next, { buffer = buffer, desc = 'Goto next diagnostic' })

  local format = function() vim.lsp.buf.format({ async = true }) end

  set('n', '<F2>', vim.lsp.buf.rename, { buffer = buffer, desc = 'Rename references to symbol under cursor' })
  set('n', '<F3>', format, { buffer = buffer, desc = 'Format buffer/selection with attached LSPs' })
  set('x', '<F3>', format, { buffer = buffer, desc = 'Format buffer/selection with attached LSPs' })
  set('n', '<F4>', vim.lsp.buf.code_action, { buffer = buffer, desc = 'Select code action at cursor position' })
  set('x', '<F4>', vim.lsp.buf.code_action, { buffer = buffer, desc = 'Select code action at cursor position' })
end

return M
