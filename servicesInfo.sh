#!/bin/bash

###############################################################################
#getting information about running services
###############################################################################

function getServices
{
	local processes=$(systemctl list-units | grep running| sort)
	local comma=""
	cat >> sysinfo.json <<EOF
	"running-services":
	[
EOF

	while read -r line; do
        	local name=$(echo $line | awk '{print $1}')
	        local state=$(echo $line | awk '{print $2}')
		name+=","
	        state+=$(echo $line | awk -F" " '{print $3}')
		state+=", " 
		state+=$(echo $line | awk -F" " '{print $4}')
		
        cat >> sysinfo.json <<EOF
		$comma
        	{       
                	"unit": "$name",
	                "status": "$state"
        	}
EOF
		comma=","
	done <<< "$processes"

cat >> sysinfo.json <<EOF
	],
EOF
}
