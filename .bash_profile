# Personal environment variables and startup programs.

# Personal aliases and functions should go in ~/.bashrc. System wide
# environment variables and startup programs are in /etc/profile.
# System wide aliases and functions are in /etc/bashrc.

# include .bashrc if it exists
if [ -e ~/.bashrc ]; then
    . ~/.bashrc
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -e ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Private definitions.
# Create a directory at ~/.bash_local that contains bash aliases,
# functions, configurations, etc. reserved specifically for
# your profile. The .gitignore rule will exclude any files in
# ~/.bash_local that contain "secure" in the filename.
for f in $(command ls ~/.bash_local); do
    f="$HOME/.bash_local/$f"
    test -f "$f" && . "$f"
done
