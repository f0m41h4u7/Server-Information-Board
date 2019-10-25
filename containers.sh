#!/bin/bash

###############################################################################
#getting information about docker containers into a variable; reading only 2nd 
#line of the command output, bc 1st line contains only headers;
##############################################################################

function getContainers
{
	local containers=$(docker ps -a | tail -n +2)
	local comma=""
	cat >> sysinfo.json <<EOF
        "docker-containers:"
        [
EOF

	while read -r line; do
        	local id=$(echo $line | awk -F" " '{print $1}')
	        local image=$(echo $line | awk -F" " '{print $2}')
        	local action=$(echo $line | egrep -o '[/"][a-zA-Z0-9 /./,]+[/"]')
	        local created=$(echo $line | awk '{print $5 " " $6 " " $7}')
        	local stat=$(echo $line | awk -F" " '{print $8}')
	        local ports=$(echo $line | awk -F" " '{print $13}' | egrep -o '[0-9\.\: ]')
        	local name=$(echo $line | awk -F" " '{print $NF}')
        	cat >> sysinfo.json <<EOF
		$comma
                {       
                        "id": "$id",
                        "image": "$image",
                        "command": $action,
                        "created": "$created",
                        "status": "$stat",
                        "ports": "$ports",
                        "name": "$name"
		}
EOF
	comma=","
	done <<< "$containers"

	cat >> sysinfo.json <<EOF
        ],
EOF
}
