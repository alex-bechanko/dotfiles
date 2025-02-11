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

function M.setup()
  vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'markdown' },
    callback = function()
      vim.b.wiki_path = '/home/alex/Documents/notes'

      vim.keymap.set('n', '<leader>fwf', function ()
      end, { desc = "List Wiki Files by name" })

      vim.keymap.set('n', '<leader>fwg', function()
      end, { desc = 'List Wiki Headers' })
    end
  })
end

return M
