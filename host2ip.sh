#!/bin/bash

# Take an input list of hostnames (one per line) and convert
# them to IP addresses

inputFilename=$1
outputFilename="ips.txt"

if [ $# -eq 0 ]; then
    echo "[!] No filename provided"
    echo "[*] Usage: $0 <filename>"
    exit 1
else
    echo "[*] Processing $inputFilename"
    echo "[*] Outputting results to $outputFilename"
    for host in $(cat $inputFilename); do
        nslookup $host | grep Address | grep -v "#" | awk -F ":" '{gsub(/ /,""); print $2}' | xargs >> $outputFilename
    done
fi
