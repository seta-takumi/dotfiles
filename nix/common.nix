{ pkgs, inputs, ... }:
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
    git-wt
    gh
    ghq
    lazygit
    pre-commit
  ];

  misc = with pkgs; [
    _1password-cli
    git-filter-repo
  ];

  guiApps = [
    inputs.arto.packages.${pkgs.system}.default
  ];
in
{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = cliBase ++ editors ++ fileTools ++ gitTools ++ misc ++ guiApps;

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = false;
      cleanup = "none";
    };
    casks = [
      "1password"
      "alt-tab"
      "arc"
      "cmux"
      "font-moralerspace-hw"
      "font-udev-gothic-nf"
      "ghostty"
      "obsidian"
      "thebrowsercompany-dia"
    ];
  };

  system.stateVersion = 6;
  security.pam.services.sudo_local.touchIdAuth = true;
}
