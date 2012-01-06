# .bashrc
#
# The individual per-interactive-shell startup file for Bash. Set options,
# aliases, and functions here.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Options

# Don't overwrite history file.
shopt -s histappend

# Miscellaneous

# Disables START/STOP output control. (Disable C-s and C-q. C-s is used by
# readline for forward-search-history.)
stty -ixon

BASH_RC_USER_DIR=$HOME/.bashrc.d
if [[ -d $BASH_RC_USER_DIR && -r $BASH_RC_USER_DIR && \
    -x $BASH_RC_USER_DIR ]]; then
    for i in $(LC_ALL=C command ls "$BASH_RC_USER_DIR"); do
        i=$BASH_RC_USER_DIR/$i
        [[ ${i##*/} != @(*~|*.bak|*.swp|\#*\#|*.dpkg*|*.rpm@(orig|new|save)) \
            && ( -f $i || -h $i ) && -r $i ]] && . "$i"
    done
fi
unset i BASH_RC_USER_DIR
