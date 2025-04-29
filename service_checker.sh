#!/bin/bash

services=("ssh" "cron" "apache2")

for service in "${services[@]}"
do
    status=$(systemctl is-active "$service")
    echo "Service $service is $status"
done
