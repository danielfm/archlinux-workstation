# -*- mode: sh -*-

# If not running interactively, don't do anything
case $- in
  *i*) ;;
    *) return;;
esac

# Don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# For setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# Use gpg-agent for unlocking ssh passwords; add keys to the agent
# via the ssh-add command.
unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
  export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi

export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye >/dev/null

# Alias definitions
if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# Environment vars
if [ -f ~/.bash_env ]; then
  . ~/.bash_env
fi

# Completions
if [ -f ~/.bash_completions ]; then
  . ~/.bash_completions
fi

# Dynamic theming via pywal, if available
if [ -f ~/.cache/wal/sequences ]; then
  (cat ~/.cache/wal/sequences &)
fi

# Apply current color scheme
if [ -f ~/.cache/wal/colors-tty.sh ]; then
  source ~/.cache/wal/colors-tty.sh
fi
