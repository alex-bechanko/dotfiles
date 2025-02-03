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
    pattern = { 'lua' },
    callback = function()
      vim.opt_local.tabstop = 2
      vim.opt_local.softtabstop = -1
      vim.opt_local.shiftwidth = 2
      vim.opt_local.expandtab = true

      require('config.fold').enable_folding()
    end
  })

  -- lsp configuration to show neovim symbols
  local lspconfig = require('lspconfig')
  lspconfig.lua_ls.setup({
    on_init = function(client)
      local path = client.workspace_folders[1].name
      if vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then
        return
      end

      client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
        runtime = {
          version = 'LuaJIT'
        },
        workspace = {
          checkThirdParty = false,
          library = {
            vim.env.VIMRUNTIME
          }
        }
      })
    end,
    settings = {
      Lua = {}
    }
  })
end

M.lsp_attach = require('config.lsp').default_lsp_attach
M.lsp = 'lua_ls'

return M
