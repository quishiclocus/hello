{ config, pkgs, lib, ... }:

let
  name = "Chuck Stearns";
  user = "chuck";
  email = "chuck.stearns@gmail.com";
in {
  # Shared shell configuration
  zsh = {
    enable = true;
    autocd = false;
    initExtra = ''
      [[ ! -f ${./config/p10k.zsh} ]] || source ${./config/p10k.zsh}
    '';
    plugins = [
      {
        name = "zshrc_local";
        src = lib.cleanSource ./zshrc_local-config;
        file = "zshrc_local.zsh";
      }
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.8.0";
          sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
        };
      }
    ];

    initExtraFirst = ''
      if [[ -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]]; then
        . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
        . /nix/var/nix/profiles/default/etc/profile.d/nix.sh
      fi

      # Define variables for directories
      export PATH=$HOME/.pnpm-packages/bin:$HOME/.pnpm-packages:$PATH
      export PATH=$HOME/.npm-packages/bin:$HOME/bin:$PATH
      export PATH=$HOME/.local/share/bin:$PATH

      export HISTIGNORE="pwd:ls:cd"

      export ALTERNATE_EDITOR="vim"
      export EDITOR="nvim"

    '';
  };

#  starship = {
#    enable = true;
#    enableZshIntegration = true;
#    settings = {
#      add_newline = true;
#      command_timeout = 1000;
#      format = "[░▒▓](os_bg)$os$username[](bg:dir_bg fg:os_bg)$directory[](fg:dir_bg bg:git_bg)$git_branch$git_status[](fg:git_bg bg:lang_bg)$golang[](fg:lang_bg bg:background)\n$character";
#      right_format = "$shell$shlvl$jobs$cmd_duration";
#      continuation_prompt = "▶▶ ";
#      palette = "terafox";
#      palettes.duskfox = {
#        red = "#eb6f92";
#        green = "#a3be8c";
#        purple = "#c4a7e7";
#        yellow = "#f6c177";
#        os_bg = "#6e6a86";
#        os_fg = "#191726";
#        dir_bg = "#a3be8c";
#        dir_fg = "#232136";
#        git_bg = "#f6c177";
#        git_fg = "#2d2a45";
#        lang_bg = "#569fba";
#        lang_fg = "#373354";
#      };
#      palettes.terafox = {
#        red = "#e85c51";
#        green = "#7aa4a1";
#        purple = "#ad5c7c";
#        yellow = "#fda47f";
#        os_bg = "#587b7b";
#        os_fg = "#0f1c1e";
#        dir_bg = "#7aa4a1";
#        dir_fg = "#152528";
#        git_bg = "#fda47f";
#        git_fg = "#254147";
#        lang_bg = "#5a93aa";
#        lang_fg = "#254147";
#      };
#      username = {
#        style_user = "bg:os_bg fg:os_fg";
#        style_root = "bg:os_bg fg:os_fg";
#        format = "[$user]($style)";
#        disabled = false;
#        show_always = true;
#      };
#      hostname = {
#        ssh_only = false;
#        ssh_symbol = "🌐 ";
#        style = "yellow bold";
#        format = "@[$hostname]($style)";
#        trim_at = ".";
#        disabled = false;
#      };
#      character = {
#        disabled = false;
#        success_symbol = "[](bold fg:#a3be8c)";
#        error_symbol = "[](bold fg:#eb6f92)";
#        vimcmd_symbol = "[](bold fg:green)";
#        vimcmd_replace_one_symbol = "[](bold fg:purple)";
#        vimcmd_replace_symbol = "[](bold fg:purple)";
#        vimcmd_visual_symbol = "[](bold fg:yellow)";
#      };
#      directory = {
#        home_symbol = " 󰋞 ~";
#        read_only_style = "fg:dir_fg bg:dir_bg";
#        read_only = "󰌾";
#        truncation_length = 3;
#        truncation_symbol = " …/";
#        truncate_to_repo = true;
#        style = "fg:dir_fg bg:dir_bg";
#        format = "[$path]($style)[$read_only]($read_only_style)";
#      };
#      directory.substitutions = {
#        Documents = "󰈙";
#        Downloads = "";
#        Music = "";
#        Pictures = "";
#        src = "";
#      };
#      cmd_duration = {
#        min_time = 4;
#        show_milliseconds = false;
#        disabled = false;
#        style = "bold italic red";
#        format = " [$duration]($style)";
#      };
#      nix_shell = {
#        disabled = false;
#        pure_msg = "";
#        impure_msg = "";
#        symbol = " ";
#        format = "[$symbol$state(\($name\))]($style) ";
#        style = "bg:os_bg fg:os_fg";
#      };
#      shlvl = {
#        disabled = false;
#        symbol = "λ";
#      };
#      shell = {
#        disabled = false;
#        format = "$indicator";
#        fish_indicator = "f(bright-cyan) ";
#        bash_indicator = "b(bright-cyan) ";
#        zsh_indicator = "z(bright-cyan) ";
#      };
#      python = {
#        symbol = "";
#        style = "bg:lang_bg";
#        python_binary = ["./venv/bin/python" "python" "python3" "python2"];
#        detect_extensions = ["py"];
#      };
#      docker_context = {
#        symbol = " ";
#        style = "blue bold";
#        only_with_files = true;
#        detect_files = ["docker-compose.yml" "docker-compose.yaml" "Dockerfile"];
#        detect_folders = [];
#        disabled = false;
#      };
#      golang = {
#        symbol = "";
#        style = "bg:lang_bg";
#      };
#      git_branch = {
#        symbol = "  ";
#        format = "[$symbol$branch]($style)";
#        style = "fg:git_fg bg:git_bg";
#      };
#      git_status = {
#        format = "[\($all_status$ahead_behind\)]($style)";
#        style = "fg:git_fg bg:git_bg";
#        conflicted = "🏳";
#        up_to_date = "";
#        untracked = "";
#        ahead = "⇡\${count}";
#        diverged = "⇕⇡\${ahead_count}⇣\${behind_count}";
#        behind = "⇣\${count}";
#        stashed = "";
#        modified = "";
#        staged = "[++\($count\)](green)";
#        renamed = "襁";
#        deleted = "";
#      };
#      git_metrics = {
#       format = "( [+$added]($added_style))([-$deleted]($deleted_style) )"; 
#      };
#      aws.symbol = "";
#      os = {
#        disabled = false;
#        style = "bg:os_bg fg:os_fg";
#      };
#      os.symbols = {
#        Windows = "󰍲";
#        Ubuntu = "󰕈";
#        SUSE = "";
#        Raspbian = "󰐿";
#        Mint = " 󰣭 ";
#        Macos = "󰀵";
#        Manjaro = "";
#        Linux = "󰌽";
#        Gentoo = "󰣨";
#        Fedora = "󰣛";
#        Alpine = "";
#        Amazon = "";
#        Android = "";
#        Arch = "󰣇";
#        Artix = "󰣇";
#        CentOS = "";
#        Debian = "󰣚";
#        Redhat = "󱄛";
#        RedHatEnterprise = "󱄛";
#      };
#    };
#  };

  git = {
    enable = true;
    ignores = [ "*.swp" ];
    userName = name;
    userEmail = email;
    lfs = {
      enable = true;
    };
    extraConfig = {
      init.defaultBranch = "main";
      core = {
	    editor = "vim";
        autocrlf = "input";
      };
      commit.gpgsign = true;
      pull.rebase = true;
      rebase.autoStash = true;
    };
  };

  vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [ vim-airline vim-airline-themes vim-startify vim-tmux-navigator ];
    settings = { ignorecase = true; };
    extraConfig = ''
      "" General
      set number
      set history=1000
      set nocompatible
      set modelines=0
      set encoding=utf-8
      set scrolloff=3
      set showmode
      set showcmd
      set hidden
      set wildmenu
      set wildmode=list:longest
      set cursorline
      set ttyfast
      set nowrap
      set ruler
      set backspace=indent,eol,start
      set laststatus=2
      set clipboard=autoselect

      " Dir stuff
      set nobackup
      set nowritebackup
      set noswapfile
      set backupdir=~/.config/vim/backups
      set directory=~/.config/vim/swap

      " Relative line numbers for easy movement
      set relativenumber
      set rnu

      "" Whitespace rules
      set tabstop=8
      set shiftwidth=2
      set softtabstop=2
      set expandtab

      "" Searching
      set incsearch
      set gdefault

      "" Statusbar
      set nocompatible " Disable vi-compatibility
      set laststatus=2 " Always show the statusline
      let g:airline_theme='bubblegum'
      let g:airline_powerline_fonts = 1

      "" Local keys and such
      let mapleader=","
      let maplocalleader=" "

      "" Change cursor on mode
      :autocmd InsertEnter * set cul
      :autocmd InsertLeave * set nocul

      "" File-type highlighting and configuration
      syntax on
      filetype on
      filetype plugin on
      filetype indent on

      "" Paste from clipboard
      nnoremap <Leader>, "+gP

      "" Copy from clipboard
      xnoremap <Leader>. "+y

      "" Move cursor by display lines when wrapping
      nnoremap j gj
      nnoremap k gk

      "" Map leader-q to quit out of window
      nnoremap <leader>q :q<cr>

      "" Move around split
      nnoremap <C-h> <C-w>h
      nnoremap <C-j> <C-w>j
      nnoremap <C-k> <C-w>k
      nnoremap <C-l> <C-w>l

      "" Easier to yank entire line
      nnoremap Y y$

      "" Move buffers
      nnoremap <tab> :bnext<cr>
      nnoremap <S-tab> :bprev<cr>

      "" Like a boss, sudo AFTER opening the file to write
      cmap w!! w !sudo tee % >/dev/null

      let g:startify_lists = [
        \ { 'type': 'dir',       'header': ['   Current Directory '. getcwd()] },
        \ { 'type': 'sessions',  'header': ['   Sessions']       },
        \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      }
        \ ]

      let g:startify_bookmarks = [
        \ '~/.local/share/src',
        \ ]

      let g:airline_theme='bubblegum'
      let g:airline_powerline_fonts = 1
      '';
     };

  alacritty = {
    enable = true;
    settings = {
      import = [ 
        "~/.config/alacritty/alacritty_local.toml"
      ];
    };
  };

  ssh = {
    enable = true;
    includes = [
      (lib.mkIf pkgs.stdenv.hostPlatform.isLinux
        "/home/${user}/.ssh/config_external"
      )
      (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin
        "/Users/${user}/.ssh/config_external"
      )
    ];
    forwardAgent = true;
    addKeysToAgent = "yes";
  };

  tmux = {
    enable = true;
    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
      sensible
      yank
      prefix-highlight
      {
        plugin = resurrect; # Used by tmux-continuum
        # Use XDG data directory
        # https://github.com/tmux-plugins/tmux-resurrect/issues/348
        extraConfig = ''
          set -g @resurrect-dir '$HOME/.cache/tmux/resurrect'
          set -g @resurrect-capture-pane-contents 'on'
          set -g @resurrect-pane-contents-area 'visible'
        '';
      }
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '0' # minutes
        '';
      }
    ];
    terminal = "screen-256color";
    prefix = "C-a";
    escapeTime = 10;
    historyLimit = 50000;
    extraConfig = ''

      unbind %
      bind | split-window -h
      
      unbind '"'
      bind - split-window -v
      
      unbind r
      bind r source-file ~/.tmux.conf
      
      bind -r j resize-pane -D 5
      bind -r k resize-pane -U 5
      bind -r l resize-pane -R 5
      bind -r h resize-pane -L 5
      
      bind -r m resize-pane -Z
      
      set -g mouse on
      
      set-window-option -g mode-keys vi
      
      bind-key -T copy-mode-vi 'v' send -X begin-selection
      bind-key -T copy-mode-vi 'y' send -X copy-selection
      
      unbind -T copy-mode-vi MouseDragEnd1Pane
      
      # tpm plugin
      set -g @plugin 'tmux-plugins/tpm' # Ctrl-A-I to install plugins.

      # list of tmux plugins
      set -g @plugin 'catppuccin/tmux#latest'
      set -g @plugin 'christoomey/vim-tmux-navigator' # for navigating panes and vim/nvim with Ctrl-hjkl
      #set -g @plugin 'jimeh/tmux-themepack' # to configure tmux theme
      set -g @plugin 'tmux-plugins/tmux-resurrect' # persist tmux sessions after computer restart
      set -g @plugin 'tmux-plugins/tmux-continuum' # automatically saves sessions for you every 15 minutes
      set -g @plugin 'tmux-plugins/tmux-battery'
      set -g @plugin 'tmux-plugins/tmux-cpu'
      set -g @plugin 'jamesoff/tmux-loadavg'

      #set -g @themepack 'powerline/default/cyan' # use this theme for tmux
      #set -g @themepack 'basic' 

      set -g @catppuccin_status_modules_right "... battery ..."
      set -g @catppuccin_status_modules_right "... cpu ..."
      set -g @catppuccin_status_modules_right "... load ..."

      set -g @catppuccin_window_left_separator ""
      set -g @catppuccin_window_right_separator " "
      set -g @catppuccin_window_middle_separator " █"
      set -g @catppuccin_window_number_position "right"
      
      set -g @catppuccin_window_default_fill "number"
      set -g @catppuccin_window_default_text "#W"
      
      set -g @catppuccin_window_current_fill "number"
      set -g @catppuccin_window_current_text "#W"
      
      set -g @catppuccin_status_modules_right "directory user host session"
      set -g @catppuccin_status_left_separator  " "
      set -g @catppuccin_status_right_separator ""
      set -g @catppuccin_status_fill "icon"
      set -g @catppuccin_status_connect_separator "no"
      
      set -g @catppuccin_directory_text "#{pane_current_path}"
      
      set -g @resurrect-capture-pane-contents 'on' # allow tmux-ressurect to capture pane contents
      set -g @continuum-restore 'on' # enable tmux-continuum functionality
      set -g @continuum-save-interval '0' # DISABLE continuum-restore (which will clear cache)

      # Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
      run '~/.tmux/plugins/tpm/tpm'
    '';
  };
}
