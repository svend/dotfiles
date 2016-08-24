# .bash_profile
#
# The personal initialization file, executed for login shells.  Set environment
# variables, terminal settings, and startup programs here.

# Source individual snippets
USER_CONFIG_DIR=$HOME/.bash_profile.d
if [ -d $USER_CONFIG_DIR ]; then
  for i in $USER_CONFIG_DIR/*; do
    if [ -r $i ]; then
      . $i
    fi
  done
  unset i
fi
unset USER_CONFIG_DIR

# Include .bashrc, if it exists, for the login shell
if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi
