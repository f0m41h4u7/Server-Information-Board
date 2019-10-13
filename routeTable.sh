#!/bin/bash
out_file_path=sysinfo.json 

echo `route -n > tmp.out`
echo -e "\t\"Route Table Info\": [" >> $out_file_path
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
