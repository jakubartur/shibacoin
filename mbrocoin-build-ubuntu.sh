#!/bin/sh

swapoff -a
fallocate -l 3G /swapfile  
chown root:root /swapfile  
chmod 0600 /swapfile  
sudo bash -c "echo 'vm.swappiness = 10' >> /etc/sysctl.conf"  
mkswap /swapfile  
swapon /swapfile    
echo '/swapfile none swap sw 0 0' >> /etc/fstab
free -m 
df -h

rm -rf ~/root/.mbrocoin

cd ~ && sudo apt-get update && sudo apt-get upgrade -y &&
sudo apt-get install git curl cmake automake python3 bsdmainutils libtool autotools-dev libboost-all-dev libssl-dev libevent-dev libdb++-dev libminiupnpc-dev libprotobuf-dev protobuf-compiler pkg-config net-tools build-essential -y &&

sed -i 's/__atomic_compare_exchange/__atomic_compare_exchange_db/g' db-4.8.30.NC/dbinc/atomic.h

# Install the repository ppa:bitcoin/bitcoin
sudo apt-get install software-properties-common -y &&
sudo add-apt-repository ppa:bitcoin/bitcoin -y &&
sudo apt-get update -y &&
sudo apt install libdb5.3++ libdb5.3++-dev -y && 


cd ~ 
cd mbrocoin

chmod +x ~/mbrocoin/*.*
chmod +x ~/mbrocoin/src

cd ~

./autogen.sh &&

./configure --disable-wallet

make && make install

sudo ufw enable -y 
sudo ufw allow 14141/tcp
sudo ufw allow 14142/tcp
sudo ufw allow 22/tcp

sudo mkdir ~/.mbrocoin

cat << "CONFIG" >> ~/.mbrocoin/mbrocoin.conf
daemon=1
listen=1
server=1
staking=0
rpcport=14141
port=14142
rpcuser=MMyw8qFmVbsttGuPD787oLvmb4kPr796Yx
rpcpassword=c=MBRO
rpcconnect=127.0.0.1
rpcallowip=127.0.0.1
addnode=51.195.249.132
addnode=158.69.130.185
CONFIG

chmod 700 ~/.mbrocoin/mbrocoin.conf
chmod 700 ~/.mbrocoin
ls -la ~/.mbrocoin 
cd ~
cd /usr/local/bin 

mbrocoind -daemon -txindex
