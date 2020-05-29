# Personal environment variables and startup programs.

# Personal aliases and functions should go in ~/.bashrc. System wide
# environment variables and startup programs are in /etc/profile.
# System wide aliases and functions are in /etc/bashrc.

# include .bashrc if it exists
if [ -e ~/.bashrc ]; then
  . ~/.bashrc
fi

if [ -e ~/.bash_definitions ]; then
  . ~/.bash_definitions
fi