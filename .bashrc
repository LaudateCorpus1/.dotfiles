#!/usr/bin/env bash
# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# User Info
export USERNAME="Thomas Honeyman"
export NICKNAME="Thomas"


##### SOME BASIC DEFAULTS #####

# Prevent file overwrite on stdout redirection
# Use `>|` to force redirection to an existing file
set -o noclobber

# Update window size after every command
shopt -s checkwinsize

# Automatically trim long paths in the prompt (requires Bash 4.x)
PROMPT_DIRTRIM=2

# Turn on recursive globbing (enables ** to recurse all directories)
shopt -s globstar 2> /dev/null

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Oddly enough, have to do this to get tmux bgcolor working
export TERM=screen-256color

##### PATH #####
export PATH=$PATH:$HOME/.local/bin:$HOME/.cargo/bin

##### PROMPT #####

# Set variable identifying the chroot you work in
# Used in the prompt below
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Set a fancy prompt
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# Set the prompt with git
if [ -n "$SSH_CONNECTION" ]; then  # connected through SSH?
    usercolor="\[\e[32m\]"  # yes -> green
else
    usercolor="\[\e[96m\]"  # no  -> cyan
fi
pathcolor="\[\e[0m\]"       # no path color
resetcolor="\[\e[0m\]"

# Read more: https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_DESCRIBE_STYLE="branch"

# Requires file is copied over in the first place!
source ~/.git-prompt.sh

# Suppress "command not found" errors when __git_ps1 is not installed
type __git_ps1 &>/dev/null || function __git_ps1 () { true; }

# Set prompt
export PS1="${debian_chroot:+($debian_chroot)}${usercolor}\u@\h${pathcolor} \w${resetcolor}\$(__git_ps1) $ "


##### COLOR SUPPORT #####

# Enable colors
export CLICOLOR=1

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
fi


##### ALIASES #####
alias ll='ls -alF'
alias la='ls -A'

alias v='nvim'
alias vim='nvim'
alias tmux='tmux -2'
alias emacs='emacs -nw'  # Open in the terminal


##### COMPLETION #####

# Perform case insensitive file completion
bind "set completion-ignore-case on"

# Treat hyphens and underscores as equivalent
bind "set completion-map-case on"

# Display matches for ambiguous patterns at first tab press
bind "set show-all-if-ambiguous on"

# Immediately add a trailing slash when autocompleting symlinks to directories
bind "set mark-symlinked-directories on"


##### SANE HISTORY DEFAULTS #####

# Append to the history file, don't overwrite it
shopt -s histappend

# Save multi-line commands as one command
shopt -s cmdhist

# Record each line as it gets issued
PROMPT_COMMAND='history -a'

# Huge history. Doesn't appear to slow things down, so why not?
HISTSIZE=50000
HISTFILESIZE=10000

# Avoid duplicate entries
HISTCONTROL="erasedups:ignoreboth"

# Don't record some commands
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"

# Use standard ISO 8601 timestamp
# %F equivalent to %Y-%m-%d
# %T equivalent to %H:%M:%S (24-hours format)
HISTTIMEFORMAT='%F %T '


##### DIRECTORY NAVIGATION #####

# Prepend cd to directory names automatically
shopt -s autocd 2> /dev/null

# Correct spelling errors during tab-completion
shopt -s dirspell 2> /dev/null

# Correct spelling errors in arguments supplied to cd
shopt -s cdspell 2> /dev/null
