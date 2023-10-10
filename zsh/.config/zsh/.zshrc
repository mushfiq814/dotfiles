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

