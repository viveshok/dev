
# small script to bootstrap a Debian desktop

set -e # exit at first error

sudo apt-get install chromium-browser
sudo apt-get install git
sudo apt-get install vim
sudo apt-get install tmux
sudo apt-get install curl
#sudo apt-get install scrot # screenshots
sudo apt-get install flameshot # screenshots
#sudo apt install simplescreenrecorder # screen recordings
sudo apt-get install mosh # mobile shell
sudo apt-get install acpi # check battery power
sudo apt-get install rlwrap
sudo apt-get install xclip # pipe stuff in clipboard
sudo apt-get install htop
#sudo apt-get install texlive-full # LaTeX
#sudo apt-get install gtk2.0 # dependency of ledger
#sudo apt-get install mbpfan # macbook fan mgmt
#sudo apt-get install wamerican # dictionary in /usr/share/dict/words

echo 'pinentry-program /usr/bin/pinentry-curses' >> ~/.gnupg/gpg-agent.conf
gpg-connect-agent reloadagent /bye

# Miniconda
wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh -b
echo 'export PATH="~/miniconda3/bin:$PATH"' >> ~/.bashrc

# AWS
pip install awscli

# install docker
bash get-docker.sh
sudo usermod -aG docker abeaulne
sudo docker run hello-world

