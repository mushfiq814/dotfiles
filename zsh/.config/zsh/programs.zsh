# Fuzzy Finder
source "$HOME/dotfiles/.env"
if [[ -e $FZF_FILES_DIR/"completion.zsh" && $ENABLE_ZSH_COMP -eq 1 ]]; then
  source $FZF_FILES_DIR/"completion.zsh";
fi
if [ -e $FZF_FILES_DIR/"key-bindings.zsh" ]; then
  source $FZF_FILES_DIR/"key-bindings.zsh";
fi

# Yarn
if [ -d "$HOME/.yarn/bin" ]; then
  export PATH="$HOME/.yarn/bin:$PATH";
fi
if [ -d "$HOME/.config/yarn/global/node_modules/.bin" ]; then
  export PATH="$HOME/.config/yarn/global/node_modules/.bin:$PATH";
fi

# Go Compiler
if [ -d "/usr/local/go/bin" ]; then
  export PATH="$PATH:/usr/local/go/bin";
fi

# local bin
if [ -d "$HOME/.local/bin" ]; then
  export PATH="$PATH:$HOME/.local/bin";
fi

# Spicetify
if [ -d "$HOME/.spicetify" ]; then
  export PATH="$PATH:$HOME/.spicetify";
fi

# bitwarden
if [ -e "$HOME/.secrets/BW_SESSION" ]; then
  export BW_SESSION="$(cat $HOME/.secrets/BW_SESSION)";
fi

# Colorful Man Pages
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'
