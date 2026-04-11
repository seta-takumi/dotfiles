{ pkgs, ... }:
{
  # 仕事用PCのホスト名に変更してください
  networking.hostName = "work";

  environment.systemPackages = with pkgs; [
    awscli2
    google-cloud-sdk
  ];

  homebrew.casks = [
    "slack"
    "zoom"
  ];
}
