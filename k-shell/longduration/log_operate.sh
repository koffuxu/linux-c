#########################################################################
# File Name: compress.sh
# Author: koffuxu
# mail: koffuxu@gmail.com 
# Created Time: Tue 18 Aug 2015 02:24:18 PM CST
#########################################################################
#!/bin/bash


##ftp info
FTPHOST="ftp-china.amlogic.com"
USERPW="user firmware.reference Druf_T3t"


flist=`ls ./`
#echo -e "$flist\nThis files will be compress and upload!"
function usage(){
    echo "need 2 parameter"
    echo "Usage: ./log_operate.sh date 'file'"
}
if [ $# -ne 2 ]; then
    usage
    exit
else
    device_array=($2)
    device_count=${#device_array[*]}
    echo "all device is ${device_array[*]}, count is $device_count"
if [ -z $1 ]; then
    echo "please assgin date"
    exit
else
    DATE=$1
fi
if [ $device_count -eq 0 ]; then
    echo "pleast assgin file to operate"
    exit
else
    deviceno=$2
    echo "$deviceno this file need to operate "

fi
fi

##comress assign file
function log_filter(){
#echo $deviceno
for lognum in $deviceno
do
    logname=`find -iname "*$lognum*"`
    if [ -z $logname ]; then
        echo "$lognum# device not found!"
    else
        echo "$logname found"
        zipname=`ls $logname|awk -F / '{print $2}'`
        zipname=`ls $zipname|awk -F . '{print $1}'`
        zip ${zipname}.zip $logname
    fi
done

}


##compress all
function f_compress(){
echo "start compress files......"
for f in $flist
do
    echo "start compress file $f"
    zipname=`ls $f|awk -F . '{print $1}'`
    zip ${zipname}.zip $f
done
echo "compress done......"

}

function creat_ftp_dir(){
lftp $FTPHOST <<EOF
$USERPW
mkdir -p /mbox/ref_testing_report/long_duration_test/$DATE
EOF
}

function f_upload(){
echo "start upload files to $DATE......"
lftp $FTPHOST <<EOF
$USERPW
cd /mbox/ref_testing_report/long_duration_test/$DATE
mput *.zip 
exit
EOF
echo "upload done......"
}

########################### main function ###########################
function main(){
#echo "@@@@@@@@@@@ machine run times calclate done @@@@@@@@@"
#f_compress
log_filter 
if [ $? -ne 0 ]; then
    echo "file compress error"
    exit
else
    creat_ftp_dir
    f_upload
    if [ $? -ne 0 ]; then
        echo "file upload error"
        exit
    else
        echo "upload succussful!"
        rm *.zip
    fi
fi
}
main
