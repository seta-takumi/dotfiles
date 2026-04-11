# dotfiles

[chezmoi](https://www.chezmoi.io/) と [nix-darwin](https://github.com/nix-darwin/nix-darwin) で管理している macOS 開発環境の設定ファイル群です。

## セットアップ

```bash
# 1. Nix のインストール
curl -sSfL https://artifacts.nixos.org/nix-installer | sh -s -- install

# 2. dotfiles のクローン
nix-shell -p git --run "git clone https://github.com/seta-takumi/dotfiles ~/ghq/github.com/seta-takumi/dotfiles"

# 3. 既存シェル設定のバックアップ（初回のみ）
sudo mv /etc/bashrc /etc/bashrc.before-nix-darwin
sudo mv /etc/zshrc /etc/zshrc.before-nix-darwin

# 4. nix-darwin の適用（初回）
# <hostname> を自分のホスト名に置き換えてください（tak, work など）
sudo nix run nix-darwin -- switch --flake ~/ghq/github.com/seta-takumi/dotfiles#<hostname>

# 5. dotfiles の適用 & ランタイムのインストール
chezmoi init --apply seta-takumi/dotfiles
mise install
```

初回以降の nix-darwin 更新:

```bash
darwin-rebuild switch --flake ~/ghq/github.com/seta-takumi/dotfiles#<hostname>
```

## 含まれる設定

| ファイル       | 説明                                             |
| -------------- | ------------------------------------------------ |
| `flake.nix`    | nix-darwin エントリポイント（プライベート/仕事用） |
| `nix/`         | Nix モジュール（common / work / hosts）          |
| `dot_zshrc`    | zsh 設定                                         |
| `dot_zprofile` | ログインシェル設定                               |
| `dot_zshenv`   | 環境変数                                         |
| `dot_config/`  | mise / Neovim / sheldon / starship / yazi など   |
| `dot_claude/`  | Claude Code 設定                                 |

## ツール管理方針

| レイヤー   | ツール     | 管理対象                                           |
| ---------- | ---------- | -------------------------------------------------- |
| パッケージ | nix-darwin | CLI ツール、GUI アプリ（cask）                     |
| ランタイム | mise       | 言語バージョン管理（go, node, rust 等）、npm/pipx  |
| dotfiles   | chezmoi    | 設定ファイルの展開                                 |
| zsh プラグイン | sheldon | zsh-autosuggestions, fast-syntax-highlighting 等   |

### プライベート / 仕事用の切り替え

`flake.nix` に2つの構成を定義しています:

- **プライベート** (`nix/common.nix`): ベースとなる共通パッケージ
- **仕事用** (`nix/common.nix` + `nix/work.nix`): 共通 + awscli, gcloud, Slack, Zoom 等を追加

ホスト名で切り替え:

```bash
# プライベートPC
darwin-rebuild switch --flake .#tak

# 仕事用PC
darwin-rebuild switch --flake .#work
```

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
