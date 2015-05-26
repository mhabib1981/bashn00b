#!/bin/bash

file="/root/shared/syslog.properties"
log_file="/root/shared/syslog.properties.notify"
#init_date=$(date +%d%m%y)
#modi_date=$(date +%d%m%y -r $file)

function list_entries (){
	curr_count=$(cat $file | grep -o "," | wc -l)
	if [ "$init_count" -lt "$curr_count" ]; then
		echo "GOT NEW ITEMS"
		for entry in $(seq $init_count $(($curr_count+1)))
		do
   			line=$(cat $file | cut -d "," -f $entry)
			echo -e $line >> $log_file
		done
		init_count=$curr_count

	 elif [ "$init_count" -eq "$curr_count" ]; then
                echo "NO NEW ITEMS"

	fi
}

function start(){
	init_count=$(cat $file | grep -o "," | wc -l)
	while [ true ]
	do
		list_entries
		sleep 10
	done
}

start
