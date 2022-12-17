#=============================================================================
#                                  █████        ██████  ███           
#                                 ░░███        ███░░███░░░            
#  █████████████  █████ ████ █████ ░███████   ░███ ░░░ ████   ████████
# ░░███░░███░░███░░███ ░███ ███░░  ░███░░███ ███████  ░░███  ███░░███ 
#  ░███ ░███ ░███ ░███ ░███░░█████ ░███ ░███░░░███░    ░███ ░███ ░███ 
#  ░███ ░███ ░███ ░███ ░███ ░░░░███░███ ░███  ░███     ░███ ░███ ░███ 
#  █████░███ █████░░██████████████ ████ █████ █████    █████░░███████ 
# ░░░░░ ░░░ ░░░░░  ░░░░░░░░░░░░░░ ░░░░ ░░░░░ ░░░░░    ░░░░░  ░░░░░███ 
#                 |                 ,- o                         ░███ 
#         ,-, ,-. |-.  ,-. ,-. ;-.  |  . ,-:                     █████
#          /  `-. | |  |   | | | |  |- | | |                    ░░░░░
#         '-' `-' ' '  `-' `-' ' '  |  ' `-|
#                                  -'    `-'
#=============================================================================

# Aliases and Variables {{{

# source this file
alias soz='source ~/.zshrc'

# exa (an ls alternative); NOTE: overrides the ls aliases
alias ls='exa --oneline --icons'
alias la='exa --long --all --icons'
alias lg='exa --long --all --icons --git'

# bat (a cat alternative)
alias cat='bat'

# grep aliases
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# git aliases
alias ga='git add'
alias gs='git status'
alias gl=prettyGitLog
alias gco='git checkout'
alias gc='git commit'
alias gb='git branch'
alias gfo='git fetch origin'
alias gcod='git checkout dev'
alias gpod='git pull origin dev'

# silent mode for make (suppress output)
alias make='make -s'

# youtube download mp3
alias yt='youtube-dl -x --audio-format mp3'

# config files aliases
alias v='nvim --listen /tmp/nvim-server.pipe'
alias brc='v ~/.bashrc'
alias zrc='v ~/.zshrc'
alias vrc='v /etc/vim/vimrc'
alias nvrc='v ~/.config/nvim/init.vim'
alias trc='v ~/.tmux.conf'

# filesystem aliases

alias main-dm='ssh -t root@104.236.227.167 "cd ../var/www/html/wp-content/themes/disciplined-minds; bash"'
alias DW='cd ~/downloads'
alias PR=showProjects

# package manager
alias sai='sudo apt install'

# npm
alias nr='npm run'
alias nrd='npm run dev'
alias nrs='npm run start'

# open in default program
# alias open='powershell.exe Invoke-Item'
alias open='xdg-open'

# python3 and pip3; WARNING: replaces pip version2 command name
alias pip='python3 -m pip'

# launch vimwiki
alias vw='v ~/vimwiki/index.md'

# autolaunch ytfzf with thumbnail support
alias ytfzf='ytfzf -t'

# neofetch
alias fetch='neofetch --backend kitty --source ~/Pictures/wallpapers/UvSvAAP.jpg --disable gpu --size 30% --xoffset 2 --yoffset 1 --gap 5'

alias fd='fdfind'

alias wifictl='nmtui'

# csv viewer (tidy-viewer)
alias tv='tidy-viewer'

# blender
alias blender='~/.steam/debian-installation/steamapps/common/Blender/blender'

# i3lock
alias lock='i3lock -i ~/Pictures/wallpapers/xcwwpikoxeh31.png -t -c "#000000"'

# }}}

# Functions {{{

# showProjects {{{
function showProjects() {
  cd ~/projects/$('ls' ~/projects | fzf)
}
# }}}

# prettyGitLog {{{
function prettyGitLog() {
	# format strings; check man git log for more `placeholders`
	local authorDate='%aI'            # author date
	local authorDateRelative='%ar'    # author date relative
	# local commitDate='%cI'            # commit date relative
	# local commitDateRelative='%cr'    # commit date relative
	local authorName='%an'            # author name
	local shortCommitHash='%h'        # abbreviated commit hash
	# local longCommitHash='%H'         # commit hash
	local subject='%s'                # subject
	# local REFP='%d'   # reference pointer(branch, tag) names
	
	local format=""
	format+="%C(Magenta)$shortCommitHash  %C(reset)"
	format+="%C(Yellow)$authorDate %C(reset)"
	format+="(%C(Green)$authorDateRelative%C(reset))"
	format+="    %x09" # tab character
	format+="%C(Cyan)$authorName: %C(reset)"
	format+="$subject"

	# call git log with custom format and append any flags passed in
	git log $@ --pretty=$format
}
# }}}

# texclean {{{
function texclean() {
  rm -i *.log *.aux
}
# }}}

# convertWinPath {{{
function convertWinPath() {
  echo "'$1'"
  echo "'$1'" | sed 's/\\/\//g'
  echo "'$1'" | sed 's/\\/\//g' | sed 's/C:/\/mnt\/c/g'
}
# }}}

