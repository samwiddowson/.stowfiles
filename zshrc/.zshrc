source ~/.zsh_configure_history
source ~/.zsh_aliases
source ~/.zsh_functions
source ~/.zsh_variables
source ~/.zsh_tools

# required for some zsh completions e.g. git
autoload -Uz compinit && compinit

source ~/.ana_env.sh

# Rust
source "$HOME/.cargo/env"

fastfetch
