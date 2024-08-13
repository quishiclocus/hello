{ pkgs }:

with pkgs; [
  # General packages for development and system management
  alacritty
  aspell
  aspellDicts.en
  bat
  btop
  coreutils
  difftastic
  wget
  zip
  direnv
  go
  gh
  bat
  delta
  eza
  fd
  fzf
  neovim
  zoxide
  zsh-autosuggestions
  zsh-syntax-highlighting


  # Encryption and security tools
  age
  #age-plugin-yubikey
  gnupg
  #libfido2

  # Cloud-related tools and SDKs
  #docker
  #docker-compose
  rancher

  # Media-related packages
  #emacs-all-the-icons-fonts
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
  nodePackages.npm # globally install npm
  nodePackages.prettier
  nodejs

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
