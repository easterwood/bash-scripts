#!/bin/bash
# Wake up PC every business day from specified state.
#
# This script selects the next business day from now and sets
# a wake up timer. Afterwards it puts the PC into some sleep state.
# The sleep state can be selected via the first argument. The default is
# 'disk'. Supported sleep states see 'rtcwake -m'.

DEFAULT_OFF_MODE="disk"

mode=${1:-DEFAULT_OFF_MODE}
dayIdx=1
dayName=$(date +%a -d "now + $dayIdx days 6:00" | tr '[:lower:]' '[:upper:]')

echo "Day of tomorrow $dayName"

while [ "$dayName" == "SA" -o "$dayName" == "SO" ]
do
  dayIdx=$((dayIdx+1))
  echo "Plus $dayIdx days"
  dayName=$(date +%a -d "now + $dayIdx days 6:00" | tr '[:lower:]' '[:upper:]')
  echo "Resulting day name $dayName"
done

if [ "$dayName" != "SA" -a "$dayName" != "SO" ]
then
    selected=$(date +"%Y-%m-%d %H:%M:%S" -d "now + $dayIdx days 6:00")
    seconds=$(date -d"$selected" +%s)
   
    echo "Restart PC at $selected (in seconds $seconds)"
    sleepBeforeStop=60
    message="Host will going to sleep in $sleepBeforeStop seconds. Restart is expected at $selected"
    wall "$message"
    ./notify-send-all.sh -u critical -t 0 "$message" &
    sleep $sleepBeforeStop
    /usr/sbin/rtcwake -m $DEFAULT_OFF_MODE -t $seconds
else
    echo "Wrong day calculated: $dayName"
    exit 1
fi
