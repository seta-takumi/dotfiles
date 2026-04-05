# dotfiles

[chezmoi](https://www.chezmoi.io/) で管理している macOS 開発環境の設定ファイル群です。

## セットアップ

```bash
git clone https://github.com/seta-takumi/dotfiles.git ~/.local/share/chezmoi
bash ~/.local/share/chezmoi/setup.sh
```

`setup.sh` が以下を自動で実行します:

1. Homebrew のインストール
2. chezmoi のインストール（初回ブートストラップ用）& dotfiles の適用
3. `brew bundle --global` — mise / sheldon / cask アプリのインストール
4. `mise install` — 開発ツール一式のインストール

## 含まれる設定

| ファイル       | 適用先        | 説明                                           |
| -------------- | ------------- | ---------------------------------------------- |
| `dot_Brewfile` | `~/.Brewfile` | Homebrew パッケージ一覧（mise 管理外のツール） |
| `dot_zshrc`    | `~/.zshrc`    | zsh 設定                                       |
| `dot_zprofile` | `~/.zprofile` | ログインシェル設定                             |
| `dot_zshenv`   | `~/.zshenv`   | 環境変数                                       |
| `dot_config/`  | `~/.config/`  | mise / Neovim / sheldon / starship / yazi など |
| `dot_claude/`  | `~/.claude/`  | Claude Code 設定                               |

## ツール管理方針

開発ツールの大半は [mise](https://mise.jdx.dev/) で管理しています。
Homebrew は mise で管理できないツール（sheldon など、動的リンクの都合があるもの）と cask アプリのみを管理します。

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
