return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-calc",
      "hrsh7th/cmp-emoji",
      "jc-doyle/cmp-pandoc-references",
      "kdheepak/cmp-latex-symbols",
    },
    opts = function(_, opts)
      local cmp = require "cmp"

      -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline("/", { sources = { { name = "buffer" } } })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(":", {
        sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
      })

      local cmp_autopairs = require "nvim-autopairs.completion.cmp"
      cmp.event:on(
        "confirm_done",
        cmp_autopairs.on_confirm_done {
          filetypes = {
            go = false,
            tex = false,
          },
        }
      )

      return opts
    end,
  },
}
