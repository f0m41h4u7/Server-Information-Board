#!/bin/bash

###############################################################################
#getting route table information
###############################################################################

function getRoute
{
	local route_table=$(route -n | tail -n +3)
	local comma=""
cat >> sysinfo.json <<EOF
	"Route Table Info:"
        [
EOF

	while read -r line; do
	        local destination=$(echo $line | awk '{print $1}')
        	local gateway=$(echo $line | awk '{print $2}')
	        local genmask=$(echo $line | awk '{print $3}')
        	local flags=$(echo $line | awk '{print $4}')
	        local metric=$(echo $line | awk -F" " '{print $5}')
        	local ref=$(echo $line | awk -F" " '{print $6}')
		local use=$(echo $line | awk -F" " '{print $7}')
		local iface=$(echo $line | awk -F" " '{print $8}')

	        cat >> sysinfo.json <<EOF
		$comma
                {       
                        "Destination": "$destination",
                        "Gateway": "$gateway",
                        "Genmask": "$genmask",
                        "Flags": "$flags",
                        "Metric": "$metric",
                        "Ref": "$ref"
			"Use": "$use"
			"Iface": "$iface"
                }
EOF
		comma=","
	done <<< "$route_table"

cat >> sysinfo.json <<EOF
        ],
EOF
}
