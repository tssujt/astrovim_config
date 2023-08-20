return {
  { import = "astrocommunity.completion.cmp-cmdline" },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "User AstroFile",
    config = function()
      require("copilot").setup {
        suggestion = { enabled = true },
        panel = { enabled = false },
      }
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    dependencies = {
      "zbirenbaum/copilot.lua",
    },
    config = function() require("copilot_cmp").setup() end,
  },
  {
    "onsails/lspkind.nvim",
    opts = function(_, opts)
      return require("astronvim.utils").extend_tbl(opts, {
        symbol_map = { Copilot = "" },
      })
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "zbirenbaum/copilot-cmp",
    },
    opts = function(_, opts)
      return require("astronvim.utils").extend_tbl(opts, {
        formatting = {
          format = require("lspkind").cmp_format {
            with_text = true,
            menu = {
              copilot = "[ Copilot]",
              buffer = "[ Buf]",
              nvim_lsp = "[ LSP]",
              luasnip = "[ LSnip]",
              nvim_lua = "[ NvimLua]",
            },
          },
        },
        sources = {
          { name = "copilot", priority = 1000 },
          { name = "nvim_lsp", priority = 1000 },
          { name = "luasnip", priority = 750 },
          { name = "buffer", priority = 500 },
        },
      })
    end,
  },
}
