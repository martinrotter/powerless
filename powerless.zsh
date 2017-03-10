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
  local git_is=$?
   
  if [[ "$git_is" == "0" ]]; then
    local git_status="$(git status --ignore-submodules=dirty --porcelain 2> /dev/null)"
    local git_symbols=""
    
    [[ $git_status =~ ($'\n'|^).M ]] && git_symbols="${git_symbols}M"
    [[ $git_status =~ ($'\n'|^)A ]] && git_symbols="${git_symbols}A"
    [[ $git_status =~ ($'\n'|^).D ]] && git_symbols="${git_symbols}D"
    [[ $git_status =~ ($'\n'|^)[MAD] && ! $git_status =~ ($'\n'|^).[MAD\?] ]] && git_symbols="${git_symbols}C"
    [[ $git_status =~ ($'\n'|^)\\?\\? ]] && git_symbols="${git_symbols}U"
  
    echo -n "$(get-arrow $bg_color $2)%F{$1}%K{$2} \ue0a0 $git_branch $(echo $git_symbols | perl -ne 's/(\w(?!$))/$1•/g; print') %k$(get-arrow $2)%f%k"
  else
    echo -n "$(get-arrow $bg_color)%f%k"
  fi

  store-colors $1 $2
}

get-last-code() {
  [[ $last_code -eq 0 ]] && echo -n " ✔ $last_code " || echo -n "%{%F{$3}%} ✘ $last_code %{%f%k%}"
}

get-prompt() {
  echo -n "$newline" && ([[ "$(print -P "%#")" == "#" ]] && echo -n "%{%F{$powerless_color_code_wrong}%} $prompt_char%{%f%k%} " || echo -n " $prompt_char " )
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
