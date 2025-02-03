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
    pattern = { 'nix' },
    callback = function()
      vim.opt_local.tabstop = 2
      vim.opt_local.softtabstop = -1
      vim.opt_local.shiftwidth = 2
      vim.opt_local.expandtab = true

      -- enable folding and use treesitter for folding
      vim.opt_local.foldmethod = 'expr'
      vim.opt_local.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      vim.opt_local.foldtext = ''
      vim.opt_local.foldcolumn = '1'
      vim.opt_local.foldlevel = 99
      vim.opt_local.foldlevelstart = 0
      vim.opt_local.foldnestmax = 4
      vim.opt_local.foldenable = true
    end
  })

  local lspconfig = require('lspconfig')
  lspconfig.nil_ls.setup({})
end

M.lsp_attach = require('config.lsp').default_lsp_attach
M.lsp = 'nil_ls'

return M
