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
        filetypes = {
          yaml = true,
        },
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
    "CopilotC-Nvim/CopilotChat.nvim",
    opts = {
      show_help = "yes", -- Show help text for CopilotChatInPlace, default: yes
      debug = false, -- Enable or disable debug mode, the log file will be in ~/.local/state/nvim/CopilotChat.nvim.log
      disable_extra_info = "no", -- Disable extra information (e.g: system prompt) in the response.
    },
    build = function()
      vim.notify "Please update the remote plugins by running ':UpdateRemotePlugins', then restart Neovim."
    end,
    event = "VeryLazy",
    keys = {
      { "<leader>ce", "<cmd>CopilotChatExplain<cr>", desc = "CopilotChat - Explain code" },
      { "<leader>ct", "<cmd>CopilotChatTests<cr>", desc = "CopilotChat - Generate tests" },
      {
        "<leader>cv",
        ":CopilotChatVisual",
        mode = "x",
        desc = "CopilotChat - Open in vertical split",
      },
      {
        "<leader>cx",
        ":CopilotChatInPlace<cr>",
        mode = "x",
        desc = "CopilotChat - Run in-place code",
      },
    },
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
      local cmp = require "cmp"
      return require("astronvim.utils").extend_tbl(opts, {
        mapping = cmp.mapping.preset.insert {
          ["<C-y>"] = cmp.mapping.confirm { select = true },
          ["<C-a>"] = cmp.mapping.complete {
            config = {
              sources = {
                { name = "copilot" },
                { name = "cody" },
              },
            },
          },
        },
        formatting = {
          format = require("lspkind").cmp_format {
            with_text = true,
            menu = {
              copilot = "[ Copilot]",
              cody = "[ Cody]",
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
