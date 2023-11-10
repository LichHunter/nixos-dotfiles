{pkgs, ...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    #enableAutosuggestions = true;

    oh-my-zsh = {
      enable = true;

      plugins = [ 
        "git" 
        #"zsh-autosuggestions"
      ];
      theme = "bira";
    };    

    shellAliases = {
      ll = "exa -al";
      #update = "sudo nixos-rebuild switch";
    };
    #histSize = 10000;
    #histFile = "${config.xdg.dataHome}/zsh/history";
  };
}
