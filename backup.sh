#!/bin/bash
source_path="/home/praniyal/demo/demo.txt"
dest_path="/home/praniyal/dest"
backup_name="backup_$(date '+%Y%m%d_%H%M%S').tar.gz"
if [ -f $source_path ];then
	echo "backup source file is found"
else
	echo "backup source file is not found so we can't perform backup"
	exit 1
fi
tar -czf "$dest_path/$backup_name" "$source_path" 2>/dev/null 
if [ $? -eq 0 ] ;then
	echo "backup is taken at $dest_path successfully"
else
	echo "Sorry backup cannot be taken"
	exit 1
fi
