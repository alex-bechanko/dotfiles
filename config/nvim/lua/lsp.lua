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

local language_servers = {
  servers = {
    lua_ls = {
      format_on_save = { 'lua' },
      options = {
        telemetry = { enable = false },
        runtime = {
          runtime = 'LuaJIT',
          path = vim.list_extend(
            vim.split(package.path, ';', {}),
            { 'lua/?.lua', 'lua/?/init.lua' },
            1, -- start index
            2  -- end index
          ),
        },
        diagnostics = {
          globals = { 'vim' },
        },
        workspace = {
          checkThirdParty = false,
          library = {
            vim.fn.expand('$VIMRUNTIME/lua'),
            vim.fn.stdpath('config') .. '/lua'
          },
        },
      },
    },
    gopls = {
      format_on_save = { 'go' },
    },
  },
  all = {
    capabilities = {
      textDocument = {
        completion = {
          dynamicRegistration = false,
          completionItem = {
            snippetSupport = true,
            commitCharactersSupport = true,
            deprecatedSupport = true,
            preselectSupport = true,
            tagSupport = {
              valueSet = {
                1, -- Deprecated
              }
            },
            insertReplaceSupport = true,
            resolveSupport = {
              properties = {
                "documentation",
                "detail",
                "additionalTextEdits",
              },
            },
            insertTextModeSupport = {
              valueSet = {
                1, -- asIs
                2, -- adjustIndentation
              }
            },
            labelDetailsSupport = true,
          },
          contextSupport = true,
          insertTextMode = 1,
          completionList = {
            itemDefaults = {
              'commitCharacters',
              'editRange',
              'insertTextFormat',
              'insertTextMode',
              'data',
            }
          },
        },
      },
    }
  },
}

local function apply_language_servers(servers)
  local lsp = require('lspconfig')

  -- language server setup
  for server_name, server in pairs(servers.servers) do
    local opts = vim.tbl_deep_extend('force', {}, servers.all, server.options)
    lsp[server_name].setup(opts)
  end

  -- format on save setup



  lsp.setup()
end
