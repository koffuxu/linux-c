#!/bin/bash
MEDIA_PATH=/home/amlogic/android/CTS/android-cts-media-1.1/

AUTHFILE="/home/amlogic/.MYUPLOAD"

FTP_REMOTE_DIR="/mbox/ref_testing_report/CTS_test/5.1_CTS/$1/$2/"

RESULT_DIR="/home/amlogic/android/CTS/android-cts-5.1_r2-linux_x86-arm/android-cts/repository/results"

int=1

result=null

MAXFAILEDNUM=20



UPLOAD_TO_FTP()

{

    if [ -f $AUTHFILE ]; then

        echo $result

        ncftpput -m -f $AUTHFILE $FTP_REMOTE_DIR/$DATE $RESULT_DIR/$result.zip

        if [ $? -ne 0 ]; then

            echo "ncftpput failed!!!! exit!"

            exit

        fi

    else

        echo "Sorry, I cannot find the auth file, Please check the file path $AUTHFILE"

    fi

}



while(( int<=$3))

do

    echo -e "\033[41;37m cts loop is $int \033[0m"

    cd $MEDIA_PATH

    ./copy_media.sh

    if [ $? -ne 0 ]; then

        echo "copy media to device failed!!!! exit!"

        exit

    fi

    cd -

    sleep 20

    ./cts-tradefed run cts --plan CTS|tee $1_log

    if [ $? -ne 0 ]; then

        echo "full cts failed!!!! exit!"

        exit

    fi



    result=`grep "Created result dir" ./$1_log | cut -d \  -f7`

    failed=`awk -F \" '/Summary failed/{print $2}' $RESULT_DIR/$result/testResult.xml`

    notExecuted=`awk -F \" '/Summary failed/{print $4}' $RESULT_DIR/$result/testResult.xml`

    if [ $failed -le $MAXFAILEDNUM ] && [ $notExecuted -eq 0 ];then

    info=`awk -F \" '/Summary failed/{printf("  failed:      %s\n   notExecuted: %s\n   timeout:     %s\n   pass:        %s\n",$2,$4,$6,$8)}' $RESULT_DIR/$result/testResult.xml`

    UPLOAD_TO_FTP && echo -e "Hi, all\n\n\nOne CTS result have been upload to:\n\

ftp:$FTP_REMOTE_DIR;\n\

Please download and verify it if you need!\n\n\n \

There is the summary of this CTS result:\n\n \

$info \

\n\n\nThis mail is from Linux CTS Test \

Terminal! \nif you dont want receive this mail, Please let me know! \

\n\nBest Regards!\nfan.fei" | mutt -s "($1)CTS Reference $result" zhiyong.shen@amlogic.com stark.li@amlogic.com shengyu.gu@amlogic.com lawrence.mok@amlogic.com sandy.luo@amlogic.com tim.yao@amlogic.com victor.wan@amlogic.com qing.luo@amlogic.com zhi.zhou@amlogic.com ping.xiong@amlogic.com kai.zhang@amlogic.com tao.dong@amlogic.com sukey.xiong@amlogic.com eric.zhong@amlogic.com jerry.cao@amlogic.com gordon.pan@amlogic.com spike.liao@amlogic.com fan.fei@amlogic.com qiang.gao@amlogic.com yingwei.long@amlogic.com brian.zhu@amlogic.com jiyu.yang@amlogic.com -a $RESULT_DIR/$result.zip

else

    info=`awk -F \" '/Summary failed/{printf("  failed:      %s\n   notExecuted: %s\n   timeout:     %s\n   pass:        %s\n",$2,$4,$6,$8)}' $RESULT_DIR/$result/testResult.xml`

    UPLOAD_TO_FTP && echo -e "Hi, all\n\n\nOne CTS result have been upload to:\n\

ftp:$FTP_REMOTE_DIR;\n\

Please download and verify it if you need!\n\n\n \

There is the summary of this CTS result:\n\n \

$info \

\n\n\nThis mail is from Linux CTS Test \

Terminal! \nif you dont want receive this mail, Please let me know! \

\n\nBest Regards!\nfan.fei" | mutt -s "($1)CTS Reference $result" stark.li@amlogic.com yingwei.long@amlogic.com frank.chen@amlogic.com fan.fei@amlogic.com -a $RESULT_DIR/$result.zip

fi

    let "int++"

done

#done;


