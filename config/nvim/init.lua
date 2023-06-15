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


-- Global and Filetype options ------------------------------------------------
require('options').setup()

-- Colorscheme ----------------------------------------------------------------
require('colorscheme').setup()

-- Plugins --------------------------------------------------------------------
require('plugins').setup()

-- Enable LSP autocomplete with Go and Lua ------------------------------------

local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(_, bufnr)
  lsp.default_keymaps({ buffer = bufnr })
end)

lsp.format_on_save({
  servers = {
    lua_ls = { 'lua' },
    gopls = { 'go' },
    elmls = { 'elm' },
  },
})

local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()
lspconfig.lua_ls.setup(lsp.nvim_lua_ls())
lspconfig.gopls.setup({
  capabilities = capabilities,
})
lspconfig.golangci_lint_ls.setup({
  capabilities = capabilities,
})
lspconfig.elmls.setup({
  capabilities = capabilities,
})


lsp.setup()

local cmp_action = require('lsp-zero').cmp_action()
local cmp = require('cmp')
cmp.setup({
  mapping = {
    -- ['<Tab>'] = cmp_action.tab_complete(),
    -- ['<S-Tab>'] = cmp_action.select_prev_or_fallback(),
    -- ['<CR>'] = cmp.mapping.confirm({ select = false }),
    ['<Tab>'] = cmp_action.luasnip_supertab(),
    ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
  },
})
