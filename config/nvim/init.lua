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

-- includes/libraries
local catppuccin = require('catppuccin')
local indent_blankline = require('indent_blankline')
local neodev = require('neodev')
local whichkey = require('which-key')
local lspzero = require('lsp-zero')
local lspconfig = require('lspconfig')
local cmp_nvim_lsp = require('cmp_nvim_lsp')
local rust_tools = require('rust-tools')

-- Global and Filetype options ------------------------------------------------
-- global options
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.incsearch = true
vim.opt.autoindent = true
vim.opt.smarttab = true
vim.opt.ruler = true
vim.opt.timeout = true
vim.opt.timeoutlen = 300

-- I like either 4 spaces or 2 spaces for tabbing
-- in a language. These two functions are used to give languages
-- one of these two configurations.
local four = function()
  vim.opt.tabstop = 4
  vim.opt.softtabstop = 4
  vim.opt.shiftwidth = 4
  vim.opt.expandtab = true
end

local two = function()
  vim.opt.tabstop = 2
  vim.opt.softtabstop = 2
  vim.opt.shiftwidth = 2
  vim.opt.expandtab = true
end


-- language specific options
vim.api.nvim_create_autocmd('Filetype', { pattern = 'go', callback = four })
vim.api.nvim_create_autocmd('Filetype', { pattern = 'lua', callback = two })
vim.api.nvim_create_autocmd('Filetype', { pattern = 'nix', callback = two })
vim.api.nvim_create_autocmd('Filetype', { pattern = 'elm', callback = four })
vim.api.nvim_create_autocmd('Filetype', { pattern = 'rust', callback = two })
vim.api.nvim_create_autocmd('Filetype', { pattern = 'dhall', callback = two })

vim.api.nvim_create_autocmd('Filetype', {
  pattern = 'rust',
  callback = function()
    vim.opt.tabstop = 4
    vim.opt.softtabstop = 4
    vim.opt.shiftwidth = 4
    vim.opt.expandtab = true
    rust_tools.inlay_hints.set()
  end
})

-- Colorscheme ----------------------------------------------------------------
catppuccin.setup({
  flavour = 'mocha',
  styles = {
    keywords = { "bold" }
  }
})
vim.cmd.colorscheme('catppuccin')

-- Plugins --------------------------------------------------------------------
indent_blankline.setup({
  show_current_context = true,
  show_current_context_start = true,
})

neodev.setup({
  override = function(root_dir, library)
    if string.match(root_dir, 'dotfiles') then
      library.enabled = true
      library.plugins = true
    end
  end,
})

rust_tools.setup()

whichkey.setup({})

-- Enable LSP autocomplete with Go, Lua, and Elm ------------------------------------
local lsp = lspzero.preset({})

lsp.on_attach(function(_, bufnr)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover,
    { buffer = bufnr, desc = 'Display information about symbol under cursor' })
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition,
    { buffer = bufnr, desc = 'Jump to definition of symbol under cursor' })
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration,
    { buffer = bufnr, desc = 'Jump to declaration of symbol under cursor' })
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation,
    { buffer = bufnr, desc = 'List implementations of symbol under cursor' })
  vim.keymap.set('n', 'go', vim.lsp.buf.type_definition,
    { buffer = bufnr, desc = 'Jump to type definition of symbol under cursor' })
  vim.keymap.set('n', 'gr', vim.lsp.buf.references,
    { buffer = bufnr, desc = 'List references to symbol under cursor' })
  vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help,
    { buffer = bufnr, desc = 'Show signature for symbol under cursor' })
  vim.keymap.set('n', 'gl', vim.diagnostic.open_float,
    { buffer = bufnr, desc = 'Show diagnostics' })
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev,
    { buffer = bufnr, desc = 'Goto previous diagnostic' })
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next,
    { buffer = bufnr, desc = 'Goto next diagnostic' })

  vim.keymap.set('n', '<F2>', vim.lsp.buf.rename,
    { buffer = bufnr, desc = 'Rename references to symbol under cursor' })
  vim.keymap.set({ 'n', 'x' }, '<F2>', function() vim.lsp.buf.format({ async = true }) end,
    { buffer = bufnr, desc = 'Format buffer/selection with attached LSPs' })
  vim.keymap.set('n', '<F4>', vim.lsp.buf.code_action,
    { buffer = bufnr, desc = 'Select code action at cursor position' })
  vim.keymap.set('n', '<F4>', vim.lsp.buf.range_code_action,
    { buffer = bufnr, desc = 'Select code action at cursor position' })
end)

lsp.setup_servers({ 'gopls', 'elmls', 'dhall_lsp_server', 'golangci_lint_ls', 'lua_ls' })

lsp.format_on_save({
  servers = {
    lua_ls = { 'lua' },
    gopls = { 'go' },
    elmls = { 'elm' },
    dhall_lsp_server = { 'dhall' },
  },
})

local capabilities = cmp_nvim_lsp.default_capabilities()
lspconfig.lua_ls.setup(lsp.nvim_lua_ls())
lspconfig.gopls.setup({ capabilities = capabilities })
lspconfig.golangci_lint_ls.setup({ capabilities = capabilities })
lspconfig.elmls.setup({ capabilities = capabilities })

lspconfig.dhall_lsp_server.setup({
  settings = {
    dhall_lsp_server = {
      ["character-set"] = "ascii"
    }
  }
})

lsp.setup()
