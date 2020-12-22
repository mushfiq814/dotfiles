# starship prompt
eval "$(starship init zsh)"

# Set up the prompt
autoload -Uz colors && colors
# PS1='%F{yellow}%n%f:%F{green}%m%f %F{red}[%1d]%f %F{blue}$%f '

# Directory Colors in `ls`
LS_COLORS='ow=1;30;42:di=1;30;42'
export LS_COLORS

# Aliases
alias ls='ls --color=auto -1'
alias ll='ls -alF'
alias la='ls -la'
alias l='ls -CF'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias brc='sudo nvim ~/.bashrc'
alias zrc='sudo nvim ~/.zshrc'
alias v='nvim'
alias vrc='sudo vim /etc/vim/vimrc'
alias nvrc='nvim ~/.config/nvim/init.vim'

alias usf='cd /mnt/c/Users/mushf/OneDrive/USF'
alias yt='youtube-dl -x --audio-format mp3'
alias main-dm='ssh -t root@64.225.5.39 "cd ../var/www/html/wp-content/themes/disciplined-minds; bash"'
alias make='make -s' # silent mode for make (suppress output)

alias fox='powershell.exe Start-Process -FilePath Firefox -ArgumentList'

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Default Editor
export EDITOR=nvim

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history
setopt SHARE_HISTORY
setopt APPEND_HISTORY

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Use modern completion system
autoload -Uz compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
_comp_options+=(globdots)   # Include hidden files.

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

# node version manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# get weather info; q = show city, Q = hide city
# curl 'wttr.in/?format=2'

# go compiler
export PATH=$PATH:/usr/local/go/bin

# Load zsh-syntax-highlighting; should be last.
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null


export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
