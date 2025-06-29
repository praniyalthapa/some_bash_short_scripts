#!/bin/bash

echo "Searching for logs in /mnt ..."
cd /mnt 
echo "Listing log directories by date (oldest first):"
ls -lhtr | awk '{print $9}'
read -p "Enter the bng name: " bng_name

echo "Getting inside $bng_name"
cd $bng_name
read -p "Enter the date frame:" date_frame
echo "Your date frame is: $date_frame"
search_result=$(ls -lhtr | grep "$date_frame")

if [ -z "$search_result" ]; then
    echo "Not found or date format is not proper"
else
    echo "$search_result"
fi
read -p "Enter the time frame (e.g., 07:13):" time_frame

# Search the ls -lhtr output for the time_frame, get the filename (9th column)
echo $(pwd)
bng_file=$(ls -lhtr  | grep "$date_frame" | grep "$time_frame" | awk '{print $9}')

if [ -z "$bng_file" ]; then
  echo "No file found for time $time_frame"
  exit 1
else
  echo "Found name is : $bng_file"
fi
read -p "Enter the exact time you want to search: " exact_frame

read -p "Enter the IP ADDRESS to be searched:" searched_ip
read -p "Enter complete destination IP (yes or no) :" destination_ip
read -p "Enter starting octet of destination IP: " first_octet

echo $searched_ip

   if [ "$destination_ip" == "no" ]; then
	  

        
       zcat "$bng_file" | grep "$searched_ip" | grep "$exact_frame" | grep -E "\b$first_octet(\.[0-9]{1,3}){3}\b" | grep "JSERVICES_SESSION_OPEN: application:none"

    else
       # zcat "$bng_file" | grep "$searched_ip" | grep "$exact_frame" | grep "JSERVICES_SESSION_OPEN: application:none"
       zcat "$bng_file" | grep "$searched_ip" | grep "$exact_frame" | grep -E "\b${destination_ip//./\\.}\b" | grep "JSERVICES_SESSION_OPEN: application:none"
   fi
