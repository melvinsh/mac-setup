#!/bin/sh

cat << 'EOF'
 ___       _ _   _       _ _     _             
|_ _|_ __ (_) |_(_) __ _| (_)___(_)_ __   __ _ 
 | || '_ \| | __| |/ _` | | |_  / | '_ \ / _` |
 | || | | | | |_| | (_| | | |/ /| | | | | (_| |
|___|_| |_|_|\__|_|\__,_|_|_/___|_|_| |_|\__, |
                                         |___/ 
EOF

# Import some fuctions.
source functions.sh

# Install Homebrew.
source homebrew.sh

set -e

if [ ! -d "$HOME/.bin/" ]; then mkdir "$HOME/.bin"; fi

cat << 'EOF'
 ___           _        _ _ _                   _          __  __ 
|_ _|_ __  ___| |_ __ _| | (_)_ __   __ _   ___| |_ _   _ / _|/ _|
 | || '_ \/ __| __/ _` | | | | '_ \ / _` | / __| __| | | | |_| |_ 
 | || | | \__ \ || (_| | | | | | | | (_| | \__ \ |_| |_| |  _|  _|
|___|_| |_|___/\__\__,_|_|_|_|_| |_|\__, | |___/\__|\__,_|_| |_|  
                                    |___/
EOF

brew update
brew bundle

if [ $SHELL != "/usr/local/bin/zsh" ]; then
  fancy_echo "Changing your shell to zsh ..."
  echo /usr/local/bin/zsh | sudo tee -a /etc/shells > /dev/null
  chsh -s /usr/local/bin/zsh
fi

chmod 6555 /usr/local/bin/htop
sudo chown root /usr/local/bin/htop

cat << 'EOF'
  ____             __ _                  _               _____ _ _      _      
 / ___|___  _ __  / _(_) __ _ _   _ _ __(_)_ __   __ _  | ____| (_)_  _(_)_ __ 
| |   / _ \| '_ \| |_| |/ _` | | | | '__| | '_ \ / _` | |  _| | | \ \/ / | '__|
| |__| (_) | | | |  _| | (_| | |_| | |  | | | | | (_| | | |___| | |>  <| | |   
 \____\___/|_| |_|_| |_|\__, |\__,_|_|  |_|_| |_|\__, | |_____|_|_/_/\_\_|_|   
                        |___/                    |___/                         
EOF

if ! command -v elixir >/dev/null; then
  brew install erlang
  curl -sSL https://raw.githubusercontent.com/taylor/kiex/master/install | bash -s

  append_to_zshrc 'test -s "$HOME/.kiex/scripts/kiex" && source "$HOME/.kiex/scripts/kiex"'
  test -s "$HOME/.kiex/scripts/kiex" && source "$HOME/.kiex/scripts/kiex"

  LATEST=$(kiex list branches | tail -n 1 | sed "s/ //g")
  kiex install $LATEST && kiex default $LATEST
  append_to_zshrc "source $HOME/.kiex/elixirs/elixir-$LATEST.env"
else
  fancy_echo "Elixir already installed. If you want to update, do it manually using kiex."
fi

cat << 'EOF'
  ____             __ _                  _               ____        _           
 / ___|___  _ __  / _(_) __ _ _   _ _ __(_)_ __   __ _  |  _ \ _   _| |__  _   _ 
| |   / _ \| '_ \| |_| |/ _` | | | | '__| | '_ \ / _` | | |_) | | | | '_ \| | | |
| |__| (_) | | | |  _| | (_| | |_| | |  | | | | | (_| | |  _ <| |_| | |_) | |_| |
 \____\___/|_| |_|_| |_|\__, |\__,_|_|  |_|_| |_|\__, | |_| \_\\__,_|_.__/ \__, |
                        |___/                    |___/                     |___/ 
EOF

find_latest_ruby() {
  rbenv install -l | grep -v - | tail -1 | sed -e 's/^ *//'
}

ruby_version="$(find_latest_ruby)"
append_to_zshrc 'eval "$(rbenv init - --no-rehash)"' 1
eval "$(rbenv init -)"

if ! rbenv versions | grep -Fq "$ruby_version"; then
  RUBY_CONFIGURE_OPTS=--with-openssl-dir=/usr/local/opt/openssl rbenv install -s "$ruby_version"
fi

rbenv global "$ruby_version"
rbenv shell "$ruby_version"
gem update --system
gem_install_or_update 'bundler'
number_of_cores=$(sysctl -n hw.ncpu)
bundle config --global jobs $((number_of_cores - 1))

cat << 'EOF'
                       ___  ____             _   _   _                 
 _ __ ___   __ _  ___ / _ \/ ___|   ___  ___| |_| |_(_)_ __   __ _ ___ 
| '_ ` _ \ / _` |/ __| | | \___ \  / __|/ _ \ __| __| | '_ \ / _` / __|
| | | | | | (_| | (__| |_| |___) | \__ \  __/ |_| |_| | | | | (_| \__ \
|_| |_| |_|\__,_|\___|\___/|____/  |___/\___|\__|\__|_|_| |_|\__, |___/
                                                             |___/     
EOF

source settings.sh
