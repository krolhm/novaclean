#!/bin/bash
bytesToHuman() {
    b=${1:-0}; d=''; s=0; S=(Bytes {K,M,G,T,E,P,Y,Z}iB)
    while ((b > 1024)); do
        d="$(printf ".%02d" $((b % 1024 * 100 / 1024)))"
        b=$((b / 1024))
        (( s++ ))
    done
    echo "\033[1m\033[32m→ $b$d ${S[$s]} ont été supprimé [✓]"
    osascript -e 'display notification "'$b''$d' '${S[$s]}' ont été supprimé avec succès 🥳" with title "NovaClean"'
}

  clear
  echo ""
  echo " ███╗   ██╗ ██████╗ ██╗   ██╗ █████╗  ██████╗██╗     ███████╗ █████╗ ███╗   ██╗"
  echo ' ████╗  ██║██╔═══██╗██║   ██║██╔══██╗██╔════╝██║     ██╔════╝██╔══██╗████╗  ██║'
  echo " ██╔██╗ ██║██║   ██║██║   ██║███████║██║     ██║     █████╗  ███████║██╔██╗ ██║"
  echo ' ██║╚██╗██║██║   ██║╚██╗ ██╔╝██╔══██║██║     ██║     ██╔══╝  ██╔══██║██║╚██╗██║'
  echo " ██║ ╚████║╚██████╔╝ ╚████╔╝ ██║  ██║╚██████╗███████╗███████╗██║  ██║██║ ╚████║"
  echo " ╚═╝  ╚═══╝ ╚═════╝   ╚═══╝  ╚═╝  ╚═╝ ╚═════╝╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝"
  echo "  by Krolhm"
  echo ""
oldAvailable=$(df / | tail -1 | awk '{print $4}')

echo "\033[1m→ Netoyage du mac de $USER...\033[0m\033[31m"
sudo -v

sudo rm -rf /Library/Caches/*
echo "\033[1m\033[32m→ Netoyage Caches Terminé [✓]\033[0m\033[31m"

sudo rm -rf /Library/logs/*
echo "\033[1m\033[32m→ Netoyage Logs Terminé [✓]\033[0m\033[31m"

rm -rfv ~/Library/Developer/Xcode/DerivedData/* &>/dev/null
rm -rfv ~/Library/Developer/Xcode/Archives/* &>/dev/null
echo "\033[1m\033[32m→ Netoyage XCode Terminé [✓]\033[0m\033[31m"

sudo rm -rfv ~/Library/Application\ Support/Adobe/Common/Media\ Cache\ Files/* &>/dev/null
echo "\033[1m\033[32m→ Netoyage Adobe Terminé [✓]\033[0m\033[31m"

gem cleanup > /dev/null 2>&1
echo "\033[1m\033[32m→ Netoyage Ruby Terminé [✓]\033[0m\033[31m"

sudo rm -rfv /Volumes/*/.Trashes > /dev/null 2>&1
sudo rm -rf ~/.Trash/*
echo "\033[1m\033[32m→ Netoyage Corbeille Terminé [✓]\033[0m\033[31m"

sudo rm -rf /Users/$USER/Downloads/*.dmg
echo "\033[1m\033[32m→ Netoyage .dmg téléchargés Terminé [✓]\033[0m\033[31m"

sudo purge
echo "\033[1m\033[32m→ Purge Ram Mac [✓]\033[0m\033[31m"

newAvailable=$(df / | tail -1 | awk '{print $4}')
count=$((oldAvailable - newAvailable))

bytesToHuman $count
#displaynotification "$count" with title "NovaClean"
exit