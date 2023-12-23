# get env specific values
# shellcheck source=../../../.env
source "$HOME/dotfiles/.env"

if [[ ${OSTYPE:0:6} = "darwin" ]]; then
  source "$HOME/.config/zsh/macos.zsh"
elif [[ ${OSTYPE:0:13} = "linux-android" ]]; then
  source "$HOME/.config/zsh/termux.zsh"
else
  source "$HOME/.config/zsh/linux.zsh"
fi
source "$HOME/.config/zsh/aliases.zsh"
source "$HOME/.config/zsh/functions.zsh"
source "$HOME/.config/zsh/misc.zsh"
source "$HOME/.config/zsh/git.zsh"
source "$HOME/.config/zsh/prompt.zsh"
source "$HOME/.config/zsh/programs.zsh"
if [[ $ENABLE_ZSH_COMP -eq 1 ]]; then
  source "$HOME/.config/zsh/completion.zsh"
fi

# Zsh Plugins; NOTE: SHOULD BE LAST.
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null

# exit functions
set_prompt
if [[ $SHOW_SYS_FETCH -eq 1 ]]; then fetch; fi
if [[ $ENABLE_LAUNCHER -eq 1 ]]; then launcher; fi
