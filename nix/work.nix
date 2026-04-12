{ pkgs, ... }:
{
  # 仕事用PCのユーザー名・ホスト名に変更してください
  system.primaryUser = "work";
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
