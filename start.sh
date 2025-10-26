#!/bin/bash

# Stay in the correct directory
cd /McServer

# Accept EULA (in case it's not in the image)
echo "eula=true" > eula.txt

#echo "Starting Minecraft Forge Server..."
ls -la

# Start server with reasonable memory allocation
#java -Xmx10G -Xms10G -jar forge.jar nogui
git config --global user.email $EMAIL
git config --global user.name $USERNAME

# After server stops, try to push changes (if API_KEY exists)
git add .
git commit -m "Server data update $(date)" || echo "Nothing to commit"
    
API_KEY=$(cat /run/secrets/API_KEY)
git push https://${API_KEY}@github.com/GANZO-MAN-008/McServer.git HEAD:master || echo "Push failed"
