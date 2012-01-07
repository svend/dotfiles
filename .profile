# .profile
#
# POSIX sh profile file

# Source individual snippets
USER_CONFIG_DIR=$HOME/.profile.d
if [ -d $USER_CONFIG_DIR ]; then
	for i in $USER_CONFIG_DIR/*; do
		if [ -r $i ]; then
			. $i
		fi
	done
	unset i
fi
unset USER_CONFIG_DIR
