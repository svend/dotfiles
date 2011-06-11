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

export KRB5_CONFIG=$HOME/.krb5.conf
export PERL5LIB=$HOME/local/lib/perl5
export PYTHONPATH=$HOME/local/lib/python2.4/site-packages
