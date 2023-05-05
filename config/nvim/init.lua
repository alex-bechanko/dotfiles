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
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.incsearch = true
vim.opt.autoindent = true
vim.opt.smarttab = true
vim.opt.ruler = true

local function filetype_go()
  vim.opt.tabstop = 4
  vim.opt.softtabstop = 4
  vim.opt.shiftwidth = 4
  vim.opt.expandtab = true
end

local function filetype_lua()
  vim.opt.tabstop = 2
  vim.opt.shiftwidth = 2
  vim.opt.expandtab = true
end

local function filetype_nix()
  vim.opt.tabstop = 2
  vim.opt.shiftwidth = 2
  vim.opt.expandtab = true
end


vim.api.nvim_create_autocmd('Filetype', { callback = filetype_go })
vim.api.nvim_create_autocmd('Filetype', { callback = filetype_lua })
vim.api.nvim_create_autocmd('Filetype', { callback = filetype_nix })

-- Colorscheme ----------------------------------------------------------------
local color = require('onedark')
color.setup({
  style = 'warmer'

})
color.load()


-- Show indentation as lines --------------------------------------------------
require('indent_blankline').setup({
  show_current_context = true,
  show_current_context_start = true,
})


-- Enable neovim configuraiton development ------------------------------------
require('neodev').setup({
  override = function(root_dir, library)
    if string.match(root_dir, 'dotfiles') then
      library.enabled = true
      library.plugins = true
    end
  end
})


-- Enable LSP autocomplete with Go and Lua ------------------------------------

local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(_, bufnr)
  lsp.default_keymaps({ buffer = bufnr })
end)

lsp.format_on_save({
  servers = {
    lua_ls = { 'lua' },
    gopls = { 'go' },
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
