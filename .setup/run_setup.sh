#!/bin/bash
echo "########################################################"
echo "######                                           #######"
echo "######     Would you like to install extras?     #######"
echo "######                   Y/n                     #######"
echo "######                                           #######"
echo "########################################################"

read ANS
echo
echo "Updating..."
sudo apt update && sudo apt upgrade -y
echo "Finished!"
echo "Building directories..."
# Add directories
cd
mkdir -p WorkBench
mkdir -p WorkBench/GitHub
mkdir -p WorkBench/pyenvs
mkdir -p WorkBench/sandbox
mkdir -p WorkBench/sandbox/analysis
mkdir -p WorkBench/sandbox/scrap

echo "Cloning dotfiles..."
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
/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME checkout
# Set to not show untracked files
/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME config --local status.showUntrackedFiles no

# Set system preferences
echo
echo "Setting system preferences (GNOME)"
dconf load / < ~/.config/dconf-settings.ini


# Packages
echo
echo "Installing software..."
curl -fsSL https://starship.rs/install.sh | bash
xargs -a ~/.config/packages.list sudo apt install -y -qq 


echo
echo "Setting up tools..."
# Tools

