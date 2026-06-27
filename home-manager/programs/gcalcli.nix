{ config, lib, pkgs, ... }:
let
  tomlFormat = pkgs.formats.toml { };
in
{
  options.programs.gcalcli = {
    enable = lib.mkEnableOption "gcalcli";
    settings = lib.mkOption {
      type = tomlFormat.type;
      default = {
        auth.client-id = "418494729708-hrf3u9u1tlrfa61p91lskvohqfq65b38.apps.googleusercontent.com";
      };
      description = "gcalcli config.toml settings as a Nix attrset";
    };
  };

  config = lib.mkIf config.programs.gcalcli.enable {
    home.packages = [ pkgs.gcalcli ];

    xdg.configFile."gcalcli/config.toml".source =
      tomlFormat.generate "gcalcli-config.toml" config.programs.gcalcli.settings;

    age.secrets.gcalcli_client_secret = {
      file = ../../secrets/gcalcli_client_secret.age;
    };

    home.activation.gcalcliConfig = lib.hm.dag.entryAfter [ "agenix" ] ''
      mkdir -p ${config.xdg.configHome}/gcalcli
      printf -- "--client-secret=%s\n" "$(cat ${config.age.secrets.gcalcli_client_secret.path})" \
        > ${config.xdg.configHome}/gcalcli/gcalclirc
    '';
  };
}
