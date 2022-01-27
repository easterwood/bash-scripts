#!/bin/bash
notify-send "Start simple backup" &
rsync -ahE --info=progress2 --no-i-r --delete $1 $2
notify-send "Simple backup completed" &
