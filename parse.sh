#!/bin/bash

server_address=$1

source ram.sh
source diskInfo.sh
source routeTable.sh
source servicesInfo.sh
source containers.sh
source images.sh
source nginxInfo.sh

cat > sysinfo.json <<EOF
{
        "Hostname": "$(hostname)",
	"CPU Usage": $(./cpu.sh),
EOF

getRAM
getDiskInfo
getRoute
getServices
getContainers
getImages
getNGINX

cat >> sysinfo.json <<EOF
}
EOF

curl -X POST -d @'sysinfo.json' -H "Content-Type: application/json" $server_address -v
