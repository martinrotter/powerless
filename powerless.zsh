################################################
### This is the ZSH powerless script.
################################################
### Simply source this script into your .zshrc.
### Make sure your .zshrc does not contain any
### conflicting code.
################################################

# Set options.
setopt PROMPT_SUBST

# Specify colors.
color_text="black"
color_date="172"
color_code_ok="7"
color_code_wrong="red"
color_pwd="75"

# Specify common variables.
arrow_character='\ue0b0'
newline=$'\n'

get-arrow() {
  if [[ $# -eq 2 ]]; then
    echo "%F{$1}%K{$2}$arrow_character%f%k"  
  else
    echo "%F{$1}$arrow_character %f"
  fi
}

get-date() {
  echo "%F{$1}%K{$2} %T %W %f%k"
}

get-pwd() {
  echo "%F{$1}%K{$2} %~ %k$(get-arrow $2)"
}

get-last-code() {
  if [[ $last_code -eq 0 ]]; then
    echo "$(get-arrow $5 $2)%F{$1}%K{$2} $last_code %f%k$(get-arrow $2 $4)"
  else
    echo "$(get-arrow $5 $3)%F{$1}%K{$3} $last_code %f%k$(get-arrow $3 $4)"
  fi
}

preexec() {
  # This makes sure that every (but not first) prompt has empty line above itself.
  is_first_prompt=1
}

precmd() {
  last_code=$?
  p_date=$(get-date $color_text $color_date)
  p_code=$(get-last-code $color_text $color_code_ok $color_code_wrong $color_pwd $color_date)
  p_pwd=$(get-pwd $color_text $color_pwd)
  
  if [[ -v is_first_prompt ]]; then
    print
  fi
}

PROMPT='$p_date$p_code$p_pwd'