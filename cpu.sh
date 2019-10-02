#!/bin/bash

cgroup=$(awk -F: '$2 == "cpu,cpuacct" { print $3 }' /proc/self/cgroup)

tstart=$(date +%s%N)
cstart=$(cat /sys/fs/cgroup/cpu/$cgroup/cpuacct.usage)

sleep 5

tstop=$(date +%s%N)
cstop=$(cat /sys/fs/cgroup/cpu/$cgroup/cpuacct.usage)

bc -l <<EOF
($cstop - $cstart) / ($tstop - $tstart) * 100
EOF
