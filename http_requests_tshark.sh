#!/bin/bash
for i in $(tshark -nr /root/shared/http_utf8_directory_traversal_281014.pcap -Y http.request.uri -T fields -e tcp.stream);
do tshark -nr /root/shared/http_utf8_directory_traversal_281014.pcap -2 tcp.stream eq $i and frame contains "HTTP" -w http_utf8_directory_traversal_281014.urls;
done
