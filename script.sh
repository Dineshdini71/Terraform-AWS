#!/bin/bash
for I in {1..10}; do
    echo $I
    sudo useradd -m pubg$I --shell /bin/bash
    sudo useradd -m bgmi$I --shell /bin/bash

    sleep 1
done
cat /etc/passwd | grep -i ansible
sudo apt install -y stress jq net-tools
ps -ef | grep -i stress







# for I in {1..10}; do
#     echo $I
#     sudo useradd -m powerstar$I --shell /bin/bash
#     sudo useradd -m naturalstar$I --shell /bin/bash
#     sleep 1
# done
# cat /etc/passwd | grep -i ansible
# sudo apt install -y stress jq net-tools
# ps -ef | grep -i nginx