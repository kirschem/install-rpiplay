#!/bin/bash
set -e
if [[ $(id -u) -ne 0 ]] ; then echo "Please run as root" ; exit 1 ; fi

git clone https://github.com/FD-/RPiPlay.git
cd RPiPlay

sudo apt-get install cmake
sudo apt-get install libavahi-compat-libdnssd-dev
sudo apt-get install libssl-dev
mkdir build
cd build
cmake --DCMAKE_CXX_FLAGS="-O3" --DCMAKE_C_FLAGS="-O3" ..
make

cp ./rpiplay /usr/bin/

cp rpiplay.service /lib/systemd/system/
chmod 644 /lib/systemd/system/rpiplay.service
sudo systemctl daemon-reload
sudo systemctl enable rpiplay.service