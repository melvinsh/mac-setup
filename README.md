# macOS Setup
Setup script for a new macOS machine. Includes UNIX tools, latest Ruby and Elixir, software and sane defaults.

- UNIX: git, openssl, tmux, vim, zsh, htop, tree, watch, wget.
- Software: Dropbox, Flux, Spotify, Tunnelblick, VLC.
- Ruby: with rbenv, latest Ruby version through ruby-build, node and imagemagick/qt.
- Elixir: Erlang, kiex and latest Elixir version.
- Databases: Postgres and Redis.

System settings:
```
echo "Enabling three-finger drag ..."
echo "Enabling dark mode ..."
echo "Unhiding Library in Finder ..."
echo "Disabling Desktop icons (AKA force clean Desktop) ..."
echo "Setting Default Finder Location to Home Folder ..."
echo "Enabling iOS charging sound when MagSafe is connected ..."
echo "Disabling autocorrect ..."
echo "Disabling Sound Effects on Boot ...
echo "Enabling Firewall ..."
echo "Setting screensaver to lock immediately ..."
echo "Starting locate database building service ..."
echo "Disabling AirDrop ..."
echo "Changing screenshots directory to ~/Screenshots"
```

It also creates a sourced `~/.aliases` file with the following aliases:
```
alias gi="git init"
alias ga="git add"
alias gc="git commit"
alias gp="git push"
alias rm="srm"
alias update="brew update && brew upgrade && gem update"
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
```

### Usage
```
./mac.sh
```
