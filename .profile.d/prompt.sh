# Set prompt
PS1='\h:\W '
# Add git to the prompt
if type -t __git_ps1 >/dev/null; then
	# Show difference from upstream
	GIT_PS1_SHOWUPSTREAM=auto
	PS1="$PS1"'$(__git_ps1 "(%s) ")'
fi
PS1="$PS1"'\$ '
export PS1

# Debian bashrc overrides PS1 in /etc/bash.bashrc, so make a backup of the var
# and restore it in ~/.bashrc
PS1_BAK=$PS1
export PS1_BAK
