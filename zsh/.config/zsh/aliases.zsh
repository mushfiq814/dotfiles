# source this file
alias soz='source ~/.config/zsh/.zshrc'

# package install
alias pac='sudo pacman -Syu'
alias pacsearch='sudo pacman -Ss'

# exa (an ls alternative); NOTE: overrides the ls aliases
alias ls='exa --oneline --icons'
alias la='exa --long --all --icons'
alias lg='exa --long --all --icons --git'

# bat (a cat alternative)
alias cat='bat --theme base16-256'

# grep aliases
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# git aliases
alias ga='git add'
alias gs='git status'
alias gl=prettyGitLog
alias gc='git commit'
alias gb='git branch'
alias gd=fuzzyGitDiff
alias gsl=fuzzyGitStash

alias gco=fuzzyGitCheckout
alias gfo='git fetch origin'
alias gpo='git pull origin'
alias gpush='git push origin'

# silent mode for make (suppress output)
alias make='make -s'

# youtube download mp3
alias youtube-dl='yt-dlp'
alias yt='yt-dlp -x --audio-format mp3'

# config files aliases
alias v='nvim --listen /tmp/nvim-server.pipe'
alias brc='v ~/.bashrc'
alias zrc='v ~/.config/zsh/.zshrc'
alias vrc='v /etc/vim/vimrc'
alias nvrc='v ~/.config/nvim/init.vim'
alias trc='v ~/.tmux.conf'

# filesystem aliases

alias DW='cd ~/downloads'
alias PR="showFuzzyDirContents $HOME/projects"
alias FLASH="showFuzzyDirContents /run/media/mushfiq"

# package manager
alias sai='sudo apt install'

# npm
alias nr='npm run'
alias nrd='npm run dev'
alias nrs='npm run start'

# open in default program
alias open='xdg-open'

# python3 and pip3; WARNING: replaces pip version2 command name
alias pip='python3 -m pip'

# launch vimwiki
alias vw='v ~/vimwiki/index.md'

# autolaunch ytfzf with thumbnail support
alias ytfzf='ytfzf -t'

# neofetch
alias fetch='neofetch --backend chafa --source ~/pictures/wallpapers/UvSvAAP.jpg --disable gpu --size 30% --xoffset 2 --yoffset 1 --gap 5'

alias wifictl='nmtui'

# csv viewer (tidy-viewer)
alias tv='tidy-viewer'

# blender
alias blender='~/.steam/debian-installation/steamapps/common/Blender/blender'

# i3lock
alias lock='i3lock -i ~/Pictures/wallpapers/xcwwpikoxeh31.png -t -c "#000000"'
