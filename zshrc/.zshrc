source ~/.zsh_configure_history
source ~/.zsh_aliases
source ~/.zsh_functions
source ~/.zsh_variables

eval "$(fzf --zsh)"
eval "$(oh-my-posh init zsh --config '~/.config/oh-my-posh/lambdageneration-green.omp.json')"
eval "$(zoxide init zsh)"

source ~/.ana_env.sh

# Rust
# . "$HOME/.cargo/env"

fastfetch
