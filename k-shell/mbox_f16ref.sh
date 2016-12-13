#! /bin/bash

SOURCE_CODE_DIR="/mnt/nfsroot/lei.qian/mbox_f16ref"
TASK_NUM=20



clear
 for i in $(seq 20)
 do
 echo
 done





# ==========================================================update code  
repo sync -j8
	if [ $? -ne 0 ];then
        echo "sync failed,exit!"
        exit
	fi
DATE=`date +%Y%m%d`
MANIFEST_FILE=ics-amlogic-mbox-$DATE.xml
repo manifest -r -o $MANIFEST_FILE


# ==========================================================build android
echo "===============================================================ready to make system.img"
. build/envsetup.sh 
lunch 19
make clean
make -j$TASK_NUM
	if [ $? -ne 0 ];then
        echo "make system.img failed,exit!"
        exit
	fi

# ==========================================================build recovery
echo "===============================================================ready to make the recovery"
cd kernel
make distclean
make meson_reff16_recovery_defconfig
make uImage -j$TASK_NUM
	if [ $? -ne 0 ];then
        echo "make recovery failed,exit!"
        exit
	fi
cp arch/arm/boot/uImage ../out/target/product/f16ref/uImage_recovery

# ==========================================================build kernel
echo "===============================================================ready to make the kernel"
make distclean
make meson_reff16_defconfig
make uImage -j$TASK_NUM
	if [ $? -ne 0 ];then
        echo "make kernel failed,exit!"
        exit
	fi
	
cp arch/arm/boot/uImage ../out/target/product/f16ref/

# ==========================================================make package  
echo "===============================================================ready to make the packge "
cd ..
make otapackage -j$TASK_NUM
	if [ $? -ne 0 ];then
        echo "make packagefailed,exit!"
        exit
	fi


DATE=`date +%Y%m%d-f16-Code`
UPDATE_ZIP=`ls $SOURCE_CODE_DIR/out/target/product/f16ref/f16ref*.zip`

lftp -c "set ftp:list-options -a;   
open ftp://firmware.reference:Druf_T3t@ftp-china.amlogic.com/mbox/ref_fw_release/MBX-f16-code/  
mkdir -p $DATE
cd $DATE        
put $SOURCE_CODE_DIR/out/target/product/f16ref/u-boot-aml-ucl.bin
put $SOURCE_CODE_DIR/$MANIFEST_FILE
put $SOURCE_CODE_DIR/out/target/product/f16ref/uImage   
put $SOURCE_CODE_DIR/out/target/product/f16ref/uImage_recovery  
put $UPDATE_ZIP

bye"

date "+%Y-%m-%d %H:%M:%S"




# ==========================================================build 老板子 kernel
echo "===============================================================ready to make the 老板子 kernel"
cd kernel
make distclean
make meson_reff16_v1029_defconfig
make uImage -j$TASK_NUM
	if [ $? -ne 0 ];then
        echo "make kernel failed,exit!"
        exit
	fi
cp arch/arm/boot/uImage ../out/target/product/f16ref/

# ==========================================================make package  
echo "===============================================================ready to make the packge "
cd ..
make otapackage -j$TASK_NUM
	if [ $? -ne 0 ];then
        echo "make packagefailed,exit!"
        exit
	fi


DATE=`date +%Y%m%d-f16-v1029-Code`
UPDATE_ZIP=`ls $SOURCE_CODE_DIR/out/target/product/f16ref/f16ref*.zip`

lftp -c "set ftp:list-options -a;   
open ftp://firmware.reference:Druf_T3t@ftp-china.amlogic.com/mbox/ref_fw_release/MBX-f16-code/  
mkdir -p $DATE
cd $DATE        
put $SOURCE_CODE_DIR/out/target/product/f16ref/u-boot-aml-ucl.bin
put $SOURCE_CODE_DIR/$MANIFEST_FILE
put $SOURCE_CODE_DIR/out/target/product/f16ref/uImage   
put $SOURCE_CODE_DIR/out/target/product/f16ref/uImage_recovery  
put $UPDATE_ZIP

bye"

date "+%Y-%m-%d %H:%M:%S"
