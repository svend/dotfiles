# .profile
#
# POSIX sh profile file

################################################################################
# Environmental variables
################################################################################

# Big history (dash supports HISTSIZE)
export HISTSIZE=2000

# Set PATH
PATH=$HOME/.mr/bin:$HOME/bin:$HOME/local/bin:$PATH
export PATH

# Set the editor to vim or vi
if [ -x "$(which vim)" ]; then
      EDITOR=vim
else
      EDITOR=vi
fi
VISUAL=$EDITOR
export EDITOR
export VISUAL

export MAIL=$HOME/Maildir

# Set timezone
export TZ=US/Pacific

if [ -d $HOME/profile.d ]; then
  for i in $HOME/profile.d/*.sh; do
    if [ -r $i ]; then
      . $i
    fi
  done
  unset i
fi
