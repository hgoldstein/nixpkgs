{ config, pkgs, ... }:

let 
  shellAliases = {
    vim = "nvim";
    vi = "nvim";
  };
  vim-kolor = pkgs.vimUtils.buildVimPlugin {
    pname = "vim-kolor";
    version = "v1.4.2";
    src = pkgs.fetchFromGitHub {
      owner = "zeis";
      repo = "vim-kolor";
      rev = "80f41d310da46eb8462642e9c68d9abbddbc04e4";
      sha256 = "1ii60xpisgr3wg7nkh1j22gnsi3kfksdb7k042s5l98npvbisndq";
    };
  };

in {
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "hgoldstein";
  home.homeDirectory = "/Users/hgoldstein";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.05";

  programs.neovim = {
    enable = true;
    extraConfig = (builtins.readFile ./vimrc);
    plugins = with pkgs.vimPlugins; [
      LanguageClient-neovim
      ctrlp
      editorconfig-vim
      tabular
      vim-kolor
      vim-markdown
      vim-nix
    ];
  };

  programs.zsh = {
    inherit shellAliases;
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
  };

  # programs.fish.enable = true;

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.packages = with pkgs; [
    rust-analyzer
  ];

}
