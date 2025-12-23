#!/bin/bash

# dotfilesディレクトリのパス
DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

# ファイルをリンクする関数
link_file() {
    local source="$1"
    local target="$2"

    # 既にシンボリックリンクが正しく貼られている場合はスキップ
    if [ -L "$target" ] && [ "$(readlink "$target")" = "$source" ]; then
        echo "Skipping $target (already linked)"
        return
    fi

    # ターゲットディレクトリを作成
    mkdir -p "$(dirname "$target")"

    # 既存のファイル・ディレクトリが存在する場合はバックアップ
    if [ -e "$target" ] || [ -L "$target" ]; then
        backup_path="${target}_bk"
        echo "Backing up existing $target to $backup_path"
        mv "$target" "$backup_path"
    fi

    # シンボリックリンクを作成
    echo "Creating symlink: $target -> $source"
    ln -s "$source" "$target"
}

# ディレクトリを再帰的に処理する関数
process_directory() {
    local source_dir="$1"
    local target_base="$2"

    for item in "$source_dir"/*; do
        [ -e "$item" ] || continue

        local basename=$(basename "$item")
        local target_path="$target_base/$basename"

        if [ -d "$item" ]; then
            # ディレクトリの場合は再帰的に処理
            process_directory "$item" "$target_path"
        else
            # ファイルの場合はリンク
            link_file "$item" "$target_path"
        fi
    done
}

# 引数がある場合は指定されたもののみ処理、なければ全て処理
if [ $# -eq 0 ]; then
    targets=("$DOTFILES_DIR"/dot_*)
else
    targets=()
    for arg in "$@"; do
        # dot_ プレフィックスがない場合は追加
        if [[ ! "$arg" =~ ^dot_ ]]; then
            arg="dot_$arg"
        fi
        targets+=("$DOTFILES_DIR/$arg")
    done
fi

# 指定されたファイル・ディレクトリを処理
for item in "${targets[@]}"; do
    # ファイルが存在しない場合はスキップ
    if [ ! -e "$item" ]; then
        echo "Warning: $item does not exist, skipping"
        continue
    fi

    basename=$(basename "$item")
    target_name="${basename/dot_/.}"
    target_path="$HOME/$target_name"

    if [ -d "$item" ]; then
        # ディレクトリの場合は中身を再帰的に処理
        process_directory "$item" "$target_path"
    else
        # ファイルの場合は直接リンク
        link_file "$item" "$target_path"
    fi
done

echo "Setup completed!"
