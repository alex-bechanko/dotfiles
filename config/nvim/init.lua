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

local catppuccin = require('catppuccin')
local nvim_treesitter_configs = require('nvim-treesitter.configs')
local cmp = require('cmp')
local luasnip = require('luasnip')
local mini_indentscope = require('mini.indentscope')
local codecompanion = require('codecompanion')
local ufo = require('ufo')


-- colorscheme
catppuccin.setup({
  flavour = 'mocha',
  styles = {
    keywords = { 'bold' }
  },
  integrations = {
    cmp = true,
  },
})
vim.cmd.colorscheme('catppuccin')

nvim_treesitter_configs.setup({
  auto_install = false,
  highlight = {
    enable = true,
  },
  additional_vim_regex_highlighting = false,
})

vim.go.completeopt = 'menu,menuone,noselect'

-- markers to show indentation levels
mini_indentscope.setup()

-- make diff mode always open in vertical split
-- the other options being set are the defaults
-- it's a pain that there isn't a way to append an option
vim.go.diffopt = 'internal,filler,closeoff,vertical'

vim.g.mapleader = [[ ]]
vim.g.maplocalleader = [[\]]

vim.wo.number = true
vim.wo.relativenumber = true

vim.o.splitright = true
vim.o.splitbelow = true

vim.wo.signcolumn = 'yes'

vim.wo.wrap = false
vim.bo.textwidth = 120
vim.wo.colorcolumn = '-2'

-- highlight matching braces
vim.o.showmatch = true

vim.wo.cursorline = true
vim.o.ruler = true

vim.o.incsearch = true
vim.o.timeout = true
vim.o.timeoutlen = 500
vim.o.updatetime = 100

vim.bo.tabstop = 4
vim.bo.softtabstop = -1
vim.bo.shiftwidth = 4
vim.bo.expandtab = true

vim.bo.autoindent = true
vim.o.smarttab = true

-- enable case-insensitive search
vim.o.ignorecase = true
-- ... unless if we don't want that and put a capital letter in the search
vim.o.smartcase = true

-- case insensitive auto completion
vim.o.wildignorecase = true


-- use visual (not audio) bell
vim.o.visualbell = true

-- enable project specific .nvim.lua
vim.o.exrc = true

vim.o.foldcolumn = '0'
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

vim.keymap.set('n', 'zR', ufo.openAllFolds)
vim.keymap.set('n', 'zM', ufo.closeAllFolds)

ufo.setup({
  provider_selector = function()
    return { 'treesitter', 'indent' }
  end
})


-- LSP
vim.lsp.enable('dhall_lsp_server')
vim.lsp.enable('gopls')
vim.lsp.enable('lua_ls')
vim.lsp.enable('nixd')
vim.lsp.enable('rust-analyzer')

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then return end

    vim.keymap.set('n', 'grf', vim.lsp.buf.format, { buffer = args.buf, desc = 'vim.lsp.buf.format' })
  end
})

-- AUTOCOMPLETE
cmp.setup({
  snippet = {
    expand = function(args) luasnip.lsp_expand(args.body) end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping(function(fallback)
      if cmp.visible() and luasnip.expandable() then
        luasnip.expand()
      elseif cmp.visible() then
        cmp.confirm({ select = true })
      else
        fallback()
      end
    end),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.locally_jumpable() then
        luasnip.jump(1)
      else
        fallback()
      end
    end),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end)
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, { { name = 'buffer' } }),
})


-- AI
codecompanion.setup({
  strategies = {
    chat = {
      adapter = "gemini",
    },
    inline = {
      adapter = "gemini"
    },
  },
})
