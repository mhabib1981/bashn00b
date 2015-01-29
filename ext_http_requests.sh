#!/bin/bash
for i in $(tshark -r http_utf8_directory_traversal_281014.pcap -Y http.request.uri -T fields -e tcp.stream);
do tshark -r http_utf8_directory_traversal_281014.pcap -2 tcp.stream eq $i and frame contains "HTTP" >> $(pwd)/http_utf8_directory_traversal_281014.data;
done

cat http_utf8_directory_traversal_281014.data | awk -F" " '{print $5,$9}' | tr -d " " > http_utf8_directory_traversal_281014.urls
