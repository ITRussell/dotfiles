#!/bin/bash

# SYSTEM UPDATE
sudo apt update && sudo apt upgrade

# DIRECTORIES
cd ~
mkdir -p WorkBench
mkdir -p WorkBench/repos
mkdir -p WorkBench/pyenvs
mkdir -p WorkBench/sandbox
mkdir -p WorkBench/sandbox/analysis
mkdir -p WorkBench/sandbox/scrap

# SOFTWARE
# apt
sudo apt install curl snap git lynis fonts-hack-ttf ranger cmatrix trash-cli neofetch htop \
neovim firefox fish node-typescript make -y
sudo snap install --classic code

# GIT CONFIG
GITUSER="ITRussell";
git config --global user.name "${GITUSER}"
GITEMAIL="IanThomasR@gmail.com";
git config --global user.email "${GITEMAIL}"

# DOT FILES
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

sudo lynis audit system






