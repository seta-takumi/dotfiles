{ pkgs, ... }:
let
  cliBase = with pkgs; [
    chezmoi
    mise
    sheldon
  ];

  editors = with pkgs; [
    neovim
    starship
    zellij
    yazi
  ];

  fileTools = with pkgs; [
    bat
    eza
    fd
    fzf
    ripgrep
    jq
    zoxide
  ];

  gitTools = with pkgs; [
    git
    gh
    ghq
    lazygit
    pre-commit
  ];

  misc = with pkgs; [
    _1password-cli
    agent-browser
    git-filter-repo
  ];
in
{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = cliBase ++ editors ++ fileTools ++ gitTools ++ misc;

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = false;
      cleanup = "zap";
    };
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
      "drawio"
      "font-moralerspace-hw"
      "font-udev-gothic-nf"
      "ghostty@tip"
      "obsidian"
      "thebrowsercompany-dia"
      "claude"
      "visual-studio-code"
    ];
  };

  system.stateVersion = 6;
  security.pam.services.sudo_local.touchIdAuth = true;
}
