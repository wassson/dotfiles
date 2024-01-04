export PATH="$PATH:/opt/homebrew/bin/"
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export PATH=~/usr/bin:/bin:/usr/sbin:/sbin:$PATH
export PATH=/usr/local/share/npm/bin:$PATH
export PATH="$HOME/.npm-packages/bin:$PATH"

. /opt/homebrew/opt/asdf/libexec/asdf.sh


# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

nd ()
{
  mkdir -p -- "$1" &&
  cd -P -- "$1"
}

bi_gem ()
{
  gem build "$1"
  gem install ./"$1"-"$2".gem
}

export PNPM_HOME="/Users/austinwasson/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"

export LAUNCH_DARKLY_AUTH_TOKEN=
export PLATFORM_SERVICES_LAUNCH_DARKLY_SDK_KEY=
export MAILOSAUR_API_KEY=

export NPM_TOKEN=

export SST_STAGE="awasson"
export SST_REGION="us-east-1"
export SST_PROFILE="awasson"
export SST_TELEMETRY_DISABLED="1"

export SST_SOURCE_STAGE=global
export SST_SOURCE_PROFILE=shop-ware-dev
export SST_DEST_STAGE=global

export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

alias bd="./bin/dev"
alias bef="bundle exec rspec --tag focus"
alias ber="bundle exec rspec"
alias clean-schema="chmod +x ./script/api/clean_schema.sh && ./script/api/clean_schema.sh"
alias co="git checkout"
alias cob="git checkout -b"
alias cur="cursor ."
alias cr="cargo run"
alias del="git branch -D"
alias dockerstop="ps ax|grep -i docker|egrep -iv 'grep|com.docker.vmnetd'|awk '{print $1}'|xargs kill"
alias fore="foreman start -f Procfile.dev"
alias gitcache="git rm -rf --cached ."
alias oll="ollama run mistral"
alias lap="chmod +x ./window_manager_laptop.sh && ./window_manager_laptop.sh"
alias masterkey="c82e896b9e005e2ece32e2297b643f7f"
alias migrate="bundle exec rails db:migrate"
alias mine="open -a rubymine"
alias mon="chmod +x ./window_manager_monitor.sh && ./window_manager_monitor.sh"
alias prisma-migrate="npx prisma migrate dev --name"
alias prisma-status="npx prisma migrate dev --preview-feature"
alias studio="npx prisma studio"
alias stopredis="redis-cli shutdown"
alias sup="./vendor/bin/sail up"
alias svon="pnpm run dev -- --open"

alias .m="./main"

# bun completions
[ -s "/Users/austinwasson/.bun/_bun" ] && source "/Users/austinwasson/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"