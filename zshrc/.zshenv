. "$HOME/.cargo/env"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

export PATH=$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools
export PATH=$PATH:~/.local/bin
export PATH=$PATH:/home/sam/src/zig/zls/zig-out/bin

# tells gent to store credentials in ~/.config/cursor/auth.json
# required by neocursor
export AGENT_CLI_CREDENTIAL_STORE=file

# force dark theme for terminal
# this may fix an issue in cursor cli where light background is used with light text
export TERM_THEME=dark
