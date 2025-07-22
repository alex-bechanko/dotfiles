return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "folke/which-key.nvim",
  },
  config = function()
    vim.lsp.enable("gopls")
    vim.lsp.enable("lua_ls")
    vim.lsp.enable("nixd")
    vim.lsp.enable("rust_analyzer")

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client then return end

        local wk = require("which-key")
        wk.add({
          { "<Leader>l",  group = "Lsp" },
          { "<Leader>lk", vim.lsp.buf.hover,           desc = "Show symbol info" },
          { "<Leader>lf", vim.lsp.buf.format,          desc = "Format buffer" },
          { "<Leader>ld", vim.lsp.buf.definition,      desc = "Goto definition" },
          { "<Leader>lt", vim.lsp.buf.type_definition, desc = "Goto type definition" },
          { "<Leader>ln", vim.lsp.buf.rename,          desc = "Rename symbol" },
          { "<Leader>lc", vim.lsp.buf.code_action,     desc = "List code actions" },
          { "<Leader>lr", vim.lsp.buf.references,      desc = "List references" },
          { "<Leader>ls", vim.lsp.buf.signature_help,  desc = "Show signature" },
          { "<Leader>li", vim.lsp.buf.implementation,  desc = "List implementations" },
          { "<Leader>lS", vim.lsp.buf.document_symbol, desc = "List symbols" },
          { "<Leader>d",  group = "Diagnostic" },
          { "<Leader>dd", vim.diagnostic.show,         desc = "Show diagnostic" },
          { "<Leader>dn", vim.diagnostic.get_next,     desc = "Next diagnostic" },
          { "<Leader>dp", vim.diagnostic.get_prev,     desc = "Previous diagnostic" },
        })
      end
    })
  end,
}
