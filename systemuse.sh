#!/bin/bash

data=$(awk 'NR>1' systemuse.txt)
echo $data
usage=$(awk '{print $5}')
echo $usage