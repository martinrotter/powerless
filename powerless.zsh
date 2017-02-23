######################################
### This is the ZSH powerless script.
######################################
### Simply source this script into
### your .zshrc.
### Make sure your .zshrc does not
### contain any conflicting code.
######################################


###################
### Prompt section.
###################

# Set options.
setopt PROMPT_SUBST

# Specify common variables.
arrow_character='\ue0b0'
newline=$'\n'

get-arrow() {
  if [[ "$#" == "2" ]]; then
    echo -e "%F{$1}%K{$2}$arrow_character%f%k"  
  else
    echo -e "%F{$1}$arrow_character %f"
  fi
}

get-date() {
  echo -e "%F{$1}%K{$2} %* %W %f%k"
}

get-pwd() {
  echo "%F{$1}%K{$2} %~ %k$(get-arrow $2)"
}

get-last-code() {
  if [[ "$last_code" == "0" ]]; then
    echo -e "$(get-arrow $5 $2)%F{$1}%K{$2} $last_code %f%k$(get-arrow $2 $4)"
  else
    echo -e "$(get-arrow $5 $3)%F{$1}%K{$3} $last_code %f%k$(get-arrow $3 $4)"
  fi
}

preexec() {
  # This makes sure that every (but not first) prompt has empty line above itself.
  is_first_prompt="no"
}

precmd() {
  last_code=$?

  p_code=$(get-last-code black white red cyan yellow)
  p_date=$(get-date black yellow)
  p_pwd=$(get-pwd black cyan)
  
  if [[ "$is_first_prompt" == "no" ]]; then
    print
  fi
}

PROMPT='$p_date$p_code$p_pwd'

make-me-powerless() {
  
}
