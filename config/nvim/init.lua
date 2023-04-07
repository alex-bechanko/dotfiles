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
require('onedark').setup {
  style = 'warmer'
}

require('onedark').load()


-- Show indentation as lines --------------------------------------------------
require('indent_blankline').setup {
  show_current_context = true,
  show_current_context_start = true,
}

-- LSP specific key mappings, only work when an language server is attached
local function on_lsp_attach(_, bufnr)
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { buffer = bufnr, noremap = true, silent = true }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
  vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

end

-- Autocomplete setup ---------------------------------------------------------
local cmp = require'cmp'

cmp.setup({
  snippet = {
    expand = function(args) require('luasnip').lsp_expand(args.body) end
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' }
  }, {
    { name = 'buffer' },
  })
})




-- Lua ------------------------------------------------------------------------
require('lspconfig').sumneko_lua.setup {
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file('', true),
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
}





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

      -- autocomplete and lsp server setup
      local lsp = require('lspconfig')
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      lsp.gopls.setup {
        capabilities = capabilities
      }

    end
  }
)
