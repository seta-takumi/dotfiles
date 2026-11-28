-- lang extras を外した分のパーサを補う（ハイライト用）
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "dockerfile", "hcl", "terraform", "sql" },
    },
  },
}
