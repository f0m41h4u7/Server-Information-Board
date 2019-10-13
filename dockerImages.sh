#!/bin/bash
out_file_path=sysinfo.json

echo -e "\t\"Docker Images\": [" >> $out_file_path
echo `docker image ls > tmp.out`
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
echo -e "\t\t}" >> $out_file_path
echo -e "\t],"  >> $out_file_path
sudo rm tmp.out
