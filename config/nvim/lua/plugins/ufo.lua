return {
  "kevinhwang91/nvim-ufo",
  dependencies = {
    "kevinhwang91/promise-async",
  },
  opts = {
    provider_selector = function()
      return { "treesitter", "indent" }
    end
  },
  event = "BufRead",
  keys = {
    { "zR", function() require("ufo").openAllFolds() end,   desc = "Open all folds (ufo)" },
    { "zM", function() require("ufo").closeAllFolds() end,  desc = "Close all folds (ufo)" },
  },
}
