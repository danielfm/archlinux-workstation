# -*- mode: sh -*-

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# Some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Starts a local HTTP server using Python in working dir
alias httpserver='python -m http.server'

# Usage: cat file.json | asjson
alias json_pp='python -mjson.tool'

# Secret token generation
alias token="dd if=/dev/random bs=1 count=64 2>/dev/null | base64 | tr -d '=\n'"

# Password management
alias pass='gopass'
