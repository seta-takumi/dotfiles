#!/bin/bash
# gh 拡張をインストールする。
# run_onchange_ なので、このファイルの内容が変わったときだけ chezmoi apply で再実行される。
# 更新は `gh extension upgrade --all` で手動で行う。
set -euo pipefail

extensions=(
  github/gh-stack
)

if ! command -v gh >/dev/null 2>&1; then
  echo "gh not found; skipping gh extension install" >&2
  exit 0
fi

installed="$(gh extension list 2>/dev/null || true)"

for ext in "${extensions[@]}"; do
  if grep -qF "$ext" <<<"$installed"; then
    echo "gh extension already installed: $ext"
  else
    gh extension install "$ext"
  fi
done
