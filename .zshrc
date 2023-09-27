# Custom functions
nd() {
    mkdir "$1" && cd "$1"
}

. /opt/homebrew/opt/asdf/libexec/asdf.sh

# Platform
export LAUNCH_DARKLY_AUTH_TOKEN=
export PLATFORM_SERVICES_LAUNCH_DARKLY_SDK_KEY=
export MAILOSAUR_API_KEY=
export NPM_TOKEN=
export SST_STAGE=
export SST_REGION="us-east-1"
export SST_PROFILE=
export SST_TELEMETRY_DISABLED="1"
export SST_SOURCE_STAGE=global
export SST_SOURCE_PROFILE=shop-ware-dev
export SST_DEST_STAGE=global

# SW
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

# Alias
alias co="code ."
alias cr="cargo run"
alias fore="foreman start -f Procfile.dev"
alias migrate="bundle exec rails db:migrate"
alias mine="open -a rubymine"
alias stopredis="redis-cli shutdown"
alias svon="pnpm run dev -- --open"

# pnpm
export PNPM_HOME="/Users/austinwasson/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
# bun completions
[ -s "/Users/austinwasson/.bun/_bun" ] && source "/Users/austinwasson/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"