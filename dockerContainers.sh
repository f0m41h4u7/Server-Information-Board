#!/bin/bash
out_file_path=sysinfo.json

echo -e "\t\"Docker Containers\": [ " >> $out_file_path
echo `docker ps -a > tmp.out`
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
