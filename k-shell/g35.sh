#! /bin/bash
export PATH=$PATH:/opt/CodeSourcery/Sourcery_G++_Lite/bin:/opt/CodeSourcery/Sourcery_G++_Lite/arm-none-eabi/bin:opt/CodeSourcery/Sourcery_G++_Lite/arm-none-linux-gnueabi/bin:/opt/gnutools/arc2.3-p0/elf32-4.2.1/bin:/opt/gnutools/arc2.3-p0/uclibc-4.2.1/bin:/opt/arc/MetaWare/arc/bin:/opt/qtcreator-1.2.0/bin:/home/eric.zhong/bin

SOURCE_CODE_DIR="/mnt/nfsroot/lei.qian/mbox_g18ref"
DATE=`date +%F`
ICS_LOGFILE="/mnt/nfsroot/lei.qian/$DATE.log"


#code
DEFAULT_BRANCH=jb-mr1-amlogic
DEVICE_BRANCH=jb-mr1-amlogic
KERNEL_BRANCH=amlogic-3.0
CUSTOMER_BRANCH=master
ROOTFS_DIR_NAME="jb-mr1-amlogic"


#rootfs 
LUNCH_NUM=g35-user
TASK_NUM=20 #VNC ALLOW ONE TASK ONLY
REPO_TASK_NUM=8 #VNC ALLOW ONE TASK ONLY

clear
 for i in $(seq 20)
 do
 echo
 done

echo "=============================script will run after 9 hours, don't close my PC!!!!================================"
sleep 11h

# ==========================================================update code  


# ==========================================================build android
echo "===============================================================ready to make system.img"	

	. build/envsetup.sh
	lunch $LUNCH_NUM 
	make  otapackage -j$TASK_NUM 
	if [ $? -ne 0 ];then
        echo "rootfs make failed,exit!"
        exit
	fi
	echo "make finished"

# ==========================================================upload
echo "===============================================================ready to upload to ftp"
   
    UPDATE_ZIP=`ls $SOURCE_CODE_DIR/out/target/product/g35/g35*.zip`
    DATE=`date +%Y%m%d`
    MANIFEST_FILE=jb-mr1-g18ref-$DATE.xml
    DATE=`date +%Y-%m%d-g35`
lftp -c "set ftp:list-options -a;
	open ftp://firmware.reference:Druf_T3t@ftp-china.amlogic.com/mbox/ref_fw_release/g35-MX-4.2-fireware/
	mkdir -p $DATE
	cd $DATE
	put $SOURCE_CODE_DIR/out/target/product/g35/u-boot.bin
	put $SOURCE_CODE_DIR/$MANIFEST_FILE
	put $SOURCE_CODE_DIR/out/target/product/g35/boot.img
	put $SOURCE_CODE_DIR/out/target/product/g35/recovery.img
	put $SOURCE_CODE_DIR/out/target/product/g35/obj/KERNEL_OBJ/vmlinux
	put $SOURCE_CODE_DIR/out/target/product/g35/obj/KERNEL_OBJ/System.map
	put $UPDATE_ZIP
bye"
    
    
  echo "======================uploading finished"
date "+%Y-%m-%d %H:%M:%S"
