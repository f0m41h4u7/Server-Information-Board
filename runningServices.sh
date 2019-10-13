#!/bin/bash
out_file_path=sysinfo.json

echo -e "\t\"Running Services\": [" >> $out_file_path
echo `systemctl list-units | grep running|sort  > tmp.out`
n=0
n=$(wc -l tmp.out | awk -F" " '{print $1}')
for (( i=2; i <= n-2; i++ ))
do
        echo -e "\t\t{"  >> $out_file_path
        echo -e "\t\t\t\""`systemctl list-units | grep running|sort | awk -F" " 'NR=='$i'{print $1}'`"\": \""`systemctl list-units | grep running|sort | awk -F" " 'NR=='$i'{print $2}'`", "`systemctl list-units | grep running|sort | awk -F" " 'NR=='$i'{print $3}'`", "`systemctl list-units | grep running|sort | awk -F" " 'NR=='$i'{print $4}'`"\"" >> $out_file_path
        echo -e "\t\t},"  >> $out_file_path
done
echo -e "\t\t{"  >> $out_file_path
echo -e "\t\t\t\""`systemctl list-units | grep running|sort | awk -F" " 'NR=='$n'{print $1}'`"\": \""`systemctl list-units | grep running|sort | awk -F" " 'NR=='$n'{print $2}'`", "`systemctl list-units | grep running|sort | awk -F" " 'NR=='$n'{print $3}'`", "`systemctl list-units | grep running|sort | awk -F" " 'NR=='$n'{print $4}'`"\"" >> $out_file_path
echo -e "\t\t}"  >> $out_file_path
echo -e "\t],"  >> $out_file_path
sudo rm tmp.out
