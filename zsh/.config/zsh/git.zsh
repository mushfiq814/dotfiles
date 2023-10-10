autoload -Uz vcs_info
# only enable git since this is the only vcs I care about (for now)
zstyle ':vcs_info:*' enable git
# run vcs_info just before a prompt is displayed (precmd)
precmd() { vcs_info }
precmd_functions+=( precmd_vcs_info )
precmd_functions+=( set_prompt )
# precmd_functions+=( fetch )
# enable substitution in the prompt
setopt prompt_subst

# only enable git since this is the only vcs I care about (for now)
zstyle ':vcs_info:*' enable git
# Enable checking for (un)staged changes, enabling use of %u and %c
zstyle ':vcs_info:*' check-for-changes true
# Set custom strings for an unstaged vcs repo changes
zstyle ':vcs_info:*' unstagedstr '%F{red}●%f'
zstyle ':vcs_info:*' stagedstr   '%F{green}●%f'
# Set the format of the Git information for vcs_info
zstyle ':vcs_info:git:*' formats       '  %b %m%u%c'
zstyle ':vcs_info:git:*' actionformats '  %b|%a %m%u%c'

# Git branch FontAwesome Icons
#   ⚡

