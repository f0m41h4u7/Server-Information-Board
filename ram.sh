#!/bin/bash

###############################################################################
#gettting ram information
###############################################################################

function getRAM
{
	local memory=$(free -mht | grep Mem)

	local total=$(echo $memory | awk '{print $1}')
	local used=$(echo $memory | awk '{print $2}')
	local free=$(echo $memory | awk '{print $3}')
	cat >> sysinfo.json <<EOF
        "Memory(RAM) Info:"
        {
		"Total": "$total",
		"Used": "$used",
		"Free": "$free"
	},
EOF
}

