# Use gpg-agent for unlocking ssh passwords; add keys to the agent
# via the ssh-add command.
unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
  export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi

export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye >/dev/null

# This allows aws-vault to automatically fetch the OATH code from Yubikey
export AWS_VAULT_PROMPT=ykman
