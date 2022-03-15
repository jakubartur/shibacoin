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
sudo apt-get install git curl cmake automake python3 bsdmainutils libtool autotools-dev libboost-all-dev libssl-dev libevent-dev libdb++-dev libminiupnpc-dev libnatpmp-dev systemtap-sdt-dev libprotobuf-dev protobuf-compiler libzmq3-dev libsqlite3-dev pkg-config net-tools build-essential -y &&
sudo apt gen install sudo apt-get install libqt5gui5 libqt5core5a libqt5dbus5 qttools5-dev qttools5-dev-tools -y && 
sudo apt install qtwayland5 -y && 
sudo apt-get install libqrencode-dev -y && 

sed -i 's/__atomic_compare_exchange/__atomic_compare_exchange_db/g' db-4.8.30.NC/dbinc/atomic.h

# Install the repository ppa:bitcoin/bitcoin
sudo apt-get install software-properties-common -y &&
sudo apt-get update -y &&

cd ~ 
cd mbrocoin

./contrib/install_db4.sh `pwd`

export BDB_PREFIX='${BDB_PREFIX}'
./configure BDB_LIBS="-L${BDB_PREFIX}/lib -ldb_cxx-4.8" BDB_CFLAGS="-I${BDB_PREFIX}/include

cd ~
cd mbrocoin

./autogen.sh &&

./configure --enable-upnp-default --enable-natpmp-default --enable-hardening LDFLAGS="-L${BDB_PREFIX}/lib/" CPPFLAGS="-I${BDB_PREFIX}/include/" CXXFLAGS="--param ggc-min-expand=1 --param ggc-min-heapsize=32768"

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
