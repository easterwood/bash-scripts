#!/bin/bash
basePath=$(dirname $0)
messageStart="Start full update"
echo "$messageStart"
"$basePath"/notify-send-all.sh "$messageStart" 
wall "$messageStart"

apt full-upgrade -y

messageEnd="Full update completed"
echo "$messageEnd"
"$basePath"/notify-send-all.sh "$messageEnd" 
wall "$messageEnd"
