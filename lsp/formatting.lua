return {
  format_on_save = {
    enabled = true,
    allow_filetypes = {
      "json",
      "go",
      "rust",
    },
    ignore_filetypes = {
      "markdown",
      "python",
    },
  },
  filter = function(client)
    if vim.bo.filetype == "python" then
      return client.name == "ruff_lsp"
    end

    return true
  end,
  timeout_ms = 10000,
}
