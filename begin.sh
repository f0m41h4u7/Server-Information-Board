#!/bin/bash

t=0 #time interval
addr="" #destination address

#help
usage="$(basename "$0") [-h] [-t <time, sec>] [-a <address>] 
where:
    -h  show this help text
    -t  set time interval
    -a  set destination address"

while getopts 'h:t:a:' option; do
  case "${option}" in
    h) echo "$usage"
       exit 1
       ;;
    t) t="${OPTARG}"
       ;;
    a) addr="${OPTARG}"
       ;;
    :) printf "missing argument for -%s\n" "$OPTARG" >&2
       echo "$usage" >&2
       exit 1
       ;;
   \?) printf "illegal option: -%s\n" "$OPTARG" >&2
       echo "$usage" >&2
       exit 1
       ;;
    *) help
       exit 1
       ;;
  esac
done
shift $((OPTIND - 1))

watch -n $t ./parse.sh $addr
