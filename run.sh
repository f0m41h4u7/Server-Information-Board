#!/bin/bash

out_file_path=sysinfo.json

echo -e "{" >> $out_file_path
echo -e "\t\"Hostname\": \""`hostname`"\"," >> $out_file_path

echo -e "\t\"CPU Usage,%\": "`./cpu.sh`"," >> $out_file_path
echo "Getting CPU info..."

echo -e "\t\"RAM Info\": {" >> $out_file_path
echo "Getting memory info.."
echo -e "\t\t\"Memory(RAM) Info\": {" >> $out_file_path
echo -e "\t\t\t"`free -mht| awk '/Mem/{print " \"Total\": \"" $2 }'`"\"," >> $out_file_path
echo -e "\t\t\t"`free -mht| awk '/Mem/{print " \"Used\": \"" $3 }'`"\"," >> $out_file_path
echo -e "\t\t\t"`free -mht| awk '/Mem/{print " \"Free\": \"" $4 }'`"\"" >> $out_file_path
echo -e "\t\t},"  >> $out_file_path

echo -e "\t\t\"Swap Memory Info\": {" >> $out_file_path
echo -e "\t\t\t"`free -mht| awk '/Swap/{print " \"Total\": \"" $2 }'`"\"," >> $out_file_path
echo -e "\t\t\t"`free -mht| awk '/Swap/{print " \"Used\": \"" $3 }'`"\"," >> $out_file_path
echo -e "\t\t\t"`free -mht| awk '/Swap/{print " \"Free\": \"" $4 }'`"\"" >> $out_file_path
echo -e "\t\t}"  >> $out_file_path
echo -e "\t},"  >> $out_file_path

echo -e "\t\"Route Table Info\": [" >> $out_file_path
echo `route -n > tmp.out`
echo "Getting route info..."
n=0
n=$(wc -l tmp.out | awk -F" " '{print $1}')
for (( i=3; i <= n; i++ ))
do
        echo -e "\t\t{" >> $out_file_path
        echo -e "\t\t\t\"Destination\": \""`route -n | awk -F" " 'NR=='$i'{print $1}'`"\"," >> $out_file_path
        echo -e "\t\t\t\"Gateway\": \""`route -n | awk -F" " 'NR=='$i'{print $2}'`"\"," >> $out_file_path
        echo -e "\t\t\t\"Genmask\": \""`route -n | awk -F" " 'NR=='$i'{print $3}'`"\"," >> $out_file_path
        echo -e "\t\t\t\"Flags\": \""`route -n | awk -F" " 'NR=='$i'{print $4}'`"\"," >> $out_file_path
        echo -e "\t\t\t\"Metric\": \""`route -n | awk -F" " 'NR=='$i'{print $5}'`"\"," >> $out_file_path
        echo -e "\t\t\t\"Ref\": \""`route -n | awk -F" " 'NR=='$i'{print $6}'`"\"," >> $out_file_path
        echo -e "\t\t\t\"Use\": \""`route -n | awk -F" " 'NR=='$i'{print $7}'`"\"," >> $out_file_path
        echo -e "\t\t\t\"Iface\": \""`route -n | awk -F" " 'NR=='$i'{print $8}'`"\"" >> $out_file_path
	if (( i<n  )); then
		echo -e "\t\t}," >> $out_file_path
	fi
done
echo -e "\t\t}" >> $out_file_path
echo -e "\t],"  >> $out_file_path
sudo rm tmp.out

echo -e "\t\"Disk Info\": [" >> $out_file_path
echo `df -h > tmp.out`
echo "Getting disk info..."
n=0
n=$(wc -l tmp.out | awk -F" " '{print $1}')
for (( i=2; i <= n-1; i++ ))
do
        echo -e "\t\t{" >> $out_file_path
        echo -e "\t\t\t\"Filesystem\": \""`df -h | awk -F" " 'NR=='$i'{print $1}'`"\"," >> $out_file_path
        echo -e "\t\t\t\"Size\": \""`df -h | awk -F" " 'NR=='$i'{print $2}'`"\"," >> $out_file_path
        echo -e "\t\t\t\"Used\": \""`df -h | awk -F" " 'NR=='$i'{print $3}'`"\"," >> $out_file_path
        echo -e "\t\t\t\"Available\": \""`df -h | awk -F" " 'NR=='$i'{print $4}'`"\"," >> $out_file_path
        echo -e "\t\t\t\"Use%\": \""`df -h | awk -F" " 'NR=='$i'{print $5}'`"\"," >> $out_file_path
        echo -e "\t\t\t\"Mounted on\": \""`df -h | awk -F" " 'NR=='$i'{print $6}'`"\"" >> $out_file_path
	if (( i<n-1 )); then
                echo -e "\t\t}," >> $out_file_path
        fi
done
echo -e "\t\t}" >> $out_file_path 
echo -e "\t],"  >> $out_file_path 
sudo rm tmp.out

