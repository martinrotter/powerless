######################################
### This is the ZSH powerless utlity script.
######################################
### Simply source this script into
### your .zshrc.
### Make sure your .zshrc does not
### contain any conflicting code.
######################################

# Disable duplicate history entries.
setopt HIST_IGNORE_DUPS

# No beeping.
setopt NO_BEEP

# No need to type "cd".
setopt AUTO_CD

# Complete aliases.
setopt COMPLETE_ALIASES

# Setup directory stack.
setopt AUTO_PUSHD PUSHD_SILENT PUSHD_TO_HOME PUSHD_IGNORE_DUPS PUSHD_MINUS

  # Setup completions.
autoload -U compinit
compinit -d ${HOME}/.martin/zsh/.completion_dump

# Allow "menu" arrows navigation when completing (3 x TAB).
zstyle ':completion:*' menu select
zstyle ':completion:*' completer _complete _list _oldlist _expand _ignored _match _correct _approximate _prefix
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:cd:*' ignore-parents parent pwd
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion::complete:*' cache-path ${HOME}/.martin/zsh/cache
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'