#!/bin/bash

query=$(curl https://api.papermc.io/v2/projects/paper/versions/1.19/builds)
projectVersion=$(echo $query | jq -r '.version')
buildNumber=$(echo $query | jq -r '.builds[-1].build')
fileName=$(echo $query | jq -r '.builds[-1].downloads.application.name')


read -r -p "Atualizar Geyser? [y/N] " response
case "$response" in
[yY][eE][sS]|[yY]) 
    cd plugins
    rm -rf Geyser-Spigot.jar
    wget https://ci.opencollab.dev//job/GeyserMC/job/Geyser/job/master/lastSuccessfulBuild/artifact/bootstrap/spigot/target/Geyser-Spigot.jar
    cd ..
    ;;
    *)
    ;;
esac

read -r -p "Atualizar Paper? [y/N] " response
case "$response" in
[yY][eE][sS]|[yY]) 
    rm -rf paper.jar
    wget -O paper.jar https://api.papermc.io/v2/projects/paper/versions/$projectVersion/builds/$buildNumber/downloads/$fileName
    ;;
    *)
    ;;
esac

java -Xmx14G -Xms3G -jar paper.jar -o true

