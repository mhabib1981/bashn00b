##Created By Mohammed Habib
#!/bin/bash

#DEFINE PATHs
source_path=$(pwd)
target_path='/tmp/test' #define the target path
echo "SPLIT FILE Process started on $(date)"

#EXTRACT FILENAMEs
files=$(ls $source_path/*.txt | awk -F"/" '{print $NF}')

#SPLIT FILEs
for item in $files;do split $item --verbose -l $(($(cat $item | wc -l) /4)) -d $item".";done

#MOVE FILEs
s_files=$(ls *.0*)
for item in $s_files;do mv -v $source_path/$item $target_path/ && sleep 3s;done

#POST ACTION
for item in $files;do bzip2 -kv9 $item && rm -v -r $item;done
echo "SPLIT FILE Process completed on $(date)"


#Running the Script with STDOUT to CORN LOG
#./split_files_fin.sh 2>&1 | tee -a /var/log/cron
