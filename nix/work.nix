{ pkgs, ... }:
{
  # 仕事用PCのユーザー名・ホスト名に変更してください
  system.primaryUser = "ta_seta";
  networking.hostName = "N01709497";

  environment.systemPackages = with pkgs; [
    awscli2
    google-cloud-sdk
  ];

  homebrew.casks = [
    "slack"
    "zoom"
  ];
}
