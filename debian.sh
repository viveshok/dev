
# small script to bootstrap a Debian desktop

sudo apt-get install chromium-browser
sudo apt-get install git
sudo apt-get install vim
sudo apt-get install tmux
sudo apt-get install scrot

echo 'source ~/.bash_profile' >> ~/.bashrc

echo 'pinentry-program /usr/bin/pinentry-curses' >> ~/.gnupg/gpg-agent.conf
gpg-connect-agent reloadagent /bye

wget https://repo.continuum.io/archive/Anaconda3-4.3.1-Linux-x86_64.sh
bash Anaconda3-4.3.1-Linux-x86_64.sh -b
echo 'export PATH="/home/abeaulne/anaconda3/bin:$PATH"' >> ~/.bashrc

pip install awscli
