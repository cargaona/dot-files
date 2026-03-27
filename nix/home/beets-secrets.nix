{ config, ... }:

{
  sops = {
    age.keyFile = "/etc/age/keys.txt";
    defaultSopsFile = ../secrets/beets.yaml;

    secrets."subsonic_password" = { };

    templates."beets-subsonic" = {
      content = ''
        subsonic:
          url: https://navi.charlei.lat
          user: admin
          pass: ${config.sops.placeholder."subsonic_password"}
      '';
    };
  };

  programs.beets.settings.include = [
    config.sops.templates."beets-subsonic".path
  ];
}
