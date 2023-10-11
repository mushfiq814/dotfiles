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
source "$HOME/.config/zsh/completion.zsh"
source "$HOME/.config/zsh/programs.zsh"

# Zsh Plugins; NOTE: SHOULD BE LAST.
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null

# exit functions
set_prompt
fetch

