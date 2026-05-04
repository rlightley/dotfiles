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

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias ls='ls -a'