# vlcplay {{{
function vlcplay() {
	vlc="C:\Program Files (x86)\VideoLan\VLC\\\vlc.exe"
	pth="$(echo $1 | sed 's/\/home\/mushfiq\/windows/C:/g; s/\//\\/g')"
	powershell.exe $vlc $pth
}
# }}}

# md2html: Convert from markdown to html {{{
function md2html() {
	css="~/dotfiles/pandoc/mvp.css"
	html="$HOME/dotfiles/pandoc/template.html"
	out="$(basename $1 .md).html"

	pandoc $1                       \
	       --to html                \
	       --standalone             \
	       --css $css               \
	       --template $html         \
	       --output $out            \
	       --mathjax                \
	       --highlight-style tango

	# open in browser
	# powershell.exe Invoke-Item $out
}
# }}}

# changeBG {{{
function changeBG() {
	pre="C:\/Users\/mushf\/Downloads\/screenshots"
	img="$pre\/$1.png"
	term1="/mnt/c/Users/mushf/AppData/Local/Packages/Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe/LocalState/settings.json"
	term2="/mnt/c/Users/mushf/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json"
	sed -i "0,/\"backgroundImage\"/s/\(\"backgroundImage\"\s*:\s*\"\).*\(\",\s*\)/\1$img\2/" $term1
	sed -i "0,/\"backgroundImage\"/s/\(\"backgroundImage\"\s*:\s*\"\).*\(\",\s*\)/\1$img\2/" $term2
}
# }}}

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

# Prompt {{{

# Colors {{{
BB0='0'  # black
RE0='1'  # red
GR0='2'  # green
YE0='3'  # yellow
BL0='4'  # blue
MA0='5'  # purple
CY0='6'  # cyan
WH0='7'  # white
BB1='8'  # bright black
RE1='9'  # bright red
GR1='10' # bright green
YE1='11' # bright yellow
BL1='12' # bright blue
MA1='13' # bright purple
CY1='14' # bright cyan
WH1='15' # bright white
# }}}

# Prompt Helpers {{{
COL_BAR='%F{$RE0}%f'\
'%K{$RE0}%F{$YE0}░▒▓█%k%f'\
'%K{$YE0}%F{$GR0}░▒▓█%k%f'\
'%K{$GR0}%F{$BL0}░▒▓%k%f'\
'%F{$BL0}%f '

SUFFIX="%(!.%F{$YE0}%n%f.)%(!.%F{$YE0}.%F{$BL1})"$(printf "\u276f%.0s" {1..$SHLVL})"%f"
# }}}

# function to set prompt
set_prompt () {
	PROMPT="%B"
  # PROMPT+="💻 "
	PROMPT+="%F{$YE1}%n%f"
	PROMPT+="%F{$MA1}:%f"
  PROMPT+="%F{$GR1}%m %f"
	PROMPT+="["
	PROMPT+="%F{$CY1}%1d%f"
	PROMPT+="]"
	PROMPT+="%F{$MA1}${vcs_info_msg_0_}%f"
	PROMPT+="%(1j. .)"
  # PROMPT+="%(1j. 💬.)"
	PROMPT+=" %B${SUFFIX}%b "
  # PROMPT+="$COL_BAR"
}

# }}}

# Version Control Info for Prompt {{{

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

# }}}

# General Zsh settings {{{

# Enable colors
autoload -Uz colors && colors
# Change dir without cd
setopt AUTO_CD
# enable comments in interactive mode
setopt INTERACTIVE_COMMENTS
# for tmux to display colors properly
export TERM="screen-256color"

# }}}

# Zsh Completion {{{

# enable completion system
autoload -Uz compinit

zstyle ':completion:*' menu select
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
zmodload zsh/complist
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# initialize completion and ignore all insecure files and dirs
compinit -i

# Include hidden files.
_comp_options+=(globdots)

# }}}

# Program Specific Settings {{{

# Node Version Manager (NVM) {{{

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

# }}}

# Yarn {{{
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
# }}}

# Fuzzy Finder {{{
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source /usr/share/fzf/completion.zsh
source /usr/share/fzf/key-bindings.zsh
# }}}

# Go Compiler {{{
export PATH=$PATH:/usr/local/go/bin
# }}}

# Python Modules {{{
export PATH=$PATH:$HOME/.local/bin
# }}}

# Colorful Man Pages {{{
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'
# }}}

# Fly.io {{{
export FLYCTL_INSTALL="/home/mushfiq/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"
# }}}

# Spicetify {{{
export PATH=$PATH:/home/mushfiq/.spicetify
# }}}

# bitwarden {{{
# shell completions
# eval "$(bw completion --shell zsh); compdef _bw bw;"
export BW_SESSION="$(cat ~/.secrets/BW_SESSION)"
# }}}

# github cli {{{
# shell completions
# eval "$(gh completion -s zsh); compdef _gh gh;"

# }}}

# }}}

# Zsh Plugins; NOTE: SHOULD BE LAST. {{{
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
# }}}

# Call function {{{
set_prompt
'cat' ~/pictures/ascii/hi.ascii
# fetch
# }}}

# vim:foldmethod=marker:foldlevel=0
