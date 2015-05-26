#!/bin/bash
file='/root/shared/suspecious_JS_method_call_230415.pcap'
for i in $(tshark -nr $file -Y http.request.uri -T fields -e tcp.stream);
do tshark -nr $file -2 tcp.stream eq $i and frame contains "HTTP" -w $file.urls;
done
