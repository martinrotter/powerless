################################################
### This is the ZSH powerless main script.
###
### How to call: source powerless.zsh <ENABLE_CUSTOM_COLORS>
################################################

# Set options and settings.
setopt PROMPT_SUBST
setopt PROMPT_SP

# Specify colors.
if [[ $1 == true ]]; then
  color_text="0"
  color_user_host="79"
  color_code_wrong="196"
  color_pwd="75"
  color_git_ok="79"
  color_git_dirty="203"
else
  color_text="black"
  color_user_host="green"
  color_code_wrong="red"
  color_pwd="blue"
  color_git_ok="green"
  color_git_dirty="red"
fi

# Specify common variables.
prompt_char='$'
rc='%{%f%k%}'

get-user-host() {  
  [[ -n "$SSH_CLIENT" ]] && echo -n "%{%F{$1}%K{$2}%} %n@%M $rc"
}

get-pwd() {
  echo -n "%{%F{$1}%K{$2}%} %~ $rc"
}

get-git-info() { 
  local git_branch=$(git symbolic-ref --short HEAD 2> /dev/null)
   
  if [[ -n "$git_branch" ]]; then
    git diff --quiet --ignore-submodules --exit-code HEAD > /dev/null 2>&1
    
    if [[ "$?" != "0" ]]; then
      git_symbols="❗ "
      back_color=$3
    else
      back_color=$2
    fi
  
    echo -n "%{%F{$1}%K{$back_color}%} $git_branch $git_symbols$rc"
  fi
}

get-last-code() {
  [[ (-n "$last_code") && ($last_code -ne 0) ]] && echo -n "%{%F{$1}%K{$2}%} ✘ $last_code $rc"
}

get-prompt() {
  echo -n "\n" && ([[ "$(print -P "%#")" == "#" ]] && echo -n "%{%F{$color_code_wrong}%} $prompt_char$rc%{\e[0m%} " || echo -n " $prompt_char%{\e[0m%} " )
}

powerless-prompt() {
  get-user-host $color_text $color_user_host
  get-last-code $color_text $color_code_wrong
  get-pwd $color_text $color_pwd
  get-git-info $color_text $color_git_ok $color_git_dirty
  get-prompt
}

precmd-powerless() {
  last_code=$?
  
  if [[ $is_first_prompt -eq 999 ]]; then
    echo -n "\n"
  else
    is_first_prompt=999
  fi
}

# Attach the hook functions.
[[ ${precmd_functions[(r)precmd-powerless]} != "precmd-powerless" ]] && precmd_functions+=(precmd-powerless)

# Set the prompts.
PROMPT='$(powerless-prompt)'
