# get env specific values
# shellcheck source=../../dotfiles/.env
source "$HOME/dotfiles/.env"

if [[ ${OSTYPE:0:6} = "darwin" ]]; then
  # shellcheck source=./macos.zsh
  source "$HOME/.config/zsh/macos.zsh"
elif [[ ${OSTYPE:0:13} = "linux-android" ]]; then
  # shellcheck source=./termux.zsh
  source "$HOME/.config/zsh/termux.zsh"
else
  # shellcheck source=./linux.zsh
  source "$HOME/.config/zsh/linux.zsh"
fi
# shellcheck source=./aliases.zsh
source "$HOME/.config/zsh/aliases.zsh"
# shellcheck source=./functions.zsh
source "$HOME/.config/zsh/functions.zsh"
# shellcheck source=./misc.zsh
source "$HOME/.config/zsh/misc.zsh"
if [[ $ENABLE_ZSH_GIT -eq 1 ]]; then
  # shellcheck source=./git.zsh
  source "$HOME/.config/zsh/git.zsh"
fi
# shellcheck source=./prompt.zsh
source "$HOME/.config/zsh/prompt.zsh"
# shellcheck source=./programs.zsh
source "$HOME/.config/zsh/programs.zsh"
if [[ $ENABLE_ZSH_COMP -eq 1 ]]; then
  # shellcheck source=./completion.zsh
  source "$HOME/.config/zsh/completion.zsh"
fi

# Zsh Plugins; NOTE: SHOULD BE LAST.
if [[ $ENABLE_ZSH_PLUGINS -eq 1 ]]; then
  source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
  source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
fi

# exit functions
set_prompt
if [[ $SHOW_SYS_FETCH -eq 1 ]]; then fetch; fi
if [[ $ENABLE_LAUNCHER -eq 1 ]]; then launcher; fi
