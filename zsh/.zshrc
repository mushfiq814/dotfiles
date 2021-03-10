#=============================================================================
#                                  █████        ██████  ███           
#                                 ░░███        ███░░███░░░            
#  █████████████  █████ ████ █████ ░███████   ░███ ░░░ ████   ████████
# ░░███░░███░░███░░███ ░███ ███░░  ░███░░███ ███████  ░░███  ███░░███ 
#  ░███ ░███ ░███ ░███ ░███░░█████ ░███ ░███░░░███░    ░███ ░███ ░███ 
#  ░███ ░███ ░███ ░███ ░███ ░░░░███░███ ░███  ░███     ░███ ░███ ░███ 
#  █████░███ █████░░██████████████ ████ █████ █████    █████░░███████ 
# ░░░░░ ░░░ ░░░░░  ░░░░░░░░░░░░░░ ░░░░ ░░░░░ ░░░░░    ░░░░░  ░░░░░███ 
#                 |                 ,- o                         ░███ 
#         ,-, ,-. |-.  ,-. ,-. ;-.  |  . ,-:                     █████
#          /  `-. | |  |   | | | |  |- | | |                    ░░░░░
#         '-' `-' ' '  `-' `-' ' '  |  ' `-|
#                                  -'    `-'
#=============================================================================

# Startup, Prompt and Colors {{{

# Startup Scripts

# # TaskWarrior
# echo "Work Tasks"
# task +work

# echo "Personal Tasks"
# task +personal

# wsl pulseaudio server
export PULSE_SERVER=tcp:localhost

# starship prompt
eval "$(starship init zsh)"

# Set up zsh prompt
autoload -Uz colors && colors
PS1='💻 '\
'%F{yellow}%n%f'\
'%F{magenta}:%f'\
'%F{green}%m %f'\
'[%F{cyan}%1d%f] '\
'%F{red}█%f'\
'%K{red}%F{green}░▒▓█%k%f'\
'%K{green}%F{blue}░▒▓█%k%f '\
'%F{blue}$%f '

# get weather info; q = show city, Q = hide city
# curl 'wttr.in/?format=2'

# LS_COLORS moved towards the bottom; otherwise doesn't work

# man pages color
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

# start in $HOME
cd $HOME

# this fixes issues with tmux rendering when using italic support
# TERM=xterm-color

# }}}

# Aliases and Variables {{{

# source this file
alias soz='source ~/.zshrc'

# ls aliases (try saying that 5 times)
# alias ls='ls --color=auto -1'
# alias ll='ls -alF'
# alias la='ls -la'
# alias l='ls -CF'

# exa (an ls alternative); NOTE: overrides the ls aliases
alias ls='exa --oneline --icons'
alias la='exa --long --all --icons'
alias lg='exa --long --all --icons --git'

# bat (a cat alternative)
alias bat='batcat'

# grep aliases
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# git aliases
alias ga='git add'
alias gs='git status'

# silent mode for make (suppress output)
alias make='make -s'

# youtube download mp3
alias yt='youtube-dl -x --audio-format mp3'

# config files aliases
alias brc='sudo $EDITOR ~/.bashrc'
alias zrc='sudo $EDITOR ~/.zshrc'
alias v='$EDITOR'
alias vlatest='~/downloads/squashfs-root/usr/bin/nvim'
alias vrc='sudo $EDITOR /etc/vim/vimrc'
alias nvrc='$EDITOR ~/.config/nvim/init.vim'
alias wrc='$EDITOR /mnt/c/Users/mushf/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json'
# alias wrc='$EDITOR /mnt/c/Users/mushf/AppData/Local/Packages/Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe/LocalState/settings.json'
alias frc='$EDITOR /mnt/c/Users/mushf/AppData/Roaming/Mozilla/Firefox/Profiles/3qkb6j9y.default-1586366854597/chrome'
alias trc='$EDITOR ~/.tmux.conf'

# filesystem aliases
alias dm='cd /mnt/c/Users/mushf/disciplined-minds'
alias usf='cd /mnt/c/Users/mushf/OneDrive/USF'
alias main-dm='ssh -t root@64.225.5.39 "cd ../var/www/html/wp-content/themes/disciplined-minds; bash"'

