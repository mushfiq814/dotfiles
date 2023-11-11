# get env specific values
source "$HOME/dotfiles/.env"

# General Zsh settings {{{

# Enable colors
autoload -Uz colors && colors
# Change dir without cd
setopt AUTO_CD
# enable comments in interactive mode
setopt INTERACTIVE_COMMENTS
# enable wildcard expansion
setopt globsubst

if [[ $ENABLE_KITTY -eq 1 ]]; then
  # for kitty to show ranger previews
  export TERM="xterm-kitty"
else
  # for tmux to display colors properly
  export TERM="xterm-256color"
fi

# }}}

# Editing {{{

# Default Editor
export EDITOR=nvim

# vi keybindings
bindkey -v
export KEYTIMEOUT=1

# Edit line in $EDITOR with ctrl-e:
autoload edit-command-line
zle -N edit-command-line
bindkey '^e' edit-command-line

# }}}

# History {{{

# enable history
export HISTSIZE=10000
export SAVEHIST=$HISTSIZE
export HISTFILE=~/.zsh_history

# If a new command line being added to the history list duplicates an older
# one, the older command is removed from the list
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS

# share history between shells
setopt SHARE_HISTORY
setopt APPEND_HISTORY

# }}}

