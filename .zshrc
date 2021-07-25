# ZSH
HISTFILE=~/.zsh_history
SAVEHIST=1000
DIRSTACKSIZE=10

# EXPORT ENVIRONMENT VARIABLES
export ANDROID_HOME=/Users/harry/Library/Android/sdk
export PATH=${PATH}:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools

# AUTOCOMPLETE
autoload -U compinit; compinit
_comp_options+=(globdots)

# SET OPTIONS
setopt menu_complete
setopt auto_list
setopt complete_in_word
setopt glob_dots
setopt no_beep
setopt auto_cd
setopt auto_pushd
setopt pushd_minus
setopt pushd_ignore_dups
setopt pushd_silent
setopt pushd_to_home

# ALIASES
alias ls="ls -G"
alias ll="ls -Gla"

# ADD PROMPT
fpath=("$HOME/.zsh" $fpath)

# LOAD PROMPT THEN SELECTING
autoload -U promptinit; promptinit
prompt pure

# ZSTYLE PATTERN
# :completion:<function>:<completer>:<command>:<argument>:<tag>

# Define completers
zstyle ':completion:*' completer _extensions _complete _approximate

# Use cache for commands using cache
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"
# Complete the alias when _expand_alias is used as a function
zstyle ':completion:*' complete true

zle -C alias-expension complete-word _generic
zstyle ':completion:alias-expension:*' completer _expand_alias

# Use cache for commands which use it

# Allow you to select in a menu
zstyle ':completion:*' menu select

# Autocomplete options for cd instead of directory stack
zstyle ':completion:*' complete-options true

zstyle ':completion:*' file-sort modification

zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
zstyle ':completion:*:*:*:*:descriptions' format '%F{blue}-- %D %d --%f'
zstyle ':completion:*:*:*:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:*:*:*:warnings' format ' %F{red}-- no matches found --%f'
# zstyle ':completion:*:default' list-prompt '%S%M matches%s'
# Colors for files and directory
zstyle ':completion:*:*:*:*:default' list-colors ${(s.:.)LS_COLORS}

# Only display some tags for the command cd
zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
# zstyle ':completion:*:complete:git:argument-1:' tag-order !aliases

# Required for completion to be in good groups (named after the tags)
zstyle ':completion:*' group-name ''

zstyle ':completion:*:*:-command-:*:*' group-order aliases builtins functions commands

# See ZSHCOMPWID "completion matching control"
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

zstyle ':completion:*' keep-prefix true

zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

# ZSH SYNTAX HIGHTLIGHTING
source ~/.zsh/zsh-syntax-highlighting.zsh
