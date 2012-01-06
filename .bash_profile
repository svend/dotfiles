# .bash_profile
#
# The personal initialization file, executed for login shells.  Set environment
# variables, terminal settings, and startup programs here.

# Source .profile
. ~/.profile

# Source individual snippets
if [ -d $HOME/.bash_profile.d ]; then
	for i in $HOME/.bash_profile.d/*.sh; do
		if [ -r $i ]; then
			. $i
		fi
		done
	unset i
fi

# Include .bashrc, if it exists, for the login shell
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi
