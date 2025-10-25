{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.my-git.enable = lib.mkEnableOption "Enable git";

  config = lib.mkIf config.my-git.enable {
    programs.git = {
      enable = true;
      settings.user = {
        name = "Jonathan Peel";
        email = "me@jonathanpeel.co.za";
      };
    };

    programs.gh = {
      enable = true;

      # login to git with `gh auth login`
      gitCredentialHelper.enable = true;

      settings = {
        git_protocol = "ssh";

        editor = "vim";
        prompt = "enabled";

        # Custom aliases
        aliases = {
          co = "pr checkout";
          pv = "pr view";
        };
      };
    };

    home.packages = with pkgs; [ gh-markdown-preview ];
  };
}
