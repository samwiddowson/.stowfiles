source ~/.zsh_configure_history
source ~/.zsh_aliases
source ~/.zsh_functions
source ~/.zsh_variables

# required for some zsh completions e.g. git
autoload -Uz compinit && compinit

eval "$(fzf --zsh)"
eval "$(oh-my-posh init zsh --config '~/.config/oh-my-posh/lambdageneration-green.omp.json')"
eval "$(zoxide init zsh)"

source ~/.ana_env.sh

# Rust
source "$HOME/.cargo/env"

fastfetch
