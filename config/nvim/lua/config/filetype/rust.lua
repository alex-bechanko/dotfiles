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
  local lspconfig = require('lspconfig')
  lspconfig.rust_analyzer.setup({
    settings = {
      ['rust-analyzer'] = {
        diagnostics = {
          enable = false,
        },
        checkOnSave = {
          allFeatures = true,
          command = "clippy",
          extraArgs = {
            "--",
            "--no-deps",
            "-Dclippy::correctness",
            "-Dclippy::complexity",
            "-Wclippy::perf",
            "-Wclippy::pedantic",
          },
        },
      },
    },
  })

  vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'rust' },
    callback = function()
      require('config.fold').default_folding()
    end
  })
end

M.lsp_attach = require('config.lsp').default_lsp_attach
M.lsp = 'rust_analyzer'

return M
