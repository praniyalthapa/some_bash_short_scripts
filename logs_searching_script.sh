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
bng_file=$(ls -lhtr | grep "$date_frame" | grep "$time_frame" | awk '{print $9}')


if [ -z "$bng_file" ]; then
  echo "No file found for time $time_frame"
  exit 1
else
  echo "Found name is : $bng_file"
fi
read -p "Enter the exact time you want to search" exact_frame
read -p "Do you have ending time frame too(yes or no).If yes enter the ending time otherwise enter no:" ending_frame
read -p "Enter the IP ADDRESS to be searched:" searched_ip
read -p "Enter destination IP ADDRESS if need:(if not type no)" destination_ip
echo $searched_ip
if [ $ending_frame == "no" ];then
	if [ "$destination_ip" != "no" ]; then
        zcat "$bng_file" | grep "$searched_ip" | grep "$exact_frame" | grep -E "^${dest_ip//./\\.}" | grep "JSERVICES_SESSION_OPEN: application:none" 
    else
        zcat "$bng_file" | grep "$searched_ip" | grep "$exact_frame" | grep "JSERVICES_SESSION_OPEN: application:none"
    fi

else
start_hour=${exact_frame%%:*}
start_minute=${exact_frame##*:}
end_hour=${ending_frame%%:*}
end_minute=${ending_frame##*:}

# Generate time pattern list
time_pattern=""
for (( h=start_hour; h<=end_hour; h++ )); do
    for (( m=0; m<60; m++ )); do
        # Pad hour and minute
        hh=$(printf "%02d" $h)
        mm=$(printf "%02d" $m)
        # Break if we're past the end time
        if [[ "$hh:$mm" > "$ending_frame" ]]; then
            break 2
        fi
        # Skip times before start
        if [[ "$hh:$mm" < "$exact_frame" ]]; then
            continue
        fi
        time_pattern+="$hh:$mm|"
    done
done

# Trim the trailing '|'
time_pattern="${time_pattern%|}"
zcat somefile.gz | grep '$searched_ip' | grep 'JSERVICES_SESSION_OPEN: application:none' | grep -E "$time_pattern"

fi