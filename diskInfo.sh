#!/bin/bash

###############################################################################
#getting information about disk into a variable; reading only 2nd 
#line of the command output, bc 1st line contains only headers;
##############################################################################
function getDiskInfo
{
	local disk_patritions=$(df -h | tail -n +2)
	local comma=""
	cat >> sysinfo.json <<EOF
        "disk-info":
        [
EOF

	while read -r line; do
        	local filesystem=$(echo $line | awk '{print $1}')
		local size=$(echo $line | awk '{print $2}')
        	local used=$(echo $line | awk '{print $3}')
		local available=$(echo $line | awk '{print $4}')
        	local use=$(echo $line | awk '{print $5}')
		local mounted=$(echo $line | awk '{print $6}')
	        cat >> sysinfo.json <<EOF
		$comma
                {       
                        "fs": "$filesystem",
                        "size": "$size",
			"used": "$used",
			"available": "$available",
			"use": "$use",
			"mounted-on": "$mounted"
                }
EOF
		comma=","
	done <<< "$disk_patritions"

cat >> sysinfo.json <<EOF
        ],
EOF
}
