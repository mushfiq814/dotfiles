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
