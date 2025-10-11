export ZSH="$HOME/.oh-my-zsh"

eval "$(mise activate zsh)"
source ~/.cargo/env

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh
