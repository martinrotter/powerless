################################################
### This is the ZSH powerless main script.
################################################

# Set options and settings.
setopt PROMPT_SUBST
setopt PROMPT_SP
ZLE_RPROMPT_INDENT=0

# Specify colors.
powerless_color_text="black"
powerless_color_date="172"
powerless_color_code_ok="7"
powerless_color_code_wrong="red"
powerless_color_pwd="75"
powerless_color_git="114"

# Specify common variables.
prompt_char=$'\u2023'
arrow_character=$'\ue0b0'
newline=$'\n'

store-colors() {
  fg_color=$1 && bg_color=$2
}

get-arrow() {
  [[ $# -eq 2 ]] && echo -n "%F{$1}%K{$2}$arrow_character%f%k" || echo -n "%F{$1}$arrow_character%f"
}

get-date() {
  echo -n "%{%F{$1}%K{$2}%} 📅 %T %W %{%f%k%}"
  store-colors $1 $2
}


get-pwd() {
  echo -n "$(get-arrow $bg_color $2)%F{$1}%K{$2} 📂 %~ "
  store-colors $1 $2
}

get-git-info() {
  [[ -n "$vcs_info_msg_0_" ]] && echo -n "$(get-arrow $bg_color $2)%F{$1}%K{$2} \ue0a0 $vcs_info_msg_0_$(git diff --numstat | awk '{print " +" $1 " -" $2}') %k$(get-arrow $2)" || echo -n "%k$(get-arrow $bg_color)"
  store-colors $1 $2
}

get-last-code() {
  if [[ $last_code -eq 0 ]]; then
    echo -n "$(get-arrow $bg_color $2)%{%F{$1}%K{$2}%} ✔ $last_code "
    store-colors $1 $2
  else
    echo -n "$(get-arrow $bg_color $3)%{%F{$1}%K{$3}%} ✘ $last_code "
    store-colors $1 $3
  fi
}

get-prompt() {
  echo -n "$newline $prompt_char "
}

powerless-prompt() {
  get-date $powerless_color_text $powerless_color_date
  get-last-code $powerless_color_text $powerless_color_code_ok $powerless_color_code_wrong
  get-pwd $powerless_color_text $powerless_color_pwd
  get-git-info $powerless_color_text $powerless_color_git
  get-prompt
}

precmd-powerless() {
  last_code=$?  
  [[ $is_first_prompt -eq 999 ]] && print || is_first_prompt=999
  vcs_info
}

# Attach the hook functions.
precmd_functions+=(precmd-powerless)

# Setup vcs_info (Git).
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' use-simple true
zstyle ':vcs_info:*' check-for-changes false
zstyle ':vcs_info:git*' formats "%b"
zstyle ':vcs_info:git*' actionformats "%b (%a)"

# Set the prompts.
PROMPT='$(powerless-prompt)'
