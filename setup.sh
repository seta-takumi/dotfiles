#!/bin/bash
# setup.sh - macOS 開発環境のセットアップスクリプト
# 使い方: bash setup.sh

set -euo pipefail

# ----------------------------
# 定数
# ----------------------------
CHEZMOI_REPO="https://github.com/ta-seta/dotfiles"  # 必要に応じて変更
HOMEBREW_INSTALL_URL="https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh"

# ----------------------------
# ヘルパー関数
# ----------------------------
info()    { printf "\033[0;34m[INFO]\033[0m  %s\n" "$*"; }
success() { printf "\033[0;32m[OK]\033[0m    %s\n" "$*"; }
warn()    { printf "\033[0;33m[WARN]\033[0m  %s\n" "$*"; }
error()   { printf "\033[0;31m[ERROR]\033[0m %s\n" "$*" >&2; exit 1; }

# macOS かどうかを確認
check_macos() {
  if [[ "$(uname)" != "Darwin" ]]; then
    error "このスクリプトは macOS 専用です。"
  fi
  success "macOS を確認しました"
}

# Xcode Command Line Tools のインストール
install_xcode_clt() {
  if xcode-select -p &>/dev/null; then
    success "Xcode Command Line Tools はインストール済みです"
    return
  fi
  info "Xcode Command Line Tools をインストールしています..."
  xcode-select --install
  # インストール完了を待機
  until xcode-select -p &>/dev/null; do
    sleep 5
  done
  success "Xcode Command Line Tools をインストールしました"
}

# Homebrew のインストール
install_homebrew() {
  if command -v brew &>/dev/null; then
    success "Homebrew はインストール済みです"
    return
  fi
  info "Homebrew をインストールしています..."
  /bin/bash -c "$(curl -fsSL "$HOMEBREW_INSTALL_URL")"

  # Apple Silicon の場合は PATH を設定
  if [[ "$(uname -m)" == "arm64" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
  success "Homebrew をインストールしました"
}

# chezmoi のインストールと dotfiles の適用
install_chezmoi() {
  if ! command -v chezmoi &>/dev/null; then
    info "chezmoi をインストールしています..."
    brew install chezmoi
    success "chezmoi をインストールしました"
  else
    success "chezmoi はインストール済みです"
  fi

  if [[ -d "$HOME/.local/share/chezmoi/.git" ]]; then
    info "chezmoi dotfiles を更新しています..."
    chezmoi update
  else
    info "chezmoi dotfiles を初期化しています..."
    chezmoi init --apply "$CHEZMOI_REPO"
  fi
  success "dotfiles を適用しました"
}

# Homebrew パッケージのインストール
install_brew_packages() {
  info "Homebrew パッケージをインストールしています..."
  if [[ -f "$HOME/.Brewfile" ]]; then
    brew bundle --global
    success "Homebrew パッケージをインストールしました"
  else
    warn "~/.Brewfile が見つかりません。スキップします"
  fi
}

# mise ツールのインストール
install_mise_tools() {
  if ! command -v mise &>/dev/null; then
    warn "mise が見つかりません。スキップします"
    return
  fi
  info "mise ツールをインストールしています..."
  mise install
  success "mise ツールをインストールしました"
}

# ----------------------------
# メイン処理
# ----------------------------
main() {
  echo ""
  echo "============================================"
  echo "  macOS 開発環境セットアップ"
  echo "============================================"
  echo ""

  check_macos
  install_xcode_clt
  install_homebrew
  install_chezmoi
  install_brew_packages
  install_mise_tools

  echo ""
  echo "============================================"
  success "セットアップが完了しました!"
  echo "============================================"
  echo ""
  echo "次のステップ:"
  echo "  1. ターミナルを再起動してください"
  echo "  2. 必要に応じて 1Password などの認証情報を設定してください"
  echo ""
}

main "$@"
