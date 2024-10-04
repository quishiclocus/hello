{ pkgs }:


with pkgs; [
  # General packages for development and system management
  alacritty
  aspell
  aspellDicts.en
  btop
  coreutils
  wget
  zip

  # Mutt mail stuff
  neomutt
  isync
  curl
  msmtp
  pass
  lynx
  notmuch
  abook
  urlscan
  neomutt
  offlineimap
  cyrus-sasl-xoauth2
  cyrus_sasl

  # Encryption and security tools
  age
  gnupg
  libfido2
  oauth2ms
  cyrus_sasl
  cyrus-sasl-xoauth2
  gpgme

  # Cloud-related tools and SDKs
  rancher
  awscli2
  gh
  lazygit
  gitmux

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

  # Development tools
  nodePackages.npm # globally install npm
  nodePackages.prettier
  nodejs
  direnv
  go
  golangci-lint
  cmake
  clang
  libintl

  # Python packages
  poetry
  (python312.withPackages (ps: [
    ps.flask
    ps.setuptools
    ps.pip
    ps.pipx
    ps.pylint
    ps.poetry-core
    ps.ipython
  ]))

  # Text and terminal utilities
  htop
  iftop
  jq
  ripgrep
  tree
  tmux
  unrar
  unzip
  bat
  delta
  eza
  fd
  fzf
  zoxide
  neovim
  #zsh-powerlevel10k
  #starship
  bashInteractive
  bash-completion
  fish
  wezterm
  oh-my-posh
  zsh-autosuggestions
  zsh-syntax-highlighting
  #bash-language-server
]
