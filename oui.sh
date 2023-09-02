#!/bin/bash

FILE="/tmp/oui.txt"
SOURCE="https://gitlab.com/wireshark/wireshark/-/raw/master/manuf"

if [[ ! -f "${FILE}" ]]; then
    echo "$FILE not found. Downloading it from ${SOURCE}"
    wget -qO "$FILE" https://gitlab.com/wireshark/wireshark/-/raw/master/manuf
else
    echo -e "\nFile $FILE found\n"
fi

for i in $*; do
    MAC=$(echo $i | tr 'a-f' 'A-F')
    MANUFACTURER=$(grep -i "${MAC:0:8}" $FILE)
    echo "MAC_ADDRESS: ${MAC} -- $MANUFACTURER"
done
