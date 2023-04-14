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


-- Global Options
vim.opt.number     = true
vim.opt.cursorline = true
vim.opt.incsearch  = true
vim.opt.autoindent = true
vim.opt.smarttab   = true
vim.opt.ruler      = true


-- Colorscheme ----------------------------------------------------------------
require('onedark').setup({
  style = 'warmer'
})

require('onedark').load()


-- Show indentation as lines --------------------------------------------------
require('indent_blankline').setup({
  show_current_context = true,
  show_current_context_start = true,
})

-- LSP setup ------------------------------------------------------------------
-- Enable Lua LSP, with neovim api docs and symbols
require('neodev').setup({
  override = function(root_dir, library)
    if string.match(root_dir, 'dotfiles') then
      library.enabled = true
      library.plugins = true
    end
  end,
})

local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(_, bufnr)
  lsp.default_keymaps({ buffer = bufnr })
end)

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
  mapping = {
    ['<Tab>'] = cmp_action.tab_complete(),
    ['<S-Tab>'] = cmp_action.select_prev_or_fallback(),
  },
})

lsp.format_on_save({
  servers = {
    lua_ls = { 'lua' },
    gopls = { 'go' },
  }
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


-- Lua ------------------------------------------------------------------------

vim.api.nvim_create_autocmd(
  "FileType", {
    pattern = "lua",
    callback = function()
      vim.opt.tabstop = 2
      vim.opt.shiftwidth = 2
      vim.opt.expandtab = true
    end
  })

-- Nix ------------------------------------------------------------------------
vim.api.nvim_create_autocmd(
  "FileType",
  {
    pattern = "nix",
    callback = function()
      vim.opt.tabstop = 2
      vim.opt.shiftwidth = 2
      vim.opt.expandtab = true
    end
  })


-- Go -------------------------------------------------------------------------
vim.api.nvim_create_autocmd(
  "FileType",
  {
    pattern = "go",
    callback = function()
      vim.opt.tabstop = 4
      vim.opt.softtabstop = 4
      vim.opt.shiftwidth = 4
      vim.opt.expandtab = false
    end
  }
)
