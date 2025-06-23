# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# append to the history file, don't overwrite it
shopt -s histappend
PROMPT_COMMAND='history -a; history -n'

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=4096
HISTFILESIZE=4096

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${arch_chroot:-}" ] && [ -r /etc/arch_chroot ]; then
    arch_chroot=$(cat /etc/arch_chroot)
fi

# If this is an xterm set the title to user@host:dir
case "$term" in
xterm*|rxvt*)
    PS1="\[\e]0;${arch_chroot:+($arch_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# git credential store to expire after 9h (i.e. last for one day)
export GCM_CREDENTIAL_CACHE_OPTIONS="--timeout 32400"

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export DOTNET_ROOT=$HOME/.dotnet
export PATH=$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools
export PATH=$PATH:~/.local/bin

function yy() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}

eval "$(oh-my-posh init bash --config '~/.config/oh-my-posh/lambdageneration-green.omp.json')"
# this isn't running and it's also breaking `cd`, so commenting it out for now
eval "$(zoxide init bash)"
alias zz='z -'
alias cd='z'

complete -C /usr/bin/terraform terraform

alias vim="nvim"
alias ls="eza"
alias ll="eza -l --header --icons --git"
alias lt="eza -lT --header --icons --git"
alias clip='xclip -selection c'
alias sudo='sudo '
alias onv="NVIM_APPNAME=obsidian.nvim nvim"
alias startssh="sudo systemctl start ssh.service"
alias keeb="sudo chmod a+rw /dev/keebio_keyboard"
alias updatekeys="cp /mnt/c/Users/Sam.Widdowson/Downloads/iris_lm_k_rev__1.layout.json /home/sam/.stowfiles/via-settings/iris_lm_k_rev__1.layout_scw.json"

if [[ "$TERM" == xterm-256color ]]; then
    exec tmux
fi

NVIM_APPNAME=nvim

# source <(kubectl completion bash)

# DSPT project stuff
export AWS_DEFAULT_SSO_START_URL=https://d-9c67018f89.awsapps.com/start/#
export AWS_DEFAULT_SSO_REGION=eu-west-2
export DSPT_DEPLOYMENT_SECRETS=arn:aws:secretsmanager:eu-west-2:730319765130:secret:dspt-nonprod-dev/deployment-HpZD4M

#AWSume alias to source the AWSume script
alias loadsecrets="source <(~/getsecrets.sh)"
alias awsume="source awsume"

#Auto-Complete function for AWSume
_awsume() {
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    opts=$(awsume-autocomplete)
    COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
    return 0
}
complete -F _awsume awsume

function letsgo(){
    branch=$1
    aws-sso-util login
    awsume NHS-Digital-DDC-Exeter-Texas-NonProd-K8s.dspt-rw-user
    loadsecrets
    export Subs__DB_NAME=cca-$branch
}

fastfetch
