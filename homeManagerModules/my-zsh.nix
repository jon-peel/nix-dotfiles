{
  config,
  lib,
  pkgs,
  ...
}:

let powerlevel10k = {
      name = "powerlevel10k";
      src = pkgs.zsh-powerlevel10k;
      file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
    };

in {
  options = {
    my-zsh.enable = lib.mkEnableOption "enable ZSH config";
  };

  config = lib.mkIf config.my-zsh.enable {
    home.file.".p10k.zsh".source = ./files/p10k.zsh;

    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"
          "sudo"
          "podman"
          "kubectl"
        ];
        theme = "";
      };

      plugins = [ powerlevel10k ];
      initExtra = ''
        # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
        [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
      '';

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
