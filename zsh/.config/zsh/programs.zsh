# Node Version Manager (nvm)
# resolve node path for nvm version
# export NODE_PATH=/home/mushfiq/.nvm/versions/node/v18.0.0/bin/node
# export PATH="$(dirname $NODE_PATH):$PATH"
export PATH="/home/mushfiq/.local/share/npm/bin:$PATH"

# NVM slows down zsh initialization by a lot.
# This enables lazy loading nvm
lazynvm() {
  # echo 'lazy loading nvm...'
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

# Fuzzy Finder
FZF_FILES_DIR="$TERMUX_APP__FILES_DIR/usr/share/fzf"
if [ -d "$FZF_FILES_DIR" ]; then
  source $FZF_FILES_DIR/completion.zsh;
  source $FZF_FILES_DIR/key-bindings.zsh;
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
