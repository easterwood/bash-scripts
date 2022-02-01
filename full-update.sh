#!/bin/bash
messageStart="Start full update"
echo "$messageStart"
./notify-send-all.sh -u critical "$messageStart" &
wall "$messageStart"

apt full-upgrade -y

messageEnd="Full update completed"
echo "$messageEnd"
./notify-send-all.sh -u critical "$messageEnd" &
wall "$messageEnd"
