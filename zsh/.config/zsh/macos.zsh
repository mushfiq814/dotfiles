# shellcheck source=../../../.env
source "$HOME/dotfiles/.env"

# hostname
HOST="macbook"

# aliases
alias EX='/Volumes'
alias FE='cd ~/projects/ffam-fplus-web'
alias BE='cd ~/projects/fplus-loan-app'

# kubectl/gcp
export USE_GKE_GCLOUD_AUTH_PLUGIN=True

# gcloud
if [ -d "$HOME/google-cloud-sdk/bin" ]; then
  export PATH="$PATH:$HOME/google-cloud-sdk/bin";
fi

# fnm (node version manager - alternative to nvm)
if [ -d "$HOME/Library/Application Support/fnm" ]; then
  export PATH="$HOME/Library/Application Support/fnm:$PATH";
  eval "`fnm env`";
fi

# atlassian cli
if [ -e "$HOME/.secrets/ATLASSIAN_API_TOKEN" ]; then
  export ATLASSIAN_API_TOKEN="$(cat $HOME/.secrets/ATLASSIAN_API_TOKEN)";
fi

# homebrew
if [ -d "/opt/homebrew/bin" ]; then
  PATH="/opt/homebrew/bin:$PATH";
fi

# iterm2
term=$(echo $TERM_EMULATOR | tr "[:upper:]" "[:lower:]")
if [ $term = "iterm" ] && [ -e "${HOME}/.iterm2_shell_integration.zsh" ]; then
  source "${HOME}/.iterm2_shell_integration.zsh";
fi

# jira-cli: https://github.com/ankitpokhrel/jira-cli
if [ -e "$HOME/.secrets/JIRA_API_TOKEN" ]; then
  export JIRA_API_TOKEN="$(cat $HOME/.secrets/JIRA_API_TOKEN)";
fi

# spicetify
if [ -d "$HOME/.spicetify" ]; then
  export PATH="$PATH:$HOME/.spicetify"
fi

# outlook-cli
alias outlook="yarn --cwd $HOME/projects/outlook-cli/ --silent run run"

