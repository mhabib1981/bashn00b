#!/bin/bash
file='SQLmap_full_1m_020415.pcap'
for i in $(tshark -r $file -Y http.request.uri -T fields -e tcp.stream);
do tshark -r $file -2 tcp.stream eq $i and frame contains "HTTP" >> $(pwd)/$file.data;
done

cat $file.data | awk -F" " '{print $5,$9}' | tr -d " " > $file.urls
