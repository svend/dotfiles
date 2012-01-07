# .bashrc
#
# The individual per-interactive-shell startup file for Bash. Set options,
# aliases, and functions here.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Source individual snippets
USER_CONFIG_DIR=$HOME/.bashrc.d
if [ -d $USER_CONFIG_DIR ]; then
	for i in $USER_CONFIG_DIR/*; do
		if [ -r $i ]; then
			. $i
		fi
	done
	unset i
fi
unset USER_CONFIG_DIR
