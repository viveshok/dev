
# small script to bootstrap a Debian desktop


sudo apt-get install chromium-browser
sudo apt-get install git
sudo apt-get install vim
sudo apt-get install tmux
sudo apt-get install scrot
sudo apt-get install curl
sudo apt-get install acpi

echo 'source ~/.bash_profile' >> ~/.bashrc

echo 'pinentry-program /usr/bin/pinentry-curses' >> ~/.gnupg/gpg-agent.conf
gpg-connect-agent reloadagent /bye

wget https://repo.continuum.io/archive/Anaconda3-4.3.1-Linux-x86_64.sh
bash Anaconda3-4.3.1-Linux-x86_64.sh -b
echo 'export PATH="/home/abeaulne/anaconda3/bin:$PATH"' >> ~/.bashrc

pip install awscli

# install docker
sudo apt-get -y install apt-transport-https ca-certificates
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
RELEASE=$(lsb_release -cs)
REPO="deb [arch=amd64] https://download.docker.com/linux/ubuntu $RELEASE edge"
sudo add-apt-repository "$REPO"
sudo apt-get update
sudo apt-get -y install docker-ce
sudo docker run hello-world

## list wifi networks:
# $ nmcli dev wifi list
## connect to a wifi network
# $ nmcli dev wifi connect <NETWORK NAME/SSID> password <PASSWORD>
## show status:
# $ nmcli c show
## restart network manager
# $ sudo service network-manager restart
