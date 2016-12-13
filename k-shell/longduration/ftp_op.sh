#########################################################################
# File Name: calc_cout.sh
# Author: koffuxu
# mail: koffuxu@163.com
# Created Time: Mon 17 Aug 2015 02:27:07 PM CST
#########################################################################
#!/bin/bash

FLAG_DL=1
FLAG_DC=1

if [ -z $1 ]; then
    DATE=`date +"%Y%m%d"`
else
    DATE=$1
fi

##1. start download
if [ $FLAG_DL -ne 0 ]; then
echo "start downlad $DATE files......"
lftp ftp-china.amlogic.com <<EOF
user firmware.reference Druf_T3t
mirror -c --parallel=1 /mbox/ref_testing_report/long_duration_test/$DATE $DATE 
exit
EOF
#echo "Download Result is:$?"
sleep 1
if [ $? -ne 0 ]; then
    echo "ftp download failed! errorno=$? exit!"
    exit
else
    echo "ftp download successful!"
fi
fi

##2. start decompress zip file
if [ $FLAG_DC -ne 0 ]; then
if [ -e $DATE ]; then
cd ./$DATE
else
    echo "log file not found! exit"
    exit
fi
find -name "*.zip" |xargs -n1 unzip
rm *.zip
sleep 1
echo "Decompress successful!"
fi

