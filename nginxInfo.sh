#!/bin/bash

###############################################################################
#getting nginx information
###############################################################################

function getNGINX
{
	local nginxinf=$(systemctl status nginx)
	local comma=""
	local stat=$(echo $nginxinf | awk 'NR==3{print}' | cut -b 12-) #getting status of nginx server
	local proc=$(echo $nginxinf | awk 'NR==5{print}' | cut -b 12-) #getting name of running process

cat >> sysinfo.json <<EOF
        "NGINX Info:"
	{
		"Status": "$stat",
		"Process": "$proc",
		"Sites":
		[
EOF

	#getting information about nginx sites on this server
	local sitesinf=$(ls /etc/nginx/sites-available/*.conf)

	while read -r line; do
		local name=$(echo $sitesinf  | egrep -o 'server_name .+' | awk '{print $2}')
		local port=$(echo $sitesinf | egrep -o 'listen [0-9]+' | awk '{print $2}')
        	cat >> sysinfo.json <<EOF
			$comma
                	{       
                        	"Server Name": "$name",
                        	"Port": "$port"
                	} 
EOF
		comma=","
	done <<< "$sitesinf"

cat >> sysinfo.json <<EOF
		]
	}
EOF
}
