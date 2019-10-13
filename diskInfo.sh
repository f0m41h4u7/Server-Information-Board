#!/bin/bash
out_file_path=sysinfo.json

echo -e "\t\"Disk Info\": [" >> $out_file_path
echo `df -h > tmp.out`
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
