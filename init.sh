#!/bin/bash

sudo apt update
sudo apt install openjdk-18-jre-headless jq


query=$(curl https://api.papermc.io/v2/projects/paper/versions/1.19/builds)

projectVersion=$(echo $query | jq -r '.version')

buildNumber=$(echo $query | jq -r '.builds[-1].build')

fileName=$(echo $query | jq -r '.builds[-1].downloads.application.name')

wget https://api.papermc.io/v2/projects/paper/versions/$projectVersion/builds/$buildNumber/downloads/$fileName