echo -e "\t\"Running Services\": {" >> $out_file_path
echo `systemctl list-units | grep running|sort  > tmp.out`
echo "Getting running services info..."
n=0
n=$(wc -l tmp.out | awk -F" " '{print $1}')
for (( i=2; i <= n-1; i++ ))
do
        echo -e "\t\t\t\""`systemctl list-units | grep running|sort | awk -F" " 'NR=='$i'{print $1}'`"\": [ \""`systemctl list-units | grep running|sort | awk -F" " 'NR=='$i'{print $2}'`"\", \""`systemctl list-units | grep running|sort | awk -F" " 'NR=='$i'{print $3}'`"\", \""`systemctl list-units | grep running|sort | awk -F" " 'NR=='$i'{print $4}'`"\", \""`systemctl list-units | grep running|sort | awk 'NR=='$i'{print $5}'`"\" ]," >> $out_file_path
done
echo -e "\t\t\t\""`systemctl list-units | grep running|sort | awk -F" " 'NR=='$n'{print $1}'`"\": [ \""`systemctl list-units | grep running|sort | awk -F" " 'NR=='$n'{print $2}'`"\", \""`systemctl list-units | grep running|sort | awk -F" " 'NR=='$n'{print $3}'`"\", \""`systemctl list-units | grep running|sort | awk -F" " 'NR=='$n'{print $4}'`"\", \""`systemctl list-units | grep running|sort | awk 'NR=='$n'{print $5}'`"\" ]" >> $out_file_path
echo -e "\t},"  >> $out_file_path 
sudo rm tmp.out

echo -e "\t\"Total Running service\": "`systemctl list-units | grep running|sort| wc -l`"," >> $out_file_path

echo -e "\t\"Docker Containers\": [ " >> $out_file_path
echo `docker ps -a > tmp.out`
echo "Getting docker containers info..."
n=0
n=$(wc -l tmp.out | awk -F" " '{print $1}')

for (( i=2; i <= n; i++ ))
do
        echo -e "\t\t{" >> $out_file_path
        echo -e "\t\t\t\"Container ID\": \""`docker ps -a | awk -F" " 'NR=='$i'{print $1}'`"\"," >> $out_file_path
        echo -e "\t\t\t\"Image\": \""`docker ps -a | awk -F" " 'NR=='$i'{print $2}'`"\"," >> $out_file_path
        echo -e "\t\t\t\"Command\": "`sed -n ''$i'p' tmp.out | egrep -o '[/"][a-zA-Z0-9 /./,]+[/"]'`"," >> $out_file_path
        echo -e "\t\t\t\"Created\": \""`sed -n ''$i'p' tmp.out | egrep -o '[0-9]+[ ][a-z]+[ ][a-z]+'`"\"," >> $out_file_path
        echo -e "\t\t\t\"Status\": \""`sed -n ''$i'p' tmp.out | egrep -o '[A-Z][a-z /(/)0-9]+[ ]{1,5}'`"\"," >> $out_file_path
        echo -e "\t\t\t\"Ports\": \""`sed -n ''$i'p' tmp.out | egrep -o '(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5][/:][0-9]+)'`"\"," >> $out_file_path
        echo -e "\t\t\t\"Name\": \""`docker ps -a | awk 'NR=='$i'{print $NF}'`"\"" >> $out_file_path
        if (( i<n-1 )); then
                echo -e "\t\t}," >> $out_file_path
        fi
done
echo -e "\t\t}" >> $out_file_path 
echo -e "\t],"  >> $out_file_path
             
sudo rm tmp.out

echo -e "\t\"Docker Images\": [" >> $out_file_path
echo `docker image ls > tmp.out`
echo "Getting docker images info..."
n=0
n=$(wc -l tmp.out | awk -F" " '{print $1}')

for (( i=2; i <= n; i++ ))
do
        echo -e "\t\t{" >> $out_file_path
        echo -e "\t\t\t\"Repository\": \""`docker image ls | awk -F" " 'NR=='$i'{print $1}'`"\"," >> $out_file_path
        echo -e "\t\t\t\"Tag\": \""`docker image ls | awk -F" " 'NR=='$i'{print $2}'`"\"," >> $out_file_path
        echo -e "\t\t\t\"Image ID\": \""`docker image ls | awk -F" " 'NR=='$i'{print $3}'`"\"," >> $out_file_path
        echo -e "\t\t\t\"Created\": \""`sed -n ''$i'p' tmp.out | egrep -o '[0-9]+[ ][a-z]+[ ][a-z]+'`"\"," >> $out_file_path
        echo -e "\t\t\t\"Size\": \""`sed -n ''$i'p' tmp.out | egrep -o '[0-9]+[A-Z]+'`"\"" >> $out_file_path
        if (( i<n )); then
                echo -e "\t\t}," >> $out_file_path
        fi
done      
         
sudo rm tmp.out
echo "Done!"
echo -e "\t\t}" >> $out_file_path
echo -e "\t]"  >> $out_file_path

echo -e "}"  >> $out_file_path
