#!/bin/bash
out_file_path=sysinfo.json

echo -e "\t\"NGINX Info\": {" >> $out_file_path
echo -e "\t\t\"Status\": \""`systemctl status nginx | awk -F" " 'NR==3{print}' | cut -b 12-`"\"," >> $out_file_path
echo -e "\t\t\"Process\": \""`systemctl status nginx | awk -F" " 'NR==5{print}' | cut -b 12-`"\"," >> $out_file_path
echo -e "\t\t\"Sites\": [" >> $out_file_path
n=0
echo `ls /etc/nginx/sites-available/*.conf > tmp.out`
n=$(wc -l tmp.out | awk -F" " '{print $1}')
for (( i=1; i <= n; i++ ))
do
        echo -e "\t\t\t{" >> $out_file_path
        tmp=$(ls /etc/nginx/sites-available/*.conf | awk -F" " 'NR=='$i'{print}')
        echo -e "\t\t\t\t\"Server Name\": \""`cat $tmp | egrep -o 'server_name .+' | awk -F" " '{print $2}'`"\"," >> $out_file_path
        echo -e "\t\t\t\t\"Port\": "`cat $tmp | egrep -o 'listen [0-9]+' | awk -F" " '{print $2}'` >> $out_file_path
        if (( i<n )); then
                echo -e "\t\t\t}," >> $out_file_path
        fi
done
echo -e "\t\t\t}" >> $out_file_path
echo -e "\t\t]" >> $out_file_path
echo -e "\t}" >> $out_file_path
sudo rm tmp.out
