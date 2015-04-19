#!/bin/sh

path=$(pwd)
ts=$(date +"%d%m%y")

#Zeus
wget -q -O - https://zeustracker.abuse.ch/blocklist.php?download=ipblocklist --no-check-certificate | egrep -v '(^[[:space:]]*/|^[[:space:]]*#|^[[:space:]]*$)|/[0-9]|\:|/g' | awk -F" " '{print $1}' | sort -u >> $path/$ts'_$ts'_ip_blacklist.txt''

#Spyeye
wget -q -O - https://spyeyetracker.abuse.ch/blocklist.php?download=ipblocklist --no-check-certificate | egrep -v '(^[[:space:]]*/|^[[:space:]]*#|^[[:space:]]*$)|/[0-9]|\:|/g' | awk -F" " '{print $1}' | sort -u >> $path/$ts'_$ts'_ip_blacklist.txt''

#OpenBl
wget -q -O - http://www.openbl.org/lists/base.txt | egrep -v '(^[[:space:]]*/|^[[:space:]]*#|^[[:space:]]*$)|/[0-9]|\:|/g' | awk -F" " '{print $1}' | sort -u >> $path/$ts'_$ts'_ip_blacklist.txt''

#Palevo
wget -q -O - https://palevotracker.abuse.ch/blocklists.php?download=ipblocklist --no-check-certificate | egrep -v '(^[[:space:]]*/|^[[:space:]]*#|^[[:space:]]*$)|/[0-9]|\:|/g' | awk -F" " '{print $1}' | sort -u >> $path/$ts'_ip_blacklist.txt'

#Malc0de
wget -q -O - http://malc0de.com/bl/$ts'_ip_blacklist.txt' | egrep -v '(^[[:space:]]*/|^[[:space:]]*#|^[[:space:]]*$)|/[0-9]|\:|/g' | awk -F" " '{print $1}' | sort -u >> $path/$ts'_ip_blacklist.txt'

#EmerginThreats
wget -q -O - http://rules.emergingthreats.net/blockrules/compromised-ips.txt | egrep -v '(^[[:space:]]*/|^[[:space:]]*#|^[[:space:]]*$)|/[0-9]|\:|/g' | awk -F" " '{print $1}' >> $path/$ts'_ip_blacklist.txt'

#Malware Domainlist
wget -q -O - http://www.malwaredomainlist.com/hostslist/ip.txt | egrep -v '(^[[:space:]]*/|^[[:space:]]*#|^[[:space:]]*$)|/[0-9]|\:|/g' | awk -F" " '{print $1}' | sort -u >> $path/$ts'_ip_blacklist.txt'

#CIARMY
wget -q -O - http://www.ciarmy.com/list/ci-badguys.txt | egrep -v '(^[[:space:]]*/|^[[:space:]]*#|^[[:space:]]*$)|/[0-9]|\:|/g' | awk -F" " '{print $1}' | sort -u >> $path/$ts'_ip_blacklist.txt'

#SSLBL
wget -q -O - https://sslbl.abuse.ch/blacklist/sslipblacklist_aggressive.csv --no-check-certificate | egrep -v '(^[[:space:]]*/|^[[:space:]]*#|^[[:space:]]*$)|/[0-9]|\:|/g' | awk -F"," '{print $1}' | sort -u >> $path/$ts'_ip_blacklist.txt'

#CleanMX
wget -q http://support.clean-mx.de/clean-mx/xmlviruses.php -O $path/cleanmx_blacklist.xml
echo "cat //output/entries/entry/ip/text()" | xmllint --shell cleanmx_blacklist.xml | sort -u | egrep -v '(^[[:space:]]*/|^[[:space:]]*#|^[[:space:]]*$)|/[0-9]|\:|/g' | sort -u  >> $path/$ts'_ip_blacklist.txt'

#Project Honeypot
wget -q http://www.projecthoneypot.org/list_of_ips.php?rss=1&rf=40809
echo "cat //channel/item/title/text()" | xmllint --shell $path/list_of_ips.php\?rss\=* | sort -u | cut -d"|" -f 1 | egrep -v '(^[[:space:]]*/|^[[:space:]]*#|^[[:space:]]*$)|/[0-9]|\:|/g' | sort -u >> $path/$ts'_ip_blacklist.txt'

#Clean
rm -r $path/*_blacklist.xml
rm -r $path/list_of_ips.php\?rss\=*
