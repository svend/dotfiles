# .bashrc
#
# The individual per-interactive-shell startup file for Bash. Set options,
# aliases, and functions here.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

################################################################################
# Options
################################################################################

# Don't overwrite history file.
shopt -s histappend

################################################################################
# Aliases
################################################################################

alias basedir='basename "$(pwd)"'
alias ymd='date +%Y%m%d'
alias ymd2='date +%Y-%m-%d'

################################################################################
# Functions
################################################################################

################################################################################
# Miscellaneous
################################################################################

# Disables START/STOP output control. (Disable C-s and C-q. C-s is used by
# readline for forward-search-history.)
stty -ixon

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
	. /etc/bash_completion
fi

# Debian sets the prompt in system bashrc, so we have to set it here, too
# Set prompt
PS1='\h:\W '
# Add git to the prompt
if type -t __git_ps1 >/dev/null; then
	PS1="$PS1"'$(__git_ps1 "(%s) ")'
fi
PS1="$PS1"'\$ '
export PS1

# gpg-agent
GPG_TTY=$(tty)
export GPG_TTY
if [ -f "${HOME}/.gpg-agent-info" ]; then
	. "${HOME}/.gpg-agent-info"
	export GPG_AGENT_INFO
	export SSH_AUTH_SOCK
	export SSH_AGENT_PID
fi
