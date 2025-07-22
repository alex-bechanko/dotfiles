return {
  "olimorris/codecompanion.nvim",
  opts = {
    strategies = {
      adapter = "gemini",
    },
    inline = {
      adapter = "gemini",
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
}
