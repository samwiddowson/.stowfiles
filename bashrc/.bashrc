# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# append to the history file, don't overwrite it
shopt -s histappend

PROMPT_COMMAND='history -a; history -n'

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth
HISTSIZE=10000
HISTFILESIZE=20000

[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

if [ -z "${arch_chroot:-}" ] && [ -r /etc/arch_chroot ]; then
    arch_chroot=$(cat /etc/arch_chroot)
fi

source ~/.bash_aliases
source ~/.bash_functions
source ~/.bash_variables

eval "$(fzf --bash)"
eval "$(oh-my-posh init bash --config '~/.config/oh-my-posh/lambdageneration-green.omp.json')"
eval "$(zoxide init bash)"

fastfetch
