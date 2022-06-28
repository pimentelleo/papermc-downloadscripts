#!/bin/bash

sudo apt update
sudo apt install openjdk-18-jre-headless jq


query=$(curl https://api.papermc.io/v2/projects/paper/versions/1.19/builds)

projectVersion=$(echo $query | jq -r '.version')

buildNumber=$(echo $query | jq -r '.builds[-1].build')

fileName=$(echo $query | jq -r '.builds[-1].downloads.application.name')

wget -O paper.jar https://api.papermc.io/v2/projects/paper/versions/$projectVersion/builds/$buildNumber/downloads/$fileName

sudo iptables -I INPUT 6 -m state --state NEW -p tcp --dport 17666 -j ACCEPT
sudo iptables -I INPUT 6 -m state --state NEW -p udp --dport 19666 -j ACCEPT
sudo iptables -I INPUT 6 -m state --state NEW -p tcp --dport 80 -j ACCEPT