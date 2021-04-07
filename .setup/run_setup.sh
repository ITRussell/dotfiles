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
curl -i https://api.github.com/users/ITRussell/repos | grep -e 'clone_url*' | cut -d \" -f 4 | xargs -L1 git clone &>> setup.log
cd 

# Packages
echo
echo "Installing software..."
curl -fsSL https://starship.rs/install.sh | bash
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

# Sync fish history
cp ~/.local/share/fish/backup_fish ~/.local/share/fish/fish_history

# Setup python
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

sudo reboot
