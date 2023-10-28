# hostname
HOST="macbook"

# aliases
alias EX='/Volumes'
alias FE='cd ~/projects/ffam-fplus-web'
alias BE='cd ~/projects/fplus-loan-app'

# kubectl/gcp
export USE_GKE_GCLOUD_AUTH_PLUGIN=True

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
source "$HOME/dotfiles/.env"
term=$(echo $TERM_EMULATOR | tr "[:upper:]" "[:lower:]")
if [ $term = "iterm" ] && [ -e "${HOME}/.iterm2_shell_integration.zsh" ]; then
  source "${HOME}/.iterm2_shell_integration.zsh";
fi

# jira-cli: https://github.com/ankitpokhrel/jira-cli
if [ -e "$HOME/.secrets/JIRA_API_TOKEN" ]; then
  export JIRA_API_TOKEN="$(cat $HOME/.secrets/JIRA_API_TOKEN)";
fi
