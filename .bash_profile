# .bash_profile
#
# The personal initialization file, executed for login shells.  Set environment
# variables, terminal settings, and startup programs here.

################################################################################
# Bash environmental variables
################################################################################

# Source .profile
. ~/.profile

# Big history file
export HISTFILESIZE=200000

# Never truncate history file (This isn't working.)
#unset HISTFILESIZE

# Set prompt
# PS1 is set in .bashrc, due to Debian's /etc/bashrc override

################################################################################
# Startup programs
################################################################################

# none

# Include .bashrc, if it exists, for the login shell
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi
