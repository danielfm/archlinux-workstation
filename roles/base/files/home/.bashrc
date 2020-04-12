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

# Alias definitions
for f in ~/.bash_aliases.d/*; do
  source $f;
done

# Environment vars
for f in ~/.bash_env.d/*; do
  source $f;
done

# Completions
for f in ~/.bash_completions.d/*; do
  source $f;
done

# Dynamic theming via pywal, if available
if [ -f ~/.cache/wal/sequences ]; then
  (cat ~/.cache/wal/sequences &)
fi

# Apply current color scheme
if [ -f ~/.cache/wal/colors-tty.sh ]; then
  source ~/.cache/wal/colors-tty.sh
fi
