{ pkgs }:

with pkgs; [
  # General packages for development and system management
  alacritty
  aspell
  aspellDicts.en
  bash-completion
  #bash
  bat
  btop
  coreutils
  killall
  neofetch
  sqlite
  wget
  zip
  direnv
  go
  gh

  # Encryption and security tools
  age
  #age-plugin-yubikey
  gnupg
  #libfido2

  # Cloud-related tools and SDKs
  #docker
  #docker-compose

  # Media-related packages
  emacs-all-the-icons-fonts
  dejavu_fonts
  ffmpeg
  fd
  font-awesome
  feather-font # from overlay
  hack-font
  noto-fonts
  noto-fonts-emoji
  meslo-lgs-nf

  # Node.js development tools
  #nodePackages.npm # globally install npm
  #nodePackages.prettier
  #nodejs

  # Text and terminal utilities
  htop
  #hunspell
  iftop
  #jetbrains-mono
  jq
  ripgrep
  tree
  tmux
  unrar
  unzip
  zsh-powerlevel10k

  # Python packages
  (python3.withPackages (ps: [
    ps.flask
  ]))
]
