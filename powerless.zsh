################################################
### This is the ZSH powerless script.
################################################
### Simply source this script into your .zshrc.
### Make sure your .zshrc does not contain any
### conflicting code.
################################################

# Set options and settings.
setopt PROMPT_SUBST
setopt PROMPT_SP
ZLE_RPROMPT_INDENT=0

# Specify colors.
color_text="black"
color_date="172"
color_code_ok="7"
color_code_wrong="red"
color_pwd="75"
color_git="114"

# Specify common variables.
prompt_char=$'\u2023'
arrow_character=$'\ue0b0'
arrow_back_character=$'\uE0B2'
newline=$'\n'

alias store-colors='fg_color=$1 bg_color=$2'

get-arrow() {
  [[ $# -eq 2 ]] && echo -n "%F{$1}%K{$2}$arrow_character%f%k" || echo -n "%F{$1}$arrow_character%f"
}

get-back-arrow() {
  [[ $# -eq 2 ]] && echo -n "%{%F{$1}%K{$2}%}$arrow_back_character%{%f%k%}" || echo -n "%{%F{$1}%}$arrow_back_character%{%f%}"
}

get-date() {
  echo -n "%{%F{$1}%K{$2}%} %T %W %{%f%k%}"
  store-colors
}

get-pwd() {
  echo -n "$(get-arrow $bg_color $2)%F{$1}%K{$2} %~ "
  store-colors
}

get-git-info() {
  echo -n "$(get-arrow $bg_color $2)%F{$1}%K{$2} \ue0a0 $vcs_info_msg_0_ %k$(get-arrow $2)"
  store-colors
}

get-last-code() {
  [[ $last_code -eq 0 ]] && echo -n "$(get-back-arrow $2)%{%F{$1}%K{$2}%} $last_code " || echo -n "$(get-back-arrow $3)%{%F{$1}%K{$3}%} $last_code "
}

get-prompt() {
  echo -n "$newline $prompt_char "
}

powerless-prompt() {
  get-date $color_text $color_date

  get-pwd $color_text $color_pwd
  get-git-info $color_text $color_git
  get-prompt
}

powerless-rprompt() {
  get-last-code $color_text $color_code_ok $color_code_wrong
}

# Hook functions.
preexec-powerless() {
  # This makes sure that every (but not first) prompt has empty line above itself.
  is_first_prompt=999
}

precmd-powerless() {
  last_code=$?  
  [[ $is_first_prompt -eq 999 ]] && print
  vcs_info
}

# Attach the hook functions.
preexec_functions+=(preexec-powerless)
precmd_functions+=(precmd-powerless)

# Setup vcs_info (Git).
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes false
zstyle ':vcs_info:git*' formats "%b"
zstyle ':vcs_info:git*' actionformats "%b (%a)"

# Set the prompts.
PROMPT='$(powerless-prompt)'
RPROMPT='$(powerless-rprompt)'