cd /McServer

java -Xmx10G -Xms10G -jar forge.jar nogui

git add .
git commit -m "initial commit"

git push https://$(cat /run/secrets/API_KEY)@github.com/GANZO-MAN-008/McServer.git master
