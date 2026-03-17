# dotfiles

[chezmoi](https://www.chezmoi.io/) で管理している macOS 開発環境の設定ファイル群です。

## セットアップ

```bash
# 1. Homebrew のインストール
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 2. chezmoi のインストール & dotfiles の適用
brew install chezmoi
chezmoi init --apply https://github.com/seta-takumi/dotfiles.git

# 3. Homebrew パッケージのインストール
brew bundle --global

# 4. mise ツールのインストール
mise install
```

または `setup.sh` を使う場合（事前にリポジトリをクローンする必要があります）:

```bash
git clone https://github.com/seta-takumi/dotfiles.git ~/.local/share/chezmoi
bash ~/.local/share/chezmoi/setup.sh
```

## 含まれる設定

| ファイル | 適用先 | 説明 |
|---|---|---|
| `dot_Brewfile` | `~/.Brewfile` | Homebrew パッケージ一覧 |
| `dot_zshrc` | `~/.zshrc` | zsh 設定 |
| `dot_zprofile` | `~/.zprofile` | ログインシェル設定 |
| `dot_zshenv` | `~/.zshenv` | 環境変数 |
| `dot_config/` | `~/.config/` | mise / Neovim / sheldon / starship / yazi など |
| `dot_claude/` | `~/.claude/` | Claude Code 設定 |

## dotfiles の更新

```bash
# 変更を取得して適用
chezmoi update

# 設定ファイルを編集
chezmoi edit ~/.zshrc

# 変更を確認してから適用
chezmoi diff
chezmoi apply
```
