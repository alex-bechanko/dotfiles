
-- Plugins
--require('packer').startup(function(use)

    -- package management
--    use 'wbthomason/packer.nvim'

    -- defaults
--    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
--    use 'tpope/vim-fugitive'
--    use {
--      'nvim-telescope/telescope.nvim', tag = '0.1.1',
--      requires = { {'nvim-lua/plenary.nvim'} }
--    }

    -- colorschemes
--    use 'marko-cerovac/material.nvim'
--   use 'folke/tokyonight.nvim'

--end)

-- Global Options
vim.opt.number     = true
vim.opt.cursorline = true
vim.opt.incsearch  = true
vim.opt.autoindent = true
vim.opt.smarttab   = true
vim.opt.ruler      = true

-- Colorscheme
require('onedark').setup {
  style = 'warmer'
}

require('onedark').load()


-- indent lines
require('indent_blankline').setup {
  show_current_context = true,
  show_current_context_start = true,
}

-- Lua
vim.api.nvim_create_autocmd(
  "FileType",
  { pattern = "lua",
    callback = function()
      vim.opt.tabstop = 2
      vim.opt.shiftwidth = 2
      vim.opt.expandtab = true
    end
})

-- Nix
vim.api.nvim_create_autocmd(
  "FileType",
  { pattern = "nix",
    callback = function()
      vim.opt.tabstop = 2
      vim.opt.shiftwidth = 2
      vim.opt.expandtab = true
    end
})


-- Go
vim.api.nvim_create_autocmd(
  "FileType",
  {
    pattern = "go",
    callback = function()
      vim.opt.tabstop = 4
      vim.opt.softtabstop = 4
      vim.opt.shiftwidth = 4
      vim.opt.expandtab = false

      require('go').setup()
    end
  }
)

-- Autoformat go files on save
local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
   require('go.format').goimport()
  end,
  group = format_sync_grp,
})
