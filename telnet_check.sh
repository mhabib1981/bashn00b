#!/bin/bash
port=22

for ip in $(cat ip_list.txt);do echo "Hello" | telnet $ip $port 2>&1 | tee -a telnet_results.txt && sleep 5 && killall -9 telnet;done
