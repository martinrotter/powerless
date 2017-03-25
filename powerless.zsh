################################################
### This is the ZSH powerless main script.
################################################

# Set options and settings.
setopt PROMPT_SUBST
setopt PROMPT_SP
ZLE_RPROMPT_INDENT=0

# Specify colors.
powerless_color_text="black"
powerless_color_user_host="172"
powerless_color_code_ok="7"
powerless_color_code_wrong="red"
powerless_color_pwd="75"
powerless_color_git="114"

# Specify common variables.
prompt_char='➥'
arrow_character=$'\ue0b0'
newline=$'\n'

store-colors() {
  fg_color=$1 && bg_color=$2
}

get-arrow() {
  [[ $# -eq 2 ]] && echo -n "%F{$1}%K{$2}$arrow_character%f%k" || echo -n "%F{$1}$arrow_character%f%k"
}

get-user-host() {
  echo -n "%{%F{$1}%K{$2}%} ☻ %n@%M %{%f%k%}"
  store-colors $1 $2
}

get-pwd() {
  echo -n "$(get-arrow $bg_color $2)%F{$1}%K{$2} 📂 %~ %f%k"
  store-colors $1 $2
}

get-git-info() {
  git rev-parse --abbrev-ref HEAD 2> /dev/null | read git_branch
   
  if [[ "$?" == "0" ]]; then  
    git diff --quiet --ignore-submodules HEAD > /dev/null 2>&1
    
    [[ "$?" != "0" ]] && git_symbols="❗ "
  
    echo -n "$(get-arrow $bg_color $2)%F{$1}%K{$2} \ue0a0 $git_branch $git_symbols%k$(get-arrow $2)%f%k"
  else
    echo -n "$(get-arrow $bg_color)%f%k"
  fi

  store-colors $1 $2
}

get-last-code() {
  [[ $last_code -eq 0 ]] && echo -n " ✔ $last_code " || echo -n "%{%F{$3}%} ✘ $last_code %{%f%k%}"
}

get-prompt() {
  echo -n "$newline" && ([[ "$(print -P "%#")" == "#" ]] && echo -n "%{%F{$powerless_color_code_wrong}%} $prompt_char%{%f%k%}\e[0m " || echo -n " $prompt_char%{\e[0m%} " )
}

powerless-prompt() {
  get-user-host $powerless_color_text $powerless_color_user_host
  get-pwd $powerless_color_text $powerless_color_pwd
  get-git-info $powerless_color_text $powerless_color_git
  get-prompt
}

precmd-powerless() {
  last_code=$?
  
  if [[ $is_first_prompt -eq 999 ]]; then
    printf '%*s\c' $(($(tput cols) - 4 - ${#last_code})) ""
    print -P "$(get-last-code $powerless_color_text $powerless_color_code_ok $powerless_color_code_wrong)\n"
  else
    is_first_prompt=999
  fi
}

# Attach the hook functions.
precmd_functions+=(precmd-powerless)

# Set the prompts.
PROMPT='$(powerless-prompt)'
