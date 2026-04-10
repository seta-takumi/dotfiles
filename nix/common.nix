{ pkgs, ... }:
{
  # Nix 自体の設定
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nixpkgs.config.allowUnfree = true;
  nixpkgs.hostPlatform = "aarch64-darwin";

  # CLI ツール
  environment.systemPackages = with pkgs; [
    # パッケージ管理・dotfiles
    chezmoi
    mise
    sheldon

    # エディタ・ターミナル
    neovim
    starship
    zellij
    yazi

    # 検索・ファイル操作
    bat
    eza
    fd
    fzf
    ripgrep
    jq
    zoxide

    # Git 関連
    gh
    ghq
    lazygit
    pre-commit

    # その他 CLI
    _1password-cli
    claude-code
    agent-browser
    git-filter-repo
    snowflake-cli
  ];

  # Homebrew (cask / GUIアプリ管理)
  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";
    taps = [
      "arto-app/tap"
      "nikitabobko/tap"
    ];
    casks = [
      "1password"
      "nikitabobko/tap/aerospace"
      "alt-tab"
      "arc"
      "arto-app/tap/arto"
      "cmux"
      "copilot-cli"
      "drawio"
      "font-moralerspace-hw"
      "font-udev-gothic-nf"
      "ghostty@tip"
      "obsidian"
      "thebrowsercompany-dia"
      "visual-studio-code"
    ];
  };

  # macOS システム設定
  system.stateVersion = 6;
  security.pam.services.sudo_local.touchIdAuth = true;
}
