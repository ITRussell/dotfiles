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
touch setup.log
sudo apt update &>> setup.log && sudo apt upgrade -y &>> setup.log
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

# Define the alias in the current shell scope:
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# backup any existing configs
mkdir -p .config-backup && \
config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
xargs -I{} mv {} .config-backup/{}

# Checkout
config checkout
# Set to not show untracked files
config config --local status.showUntrackedFiles no

# Set system preferences
echo
echo "Setting system preferences (GNOME)"
crontab ~/.config/crontabs
sudo systemctl start cron
sudo service start cron
sudo update-rc.d cron defaults
dconf load / < ~/.config/dconf-settings.ini

# Packages
echo
echo "Installing software..."

xargs -a ~/.config/packages.list sudo apt install -y -qq &>> setup.log  
sudo npm i -g yarn &>> setup.log  
sudo apt-get install fuse libfuse2 git python3-pip ack-grep -y &>> setup.log 
sudo apt install python3-venv -y &>> setup.log  
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add - &>> setup.log 
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" -y &>> setup.log  
sudo apt install code -y &>> setup.log  
sudo apt install atom -y &>> setup.log  
sudo apt-get update &>> setup.log  
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add - &>> setup.log 
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list &>> setup.log 
sudo apt install sublime-text -y &>> setup.log 

echo
echo "Setting up tools..."
# Tools
python3 -m venv ~/WorkBench/pyenvs/analysis-env &>> setup.log  
source ~/WorkBench/pyenvs/analysis-env/bin/activate &>> setup.log  
pip install jupyter &>> setup.log  
pip install jupyterlab &>> setup.log  
pip install pandas &>> setup.log  
pip install numpy &>> setup.log  
pip install scikit-learn &>> setup.log  
pip install altair &>> setup.log  
pip install matplotlib &>> setup.log  
deactivate

echo
echo "Installing VSCode extensions..."
# VS Code
code 
sudo killall code
code --install-extension ms-python.python &>> setup.log
code --install-extension ms-toolsai.jupyter &>> setup.log


if [ $ANS = 'y' ] || [ $ANS = 'Y' ];
then
	echo
	echo "Installing Flatpaks..."
	sudo apt install flatpak &>> setup.log
	flatpak install flathub md.obsidian.Obsidian -y &>> setup.log
	flatpak install flathub com.mojang.Minecraft -y &>> setup.log
	flatpak install flathub org.signal.Signal -y &>> setup.log
	flatpak install flathub com.valvesoftware.Steam -y &>> setup.log
	flatpak install flathub com.discordapp.Discord -y &>> setup.log
	flatpak install flathub org.videolan.VLC -y &>> setup.log
	flatpak install flathub ca.littlesvr.asunder -y &>> setup.log
	flatpak install flathub org.gnome.Lollypop -y &>> setup.log
	flatpak install flathub org.chromium.Chromium -y &>> setup.log
fi
