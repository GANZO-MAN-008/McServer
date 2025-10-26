#!/bin/bash

# Stay in the correct directory
cd /McServer

# Accept EULA (in case it's not in the image)
echo "eula=true" > eula.txt

echo "Starting Minecraft Forge Server..."
ls -la

# Start server with reasonable memory allocation
java -Xmx10G -Xms10G -jar forge.jar nogui

# After server stops, try to push changes (if API_KEY exists)
if [ -f /run/secrets/API_KEY ]; then
    echo "Pushing changes to GitHub..."
    
    # Add and commit changes
    git add .
    git commit -m "Server data update $(date)" || echo "Nothing to commit"
    
    # Push using API key
    API_KEY=$(cat /run/secrets/API_KEY)
    git push https://${API_KEY}@github.com/GANZO-MAN-008/McServer.git HEAD:master || echo "Push failed"
else
    echo "No API_KEY found, skipping git push"
fi
