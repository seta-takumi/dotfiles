-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- ビューワー用途なので保存時の自動フォーマットはしない（tsc の LSP で整形されるのを防ぐ）
vim.g.autoformat = false
