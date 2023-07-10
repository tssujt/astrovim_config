return {
  format_on_save = {
    enabled = true, -- enable or disable format on save globally
    allow_filetypes = { -- enable format on save for specified filetypes only
      "json",
      "go",
      "python",
      "rust",
    },
    ignore_filetypes = { -- disable format on save for specified filetypes
      "markdown",
    },
  },
  disabled = { -- disable formatting capabilities for the listed language servers
    -- "lua_ls",
  },
  timeout_ms = 10000, -- default format timeout
  -- filter = function(client) -- fully override the default formatting function
  --   return true
  -- end
}
