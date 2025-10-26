#!/bin/bash

# Stay in the correct directory
cd /McServer

# Accept EULA (in case it's not in the image)
echo "eula=true" > eula.txt

#echo "Starting Minecraft Forge Server..."
ls -la

# Start server with reasonable memory allocation
timeout 7200 java -Xmx10G -Xms10G -jar forge.jar nogui

git config --global user.email $EMAIL
git config --global user.name $USERNAME

# After server stops, try to push changes (if API_KEY exists)
git config pull.rebase false
git pull origin master


git add .
git commit -m "Server data update $(date)" || echo "Nothing to commit"
    
API_KEY=$(echo $API_KEY)
git remote set-url origin https://${API_KEY}@github.com/GANZO-MAN-008/McServer.git
git push origin master
