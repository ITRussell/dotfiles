#!/bin/bash

sudo apt update && sudo apt upgrade -y

# Add directories
cd ~
mkdir -p WorkBench
mkdir -p WorkBench/repos
mkdir -p WorkBench/pyenvs
mkdir -p WorkBench/sandbox
mkdir -p WorkBench/sandbox/analysis
mkdir -p WorkBench/sandbox/scrap

# Git Configuration
GITUSER="ITRussell";
git config --global user.name "${GITUSER}"
GITEMAIL="IanThomasR@gmail.com";
git config --global user.email "${GITEMAIL}"

# And that your source repository ignores the folder where you'll clone it, so that you don't create weird recursion problems:
echo ".cfg" >> .gitignore

# Clone dot files repo
git clone --bare https://github.com/itrussell/dotfiles.git $HOME/.cfg

# backup any existing configs
mkdir -p .config-backup && \
/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
xargs -I{} mv {} .config-backup/{}

# Checkout
/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME checkout Ubuntu
# Set to not show untracked files
/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME config --local status.showUntrackedFiles no

# Packages
echo
echo "Installing software..."
sudo add-apt-repository ppa:mmstick76/alacritty
curl -fsSL https://starship.rs/install.sh | bash
sudo apt install $(cat ~/.config/packages.list) -y

