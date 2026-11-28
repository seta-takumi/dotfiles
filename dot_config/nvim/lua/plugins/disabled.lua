-- コードビューワー用途に絞るため、LazyVim 本体に含まれる編集向けプラグインを止める
return {
  -- 補完・スニペット（LazyVim の既定 extra coding.blink）
  { "saghen/blink.cmp", enabled = false },
  { "rafamadriz/friendly-snippets", enabled = false },

  -- 入力補助・編集用 textobject
  { "nvim-mini/mini.pairs", enabled = false },
  { "nvim-mini/mini.ai", enabled = false },
  { "folke/ts-comments.nvim", enabled = false },
  { "windwp/nvim-ts-autotag", enabled = false },
  { "folke/lazydev.nvim", enabled = false },

  -- フォーマッタ・リンター
  { "stevearc/conform.nvim", enabled = false },
  { "mfussenegger/nvim-lint", enabled = false },

  -- LSP サーバーの自動インストール（tsc はプロジェクトの node_modules を使う）
  { "mason-org/mason.nvim", enabled = false },
  { "mason-org/mason-lspconfig.nvim", enabled = false },

  -- UI
  { "folke/noice.nvim", enabled = false },
  { "MunifTanjim/nui.nvim", enabled = false },
  { "akinsho/bufferline.nvim", enabled = false },
  { "catppuccin/nvim", enabled = false },

  -- その他
  { "folke/persistence.nvim", enabled = false },
  { "MagicDuck/grug-far.nvim", enabled = false },
}
