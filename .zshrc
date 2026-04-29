export PATH="$PATH:/Users/ryanlightley/.dotnet/tools"
GOPATH=$HOME/go  PATH=$PATH:/usr/local/go/bin:$GOPATH/bin
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$GOPATH/bin

eval "$(starship init zsh)"

# bun completions
[ -s "/Users/ryanlightley/.bun/_bun" ] && source "/Users/ryanlightley/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"
export PATH=$PATH:$HOME/go/bin
