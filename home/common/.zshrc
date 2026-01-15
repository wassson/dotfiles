export ZSH="$HOME/.oh-my-zsh"

eval "$(mise activate zsh)"
source ~/.cargo/env

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# bun completions
[ -s "/Users/austin/.bun/_bun" ] && source "/Users/austin/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
alias crew-dev="/Users/austin/crew/dev.sh"
eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH="/opt/homebrew/bin:$PATH"
eval "$(~/.local/bin/mise activate)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"




# git
alias check="git checkout"
alias checkb="git checkout -b"
export PATH="/opt/homebrew/opt/postgresql@17/bin:$PATH"


# odin
alias runwp="odin build . -debug && ./wellplayed"

# rust
alias cr="cargo run"
alias cre="cargo run --example"
alias cwr="cargo watch -x run"
cwe() { cargo watch -x "run --example $1" }
