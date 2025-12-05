setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
# setopt CHECK_WINSIZE

# append history from all sessions
# autoload -Uz add-zsh-hook
#
# add-zsh-hook precmd history -a
# add-zsh-hook precmd history -n

# don't put duplicate lines or lines starting with space in the history.
setopt appendhistory
setopt hist_ignore_dups # Don't store the same command multiple times
setopt hist_reduce_blanks # Remove extra blank spaces from commands
setopt hist_verify # Show command before executing when history expanded
setopt INC_APPEND_HISTORY  # 2. Write to the history file immediately, not when the shell exits
setopt SHARE_HISTORY       # 3. Share history between all running shells
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# [ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

source ~/.zsh_aliases
source ~/.zsh_functions
source ~/.zsh_variables

eval "$(fzf --zsh)"
eval "$(oh-my-posh init zsh --config '~/.config/oh-my-posh/lambdageneration-green.omp.json')"
eval "$(zoxide init zsh)"

# Rust
# . "$HOME/.cargo/env"

fastfetch
