#!/bin/bash
basePath=$(dirname $0)
"$basePath"/notify-send-all.sh "Start simple backup" 
rsync -ahE --info=progress2 --no-i-r --delete $1 $2
"$basePath"/notify-send-all.sh "Simple backup completed" 
