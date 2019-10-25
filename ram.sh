#!/bin/bash

###############################################################################
#gettting ram information
###############################################################################

function getRAM
{
	local memory=$(free -mht | grep Mem)

	local total=$(echo $memory | awk '{print $2}')
	local used=$(echo $memory | awk '{print $3}')
	local free=$(echo $memory | awk '{print $4}')
	cat >> sysinfo.json <<EOF
        "memory-usage:"
        {
		"total": "$total",
		"used": "$used",
		"free": "$free"
	},
EOF
}

