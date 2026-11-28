return {
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
      servers = {
        lua_ls = { enabled = false },
        -- TypeScript 7 以降の tsc を言語サーバーとして使う。
        -- プロジェクトの node_modules/.bin/tsc を優先し、TS 6 以下のプロジェクトでは起動しない。
        tsc = { mason = false },
      },
    },
  },
}
