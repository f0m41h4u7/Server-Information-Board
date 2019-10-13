#!/bin/bash

out_file_path=sysinfo.json
server_address=localhost:1337

echo -e "{" >> $out_file_path
echo -e "\t\"Hostname\": \""`hostname`"\"," >> $out_file_path

echo -e "\t\"CPU Usage,%\": "`./cpu.sh`"," >> $out_file_path
echo "Getting CPU info..."

echo "Getting memory info.."
./ram.sh

echo "Getting route info..."
./routeTable.sh

echo "Getting disk info..."
./diskInfo.sh

echo "Getting running services info..."
./runningServices.sh

#echo -e "\t\"Total Running service\": "`systemctl list-units | grep running|sort| wc -l`"," >> $out_file_path

echo "Getting docker containers info..."
./dockerContainers.sh 

echo "Getting docker images info..."
./dockerImages.sh

echo -e "Getting NGINX info..."
./nginxInfo.sh
         
echo "Done!"

echo -e "}"  >> $out_file_path

echo -e "Sending data to server..."
curl -X POST -d @'sysinfo.json' -H "Content-Type: application/json" $server_address -v