# open in firefox
alias fox='powershell.exe Start-Process -FilePath Firefox -ArgumentList'

# open in default program
alias open='powershell.exe Invoke-Item'

# python3 and pip3; WARNING: replaces pip version2 command name
alias pip='python3 -m pip'

# launch vimwiki
alias vw='$EDITOR ~/windows/vimwiki/index.md'

# }}}

# Functions {{{
function texclean() {
  rm -i *.log *.aux
}

function convertWinPath() {
  echo "'$1'"
  echo "'$1'" | sed 's/\\/\//g'
  echo "'$1'" | sed 's/\\/\//g' | sed 's/C:/\/mnt\/c/g'
}

function vlcplay() {
	vlc="C:\Program Files (x86)\VideoLan\VLC\\\vlc.exe"
	pth="$(echo $1 | sed 's/\/home\/mushfiq\/windows/C:/g; s/\//\\/g')"
	powershell.exe $vlc $pth
}

# Convert from markdown to html
function md2html() {
	css="~/dotfiles/pandoc/mvp.css"
	html="$HOME/dotfiles/pandoc/template.html"
	out="$(basename $1 .md).html"

	pandoc $1                       \
	       --to html                \
	       --standalone             \
	       --css $css               \
	       --template $html         \
	       --output $out            \
	       --mathjax                \
	       --highlight-style tango

	# open in browser
	# powershell.exe Invoke-Item $out
	
}

function changeBG() {
	pre="C:\/Users\/mushf\/Downloads\/screenshots"
	img="$pre\/$1.png"
	term1="/mnt/c/Users/mushf/AppData/Local/Packages/Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe/LocalState/settings.json"
	term2="/mnt/c/Users/mushf/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json"
	sed -i "0,/\"backgroundImage\"/s/\(\"backgroundImage\"\s*:\s*\"\).*\(\",\s*\)/\1$img\2/" $term1
	sed -i "0,/\"backgroundImage\"/s/\(\"backgroundImage\"\s*:\s*\"\).*\(\",\s*\)/\1$img\2/" $term2
}

# }}}

# Editing {{{

# Default Editor
export EDITOR=nvim

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Edit line in $EDITOR with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# }}}

# History {{{

# enable history
export HISTSIZE=2000
export SAVEHIST=$HISTSIZE
export HISTFILE=~/.zsh_history
# ignore duplicate commands
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
# ignore commands preceeded by a space
setopt hist_ignore_space
# share history between shells
setopt SHARE_HISTORY
setopt APPEND_HISTORY

# }}}

# Zsh settings {{{

# Change dir without cd
setopt auto_cd
# enable comments in interactive mode
setopt INTERACTIVE_COMMENTS

# }}}

# Zsh Completion {{{

# Use modern completion system
autoload -Uz compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
zmodload zsh/complist

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
compinit
_comp_options+=(globdots)   # Include hidden files.

# }}}

# Program Specific Settings {{{

# Node Version Manager (NVM) {{{
# NVM slows down zsh initialization by a lot.
# This enables lazy loading nvm 
lazynvm() {
	echo 'lazy loading nvm...'
  unset -f nvm node npm npx
  export NVM_DIR=~/.nvm
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm
  if [ -f "$NVM_DIR/bash_completion" ]; then
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
  fi
}

# lazy load nvm when the following commands are entered
nvm() { lazynvm; nvm $@ }
node() { lazynvm; node $@ }
npm() { lazynvm; npm $@ }
npx() { lazynvm; npx $@ }

# }}}

# Yarn {{{
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
# }}}

# Fuzzy Finder {{{
# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source /usr/share/doc/fzf/examples/completion.zsh
source /usr/share/doc/fzf/examples/key-bindings.zsh
# }}}

# Go Compiler {{{
export PATH=$PATH:/usr/local/go/bin
# }}}

# Python Modules {{{
export PATH=$PATH:$HOME/.local/bin
# }}}

# }}}

# Directory Colors in `ls` {{{
LS_COLORS='ow=1;30;35:di=1;30;35'
export LS_COLORS
# }}}

# zsh-syntax-highlighting; should be last. {{{
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
# }}}

# vim:foldmethod=marker:foldlevel=0
