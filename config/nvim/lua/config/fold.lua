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

function M.default_folding()
  -- use treesitter for folding
  vim.wo.foldmethod = 'expr'
  vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

  -- no fold column
  vim.wo.foldcolumn = '0'

  vim.wo.foldnestmax = 4
  vim.wo.foldenable = true

  -- disable automatic folding when in insert mode
  -- keeping it on means that folds will fold/unfold as you type
  -- which is incredibly irritating
  vim.api.nvim_create_augroup("fold_settings", { clear = true })
  vim.api.nvim_create_autocmd("InsertEnter", {
    group = "fold_settings",
    callback = function()
      vim.b.current_foldmethod = vim.wo.foldmethod
      vim.wo.foldmethod = "manual"
    end
  })
  vim.api.nvim_create_autocmd("InsertLeave", {
    group = "fold_settings",
    callback = function()
      if vim.b.current_foldmethod then
        vim.wo.foldmethod = vim.b.current_foldmethod
        vim.b.current_foldmethod = nil
      end
    end
  })
end

return M
