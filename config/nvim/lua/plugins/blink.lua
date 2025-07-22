return {
  "saghen/blink.cmp",
  version = "1.*",
  opts = {
    keymap = { preset = "super-tab" },
    appearance = {
      nerd_font_variant = "normal",
    },
    snippets = {
      preset = "luasnip",
    },
    cmdline = {
      keymap = { preset = "inherit" },
      completion = { menu = { auto_show = true } },
    },
  },
  dependencies = {
    "L3MON4D3/LuaSnip",
  },
}
