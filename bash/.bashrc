# Prompt
PS1='\[$(tput bold)\]\[$(tput setaf 3)\]\u\[$(tput setaf 7)\]:\[$(tput setaf 1)\]\h\[$(tput setaf 5)\]~$ \[$(tput sgr0)\]'

# Directory Colors in `ls`
LS_COLORS='ow=1;30;42:di=1;30;42' 
export LS_COLORS

# Default Editor
export EDITOR=nvim

# Aliases
alias ls='ls --color=auto -1'
alias ll='ls -alF'
alias la='ls -la'
alias l='ls -CF'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Add an "alert" alias for long running commands. Use like so: sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias brc='sudo nvim ~/.bashrc'
alias v='nvim'
alias vrc='sudo vim /etc/vim/vimrc'
alias nvrc='nvim ~/.config/nvim/init.vim'

alias usf='cd /mnt/c/Users/mushf/OneDrive/USF'
alias yt='youtube-dl -x --audio-format mp3'
alias main-dm='ssh -t root@64.225.5.39 "cd ../var/www/html/wp-content/themes/disciplined-minds; bash"'
alias make='make -s' # silent mode for make (suppress output)

# Functions
function transferJSToDMServer() {
  scp $1 root@64.225.5.39:/var/www/html/wp-content/themes/disciplined-minds/js
}

function convertWinPath() {
  echo "'$1'" | sed 's/[\]/\//g' | sed 's/C:/\/mnt\/c/g'
}

# History
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s checkwinsize

# enable programmable completion features
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export DISPLAY=localhost:0

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
