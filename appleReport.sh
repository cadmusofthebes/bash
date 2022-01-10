#!/bin/bash

# Check for file and ask if missing
if [ -z $1 ]; then
    read -p "[!] File missing, please enter: " file
else
    file=$1
fi

# Filter out application access
echo ""
echo "========== App Access =========="
grep accessor $file | awk -F ":" '{print $3}' | awk -F "," '{print $1}' | sort -u | tr -d '"'
echo -e "\n\n"

# Filter out the domains and sort for unique values
echo "========== Domains =========="
grep domain $file | awk -F ":" '{print $2}' | awk -F "," '{print $1}' | sort -u | tr -d '"'
