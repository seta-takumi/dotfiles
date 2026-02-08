local lsp = {
  "ty",
  "tsgo",
}

return {
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = lsp,
    },
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        virtual_text = {
          format = function(diagnostic)
            -- Add lsp server name to message
            return string.format("%s (%s)", diagnostic.message, diagnostic.source or "Unknown")
          end,
        },
      },
    },
  },
  vim.lsp.enable(lsp),
}
