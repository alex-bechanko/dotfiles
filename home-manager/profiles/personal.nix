{
  config,
  pkgs,
  ...
}:
{
  age.secrets.gemini_api_key.file = ../../secrets/gemini_api_key.age;

  home.packages = [ pkgs.agenix-cli ];

  home.sessionVariables = {
    GEMINI_API_KEY = "$(cat ${config.age.secrets.gemini_api_key.path})";
  };

  programs = {
    bash.initExtra = ''
      export PS1="\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ "
    '';

    discord = {
      enable = true;
      settings = {
        enableHardwareAcceleration = true;
        openH264Enabled = true;
      };
    };
  };
}
