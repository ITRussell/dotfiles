
#!/bin/bash
echo "########################################################"
echo "######                                           #######"
echo "######     Would you like to install extras?     #######"
echo "######                   Y/n                     #######"
echo "######                                           #######"
echo "########################################################"

read ANS
# Run scripts together
sudo apt update && sudo apt upgrade -y

# CLI Configuration
#########################################################################################
echo ""
echo "########################"
echo "!  Installing Tools   !"
echo "########################"
echo ""

# GIT #
###########################################################################################

# Git Configuration
echo "Configuring Git..."
echo ""
echo "Enter the Global Username for Git:";
GITUSER="ITRussell";
git config --global user.name "${GITUSER}"

echo "Enter the Global Email for Git:";
GITEMAIL="IanThomasR@gmail.com";
git config --global user.email "${GITEMAIL}"

echo 'Git has been configured!'
git config --list

# Packages
sudo apt update
sudo apt install alacritty
sudo apt install c
sudo apt install trash-cli -y
sudo apt install neofetch -y
sudo apt install htop -y
sudo apt install fzf -y
sudo apt install ripgrep -y
sudo apt install universal-ctags -y
sudo apt install silversearcher-ag -y
sudo apt install fd-find -y
sudo apt install neovim -y
sudo apt install nodejs -y
sudo apt install npm -y
sudo npm i -g yarn
sudo apt-get install fuse libfuse2 git python3-pip ack-grep -y
sudo curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
sudo curl -L -s https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
sudo chmod a+rx /usr/local/bin/youtube-dl

echo ""
echo "###############################"
echo "!  Setting up your workspace  !"
echo "###############################"
echo ""

# Add directories
cd
mkdir -p WorkBench
mkdir -p WorkBench/GitHub
mkdir -p WorkBench/pyenvs
mkdir -p WorkBench/sandbox
mkdir -p WorkBench/sandbox/analysis
mkdir -p WorkBench/sandbox/scrap


echo ""
echo "###############################"
echo "!  Setting up languages       !"
echo "###############################"
echo ""

# Tools
sudo apt install python3-venv -y
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


echo ""
echo "Final Touches..."

echo ""
echo "################################"
echo "!  Installing desktop packages !"
echo "################################"
echo ""

wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" -y
sudo apt install code -y
sudo apt install atom -y
sudo apt-get update
sudo apt-get install zeal -y
sudo apt install firefox -y


# VS Code
code 
sleep 1
code --install-extension ms-python.python
code --install-extension ms-toolsai.jupyter
sudo killall code

if [ $ANS = 'y' ] || [ $ANS = 'Y'];
then
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

