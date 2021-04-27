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

echo
echo "Cloning my repos..."

# Cloning my projects
cd ~/WorkBench/GitHub/
curl -i https://api.github.com/users/ITRussell/repos | grep -e 'clone_url*' | cut -d \" -f 4 | xargs -L1 git clone 
cd 

# Packages
echo
echo "Installing software..."
curl -fsSL https://starship.rs/install.sh | bash
xargs -a ~/.config/packages.list sudo apt install -y -qq 
sudo npm i -g yarn 
sudo apt-get install fuse libfuse2 git python3-pip ack-grep -y 
sudo apt install python3-venv -y 
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add - 
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" -y 
sudo apt install code -y 
sudo apt install atom -y 
sudo apt-get update 
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add - 
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list 
sudo apt install sublime-text -y 

echo
echo "Setting up tools..."
# Tools

# Sync fish history
cp ~/.local/share/fish/backup_fish ~/.local/share/fish/fish_history

# Setup python
python3 -m venv ~/WorkBench/pyenvs/analysis-env 
source ~/WorkBench/pyenvs/analysis-env/bin/activate 
pip install jupyter 
pip install jupyterlab
pip install pandas
pip install numpy
pip install scikit-learn
pip install altair
pip install matplotlib
deactivate

echo
echo "Installing VSCode extensions..."

# VS Code
code
sudo killall code
code --install-extension ms-python.python 
code --install-extension ms-toolsai.jupyter


if [ $ANS = 'y' ] || [ $ANS = 'Y' ];
then
	echo
	echo "Installing Flatpaks..."
	sudo apt install flatpak
	flatpak install flathub md.obsidian.Obsidian -y
	flatpak install flathub com.mojang.Minecraft -y
	flatpak install flathub org.signal.Signal -y
	flatpak install flathub com.valvesoftware.Steam -y 
	flatpak install flathub com.discordapp.Discord -y
	flatpak install flathub org.videolan.VLC -y
	flatpak install flathub ca.littlesvr.asunder -y
	flatpak install flathub org.gnome.Lollypop -y
	flatpak install flathub org.chromium.Chromium -y
fi

sudo reboot
