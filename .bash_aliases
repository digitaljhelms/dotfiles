# Personal aliases.

# Personal functions should go in ~/.bashrc.  System wide environment
# variables and startup programs are in /etc/profile. System wide
# aliases and functions are in /etc/bashrc.

alias ls='ls -GA'
alias ll='ls -lGA'
alias l=ll
alias pwdc='pwd | pbcopy'
alias updatedb='sudo /usr/libexec/locate.updatedb'
alias fcount='ls -l | wc -l' # file count
alias fcountr='find . -type f | wc -l' # file count recursive

# `npm list` aliases
alias nl='npm list --depth=0 2>/dev/null'
alias nlg='npm list -g --depth=0 2>/dev/null'

# list all crontab jobs for all users
alias allcron='for user in $(cut -f1 -d: /etc/passwd); do echo $user; crontab -u $user -l; done'

# ack, ignore case, pipe output through "less" command and ignore redirects + chop long lines
alias ick='ack -i --pager="less -R -S"'

# cp w/ per-file progress indicator
# alias cp='rsync -WavP'

# pretty JSON: "curl blah.com/blah.json | json"
alias json='python -m json.tool'

# easy navigation: .., ..., .... and .....
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
