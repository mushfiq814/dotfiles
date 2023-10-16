# function level profiling
zmodload zsh/zprof
# use these at the end of the zshrc
# zprof > /tmp/zshprof.2

# ----------------------------------- #

# command level profiling
# zmodload zsh/datetime
# setopt promptsubst
# PS4='+$EPOCHREALTIME %N:%i> '
# exec 3>&2 2> startlog.$$
# setopt xtrace prompt_subst

# use these at the end of the zshrc
# unsetopt xtrace
# exec 2>&3 3>&-
