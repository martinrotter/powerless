################################################
### This is the ZSH powerless main script.
################################################

# Set options and settings.
setopt PROMPT_SUBST
setopt PROMPT_SP
ZLE_RPROMPT_INDENT=0

# Specify colors.
powerless_color_text="black"
powerless_color_user_host="84"
powerless_color_code_ok="7"
powerless_color_code_wrong="red"
powerless_color_pwd="75"
powerless_color_git="202"

# Specify common variables.
prompt_char='➥'

get-user-host() {
  echo -n "%{%F{$1}%K{$2}%} %n@%M %{%f%k%}"
}

get-pwd() {
  echo -n "%{%F{$1}%K{$2}%} %~ %{%f%k%}"
}

get-git-info() { 
  local git_branch=$(git symbolic-ref --short HEAD 2> /dev/null)
   
  if [[ -n "$git_branch" ]]; then  
    git diff --quiet --ignore-submodules --exit-code HEAD > /dev/null 2>&1
    
    [[ "$?" != "0" ]] && git_symbols="❗ "
  
    echo -n "%{%F{$1}%K{$2}%} $git_branch $git_symbols%{%f%k%}"
  fi
}

get-last-code() {
  [[ $last_code -eq 0 ]] && echo -n " ✔ $last_code " || echo -n "%{%F{$3}%} ✘ $last_code %{%f%k%}"
}

get-prompt() {
  echo -n "\n" && ([[ "$(print -P "%#")" == "#" ]] && echo -n "%{%F{$powerless_color_code_wrong}%} $prompt_char%{%f%k%}\e[0m " || echo -n " $prompt_char%{\e[0m%} " )
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
