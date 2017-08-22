#####################################################
### This is the OPTIONAL ZSH powerless utlity script.
#####################################################

### Shortcuts.
#####################################################
bindkey ';5D' backward-word       # CTRL+LEFT - jump to previous word boundary
bindkey ';5C' forward-word        # CTRL+RIGHT - jump to next word boundary
bindkey '^[[3~' delete-char       # BACKSPACE - delete character before cursor
bindkey '^[3;5~' delete-char      # DELETE - delete character after cursor
bindkey '^[[H' beginning-of-line  # HOME - go to beginning of line
bindkey '^[[F' end-of-line        # END - go to end of line
bindkey '^[[3;5~' kill-word       # CTRL+DELETE - delete whole next word
bindkey '^[[1;5A' history-beginning-search-backward    # History search
bindkey '^[[1;5B' history-beginning-search-forward     # History search

case $(uname -s) in
  *CYGWIN*) bindkey '^_' backward-kill-word ;;  # CTRL+BACKSPACE - delete whole previous word.
  *) bindkey '^H' backward-kill-word ;;         # CTRL+BACKSPACE - delete whole previous word.
esac

if [[ "$(uname -o)" != "Cygwin" ]]; then
  
else
  
fi

### Options.
#####################################################

# Disable duplicate history entries.
setopt HIST_IGNORE_DUPS HIST_FIND_NO_DUPS HIST_IGNORE_ALL_DUPS HIST_REDUCE_BLANKS

# No beeping.
setopt NO_BEEP

# No need to type "cd".
setopt AUTO_CD

# Complete aliases.
setopt COMPLETE_ALIASES

# Setup directory stack.
setopt AUTO_PUSHD PUSHD_SILENT PUSHD_TO_HOME PUSHD_IGNORE_DUPS PUSHD_MINUS

# Do not remove slash when executed completed expression.
unsetopt AUTO_REMOVE_SLASH

### Dirstack and history.
#####################################################

# Setup persistent directory stack.
DIRSTACKFILE="$HOME/.zdirstack"
DIRSTACKSIZE=30

if [[ -f $DIRSTACKFILE ]] && [[ $#dirstack -eq 0 ]]; then
  dirstack=( ${(f)"$(< $DIRSTACKFILE)"} )
  [[ -d $dirstack[1] ]] && cd $dirstack[1]
fi

chpwd() {
  print -l $PWD ${(u)dirstack} > $DIRSTACKFILE
}

### Completions.
#####################################################

# Setup completions & menu selections.
autoload -U compinit
compinit

# General completions settings.
zstyle ':completion:*' verbose true
zstyle ':completion:*' menu select=5
zstyle ':completion:*' use-cache on
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' accept-exact-dirs true
zstyle ':completion:*' list-dirs-first true
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' completer _complete _approximate

# Approximate settings.
zstyle ':completion:*:approximate:*' max-errors 2 numeric

# Cd settings.
zstyle ':completion:*:cd:*' ignore-parents parent pwd

# Kill settings.
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:*:kill:*:jobs' verbose false