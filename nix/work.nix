{ pkgs, ... }:
{
  # 仕事用追加 CLI ツール
  environment.systemPackages = with pkgs; [
    awscli2
    google-cloud-sdk
  ];

  # 仕事用追加 GUI アプリ
  homebrew = {
    casks = [
      "slack"
      "slack-cli"
      "zoom"
    ];
  };
}
