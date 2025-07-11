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
      require('config.fold').default_folding()
      require('quarto').activate()
    end
  })

  local quarto = require('quarto')
  quarto.setup({
    codeRunner = {
      enabled = true,
      default_method = 'molten',
    },
  })

  local runner = require('quarto.runner')
  vim.keymap.set("n", "<localleader>rc", runner.run_cell, { desc = "run cell", silent = true })
  vim.keymap.set("n", "<localleader>ra", runner.run_above, { desc = "run cell and above", silent = true })
  vim.keymap.set("n", "<localleader>rA", runner.run_all, { desc = "run all cells", silent = true })
  vim.keymap.set("n", "<localleader>rl", runner.run_line, { desc = "run line", silent = true })
  vim.keymap.set("v", "<localleader>r", runner.run_range, { desc = "run visual range", silent = true })
  vim.keymap.set("n", "<localleader>RA", function()
    runner.run_all(true)
  end, { desc = "run all cells of all languages", silent = true })
end

return M
