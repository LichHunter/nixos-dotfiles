{pkgs, ...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;

    oh-my-zsh = {
      enable = true;

      plugins = [ 
        "git" 
      ];
      theme = "bira";
    };    

    shellAliases = {
      ll = "exa -al";
      nixos-update = "sudo nixos-rebuild switch";
      nixos-build = "sudo nixos-rebuild build";
    };
    #histSize = 10000;
    #histFile = "${config.xdg.dataHome}/zsh/history";
  };
}
