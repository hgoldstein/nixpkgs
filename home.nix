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
  machine = import ./machine.nix;

in {
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.

  home.username = machine.username;
  home.homeDirectory = machine.homeDirectory;

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
      deoplete-nvim
      vim-toml
      vim-airline
      vim-airline-themes
    ];
  };

  programs.zsh = {
    inherit shellAliases;
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    profileExtra = (builtins.readFile ./zprofile);
    initExtra = (builtins.readFile ./zshrc);
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.packages = with pkgs; [
    direnv
    rustup
    cmake
    gh
    sapling
    ninja
    go
    gopls
    hyperfine
    ripgrep
  ];

  programs.eza = {
    enable = true;
    enableAliases = true;
  };

  programs.keychain = {
    enable = true;
    enableZshIntegration = true;
    keys = [ "id_ed25519" ];
    agents = [ "ssh" ];
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.starship = {
    enable = true;
    settings = {
      character = {
        success_symbol = "⊢";
        error_symbol = "⊢";
      };
    };
  };

  nix = {
    package = pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

}
