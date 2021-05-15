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

# ls aliases (try saying that 5 times)
# alias ls='ls --color=auto -1'
# alias ll='ls -alF'
# alias la='ls -la'
# alias l='ls -CF'

# exa (an ls alternative); NOTE: overrides the ls aliases
alias ls='exa --oneline --icons'
alias la='exa --long --all --icons'
alias lg='exa --long --all --icons --git'

# bat (a cat alternative)
alias bat='batcat'

# grep aliases
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# git aliases
alias ga='git add'
alias gs='git status'
alias gl=prettyGitLog

# silent mode for make (suppress output)
alias make='make -s'

# youtube download mp3
alias yt='youtube-dl -x --audio-format mp3'

# config files aliases
alias brc='$EDITOR ~/.bashrc'
alias zrc='$EDITOR ~/.zshrc'
alias v='$EDITOR'
alias vrc='$EDITOR /etc/vim/vimrc'
alias nvrc='$EDITOR ~/.config/nvim/init.vim'
alias wrc='$EDITOR /mnt/c/Users/mushf/AppData/Local/Packages/Microsoft.WindowsTerminal_*/LocalState/settings.json'
# alias wrc='$EDITOR /mnt/c/Users/mushf/AppData/Local/Packages/Microsoft.WindowsTerminalPreview_*/LocalState/settings.json'
alias frc='$EDITOR /mnt/c/Users/mushf/AppData/Roaming/Mozilla/Firefox/Profiles/3qkb6j9y.default-1586366854597/chrome'
alias trc='$EDITOR ~/.tmux.conf'

# filesystem aliases
alias dm='cd /mnt/c/Users/mushf/disciplined-minds'
alias usf='cd /mnt/c/Users/mushf/OneDrive/USF'
alias main-dm='ssh -t root@64.225.5.39 "cd ../var/www/html/wp-content/themes/disciplined-minds; bash"'

# open in firefox
alias fox='powershell.exe Start-Process -FilePath Firefox -ArgumentList'

# open in default program
alias open='powershell.exe Invoke-Item'

# python3 and pip3; WARNING: replaces pip version2 command name
alias pip='python3 -m pip'

# launch vimwiki
alias vw='$EDITOR ~/windows/vimwiki/index.md'

# }}}

# Functions {{{

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
	git log --pretty=$format $1
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
export HISTSIZE=2000
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

# Version Control Info for Prompt {{{

autoload -Uz vcs_info
# only enable git since this is the only vcs I care about (for now)
zstyle ':vcs_info:*' enable git
# run vcs_info just before a prompt is displayed (precmd)
precmd() {
	vcs_info
}
# enable substitution in the prompt
setopt prompt_subst

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
# NVM slows down zsh initialization by a lot.
# This enables lazy loading nvm 
lazynvm() {
	echo 'lazy loading nvm...'
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
# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# source /usr/share/fzf/completion.zsh
# source /usr/share/fzf/key-bindings.zsh
# }}}

# Go Compiler {{{
export PATH=$PATH:/usr/local/go/bin
# }}}

# Python Modules {{{
export PATH=$PATH:$HOME/.local/bin
# }}}

# WSL PulseAudio Server {{{
export PULSE_SERVER=tcp:localhost
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

COL_BAR='%F{$RE0}%f'\
'%K{$RE0}%F{$YE0}░▒▓█%k%f'\
'%K{$YE0}%F{$GR0}░▒▓█%k%f'\
'%K{$GR0}%F{$BL0}░▒▓%k%f'\
'%F{$BL0}%f '

SUFFIX="%(!.%F{$YE0}%n%f.)%(!.%F{$YE0}.%F{$BL1})"$(printf "\u276f%.0s" {1..$SHLVL})"%f"

PS1="💻 "\
"%F{$YE1}%n%f"\
"%F{$MA1}:%f"\
"%F{$GR1}arch %f"\
"["\
"%F{$CY1}%1d%f"\
"]"\
"%F{$MA1}${vcs_info_msg_0_}%f"\
"%(1j. 💬.)"\
" %B${SUFFIX}%b "
# $COL_BAR\


# }}}

# Zsh Plugins; NOTE: SHOULD BE LAST. {{{
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
# }}}

# vim:foldmethod=marker:foldlevel=0
