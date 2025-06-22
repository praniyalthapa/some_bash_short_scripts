#!/bin/bash
input="names.csv"
while IFS=',' read -r loginname name
do
	echo "adding $loginname"
	useradd -c "$name" -m $loginname
done < "$input"