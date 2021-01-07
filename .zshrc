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

# Prompt and Colors {{{

# starship prompt
eval "$(starship init zsh)"

# Set up zsh prompt
autoload -Uz colors && colors
# PS1='%F{yellow}%n%f:%F{green}%m%f %F{red}[%1d]%f %F{blue}$%f '

# get weather info; q = show city, Q = hide city
# curl 'wttr.in/?format=2'

# Directory Colors in `ls`
LS_COLORS='ow=1;30;42:di=1;30;42'
export LS_COLORS

# }}}

# Aliases {{{
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
alias wrc='nvim /mnt/c/Users/mushf/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json'
alias frc='nvim /mnt/c/Users/mushf/AppData/Roaming/Mozilla/Firefox/Profiles/3qkb6j9y.default-1586366854597/chrome'

alias usf='cd /mnt/c/Users/mushf/OneDrive/USF'
alias yt='youtube-dl -x --audio-format mp3'
alias main-dm='ssh -t root@64.225.5.39 "cd ../var/www/html/wp-content/themes/disciplined-minds; bash"'
alias make='make -s' # silent mode for make (suppress output)

alias fox='powershell.exe Start-Process -FilePath Firefox -ArgumentList'
# }}}

# Functions {{{
function texclean() {
  rm -i *.log *.aux
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
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# }}}

# Yarn {{{
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
# }}}

# Fuzzy Finder {{{
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# }}}

# Go Compiler {{{
export PATH=$PATH:/usr/local/go/bin
# }}}

# }}}

# zsh-syntax-highlighting; should be last. {{{
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
# }}}

# vim:foldmethod=marker:foldlevel=0
