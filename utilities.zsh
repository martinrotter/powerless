#####################################################
### This is the OPTIONAL ZSH powerless utlity script.
#####################################################

# Shortcuts.
bindkey ';5D' backward-word       # CTRL+LEFT - jump to previous word boundary
bindkey ';5C' forward-word        # CTRL+RIGHT - jump to next word boundary
bindkey '^[[3~' delete-char       # BACKSPACE - delete character before cursor
bindkey '^[3;5~' delete-char      # DELETE - delete character after cursor
bindkey '^[[H' beginning-of-line  # HOME - go to beginning of line
bindkey '^[[F' end-of-line        # END - go to end of line
bindkey '^[[3;5~' kill-word       # CTRL+DELETE - delete whole next word
bindkey '^[[A' history-beginning-search-backward    # History search.
bindkey '^[[B' history-beginning-search-forward     # History search.

if [[ "$(uname -o)" != "Cygwin" ]]; then
  bindkey '^H' backward-kill-word   # CTRL+BACKSPACE - delete whole previous word
else
  bindkey '^_' backward-kill-word   # CTRL+BACKSPACE - delete whole previous word
fi

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

# Do not remove slash when executed completed expression.
unsetopt AUTO_REMOVE_SLASH

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

# Setup completions & menu selections.
autoload -U compinit
compinit

zstyle ':completion:*' menu select=3
zstyle ':completion:*' rehash true
zstyle ':completion:*' completer _complete _list _oldlist _expand _ignored _match _correct _approximate _prefix
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:cd:*' ignore-parents parent pwd
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion:*:approximate:*' max-errors 1 numeric
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
