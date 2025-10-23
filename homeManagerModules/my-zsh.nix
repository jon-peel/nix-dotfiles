{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    my-zsh.enable = lib.mkEnableOption "enable ZSH config";
  };

  config = lib.mkIf config.my-zsh.enable {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      # Powerline configuration
      initContent = ''
        # Powerline
        if [ -f ${pkgs.powerline}/share/zsh/site-functions/_powerline_prompt ]; then
          source ${pkgs.powerline}/share/zsh/site-functions/_powerline_prompt
        fi
      '';

      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"
          "sudo"
          "podman"
          "kubectl"
        ];
        theme = "robbyrussell"; # You can change this
      };

      shellAliases = {
        ll = "ls -l";
        la = "ls -la";
        ".." = "cd ..";
        rebuild = "sudo nixos-rebuild switch --flake ~/.dotfiles#nix-vm";
        tma = "tmux attach || tmux";
      };
    };
  };
}
