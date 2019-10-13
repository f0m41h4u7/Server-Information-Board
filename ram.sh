#!/bin/bash
out_file_path=sysinfo.json

echo -e "\t\"Memory(RAM) Info\": {" >> $out_file_path
echo -e "\t\t"`free -mht| awk '/Mem/{print " \"Total\": \"" $2 }'`"\"," >> $out_file_path
echo -e "\t\t"`free -mht| awk '/Mem/{print " \"Used\": \"" $3 }'`"\"," >> $out_file_path
echo -e "\t\t"`free -mht| awk '/Mem/{print " \"Free\": \"" $4 }'`"\"" >> $out_file_path
echo -e "\t},"  >> $out_file_path
