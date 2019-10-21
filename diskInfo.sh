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
        "Disk Info:"
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
                        "Filesystem": "$filesystem",
                        "Size": "$size",
			"Used": "$used",
			"Available": "$available",
			"Use%": "$use",
			"Mounted on": "$mounted"
                }
EOF
		comma=","
	done <<< "$disk_patritions"

cat >> sysinfo.json <<EOF
        ],
EOF
}
