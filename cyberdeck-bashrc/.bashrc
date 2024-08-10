function lockScreen() {
    if [[ "$TERM" == xterm-256color ]]; then
        ## USE cmatrix AS A KIND OF LOCKED SCREENSAVER
        ## WITH KEY REMAPS THE ONLY WAY TO GET OUT OF IT IS
        ## BY HOLDING V AND PRESSING 7
        ## i.e. v+7 keys
        #remap Ctrl to v; remap c to 7
        #also need to remap the q key and the z key
        #because q quits and ctrl+z sends it to background
        sudo setkeycodes 1d 0
        if [[ "$?" == 1 ]]; then
            #if someone cancels the sudo to switch the keypress then don't let them log in
            logout
        fi
        sudo setkeycodes 2e 0
        sudo setkeycodes 2f 29
        sudo setkeycodes 08 46
        sudo setkeycodes 2c 0
        sudo setkeycodes 10 0
        cmatrix -ab
        sudo setkeycodes 1d 29
        sudo setkeycodes 2e 46
        sudo setkeycodes 2f 47
        sudo setkeycodes 08 8
        sudo setkeycodes 2c 44
        sudo setkeycodes 10 16
    fi
}

export PATH=$PATH:~/.cargo/bin

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

eval "$(oh-my-posh init bash --config '~/.config/oh-my-posh/lambdageneration-green.omp.json')"
eval "$(zoxide init bash)"

alias vim=nvim
alias zz="z -"
alias cd="z"
alias clip="xclip -selection c"
alias ls="eza"
alias ll="eza -l --header --icons --git"
alias lt="eza -lT --header --icons --git"
alias neofetch=fastfetch
alias cm="cmatrix -ab"
alias go="z ~/writing/valirsCrossing/ && vim ."


if [[ "$TERM" == alacritty ]]; then
	exec tmux
fi

if [[ "$TERM" == xterm-256color ]]; then
	#config for kmscon
    lockScreen
    tmux
    while true
    do
        lockScreen
        tmux attach
    done
fi
