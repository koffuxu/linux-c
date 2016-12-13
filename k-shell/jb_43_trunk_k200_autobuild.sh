#! /bin/bash
sleep 10h
SOURCE_DIR="/mnt/nfsroot/lei.qian/save_auto_build_code/android4.3_jb-mr2-amlogic/k200"
SOURCE_DIR_SKT="/mnt/nfsroot/lei.qian/save_auto_build_code/android4.3_jb-mr2-amlogic/m8_skt"
SOURCE_DIR_B="/mnt/nfsroot/lei.qian/save_auto_build_code/android4.3_jb-mr2-amlogic/k200-B"
DATE=`date +%Y%m%d%H%M%S`
SOURCE_CODE_DIR="/mnt/nfsroot/lei.qian/jb-mr2-amlogic"
DATE=`date +%F`
ICS_LOGFILE="/mnt/nfsroot/lei.qian/save_auto_build_code/android4.3_jb-mr2-amlogic/jb_43_trunk_k200_qianlei_$DATE.log"
ICS_LOGFILE_SKT="/mnt/nfsroot/lei.qian/save_auto_build_code/android4.3_jb-mr2-amlogic/jb_43_trunk_skt_qianlei_$DATE.log"
# 0. some variables
#step
STEP1_GET_CODE=0
STEP2_CHECKOUT_BRANCH=1
STEP3_ROOTFS_MAKE_K200=1
STEP4_ROOTFS_MAKE_M8SKT=0
STEP3_ROOTFS_MAKE_K200_B=1
#code
DEFAULT_BRANCH=jb-mr2-amlogic
DEVICE_BRANCH=jb-mr2-amlogic
KERNEL_BRANCH=amlogic-3.10-bringup
CUSTOMER_BRANCH=master
ROOTFS_DIR_NAME="jb-mr2-amlogic"
#code
#rootfs 
LUNCH_NUM=k200-user
LUNCH_NUM_SKT=m8skt-user
TASK_NUM=32 #VNC ALLOW ONE TASK ONLY
REPO_TASK_NUM=8 #VNC ALLOW ONE TASK ONLY
#kernel
time=0
AML_BOARD=k200
DEFAULT_CONFIG=meson8_defconfig 
DEFAULT_RECOVERY_CONFIG=meson8_defconfig
DATE=`date +%Y%m%d%H%M%S`
# 1.get code 


# 2.check out right branches
if [ $STEP2_CHECKOUT_BRANCH -ne 0 ];then
    cd device/amlogic
    git checkout -t remotes/amlogic/$DEVICE_BRANCH
    if [ $? -ne 0 ];then
        echo "git checkout device/amlogic branch failed!"
    fi
    cd ../..

    cd common
    git checkout -t remotes/amlogic/$KERNEL_BRANCH
    git pull
    cd customer
    git checkout -t remotes/amlogic/$CUSTOMER_BRANCH
    git pull
    if [ $? -ne 0 ];then
        echo "git checkout kernel branch failed!"
    fi
    cd ../../
fi


# 3. rootfs_k200 make complie
if [ $STEP3_ROOTFS_MAKE_K200 -ne 0 ];then
	repo forall -c 'git checkout .;git clean -df'
	#DATE=`date +%Y-%m-%d-%H-%M-%S`
	#repo manifest -r -o jb-43-ori-$DATE.xml
	repo sync -j$REPO_TASK_NUM
	DATE=`date +%Y-%m-%d-%H-%M-%S`
	MANIFEST_FILE=jb-43-new-$DATE.xml
	repo manifest -r -o $MANIFEST_FILE
	echo "start to make k200 rootfs"
	. build/envsetup.sh
	lunch $LUNCH_NUM 2>> $ICS_LOGFILE
	make clean
	make  otapackage -j$TASK_NUM 2>> $ICS_LOGFILE
	if [ $? -ne 0 ];then
        echo "rootfs make rootfs_k200 failed,exit!"
        exit
	fi
	echo "make k200 finished"
	DATE=`date +%Y-%m-%d`
	mkdir -p $SOURCE_DIR/$DATE
	DEST_DIR="$SOURCE_DIR/$DATE"
	#ICS_LOGFILE="$DEST_DIR/autobuild_jb_$DATE.log"
	if [ -d $DEST_DIR ]; then
	cp -f $SOURCE_CODE_DIR/out/target/product/k200/k200*.zip  $DEST_DIR/k200-A-$DATE.zip		2>> $ICS_LOGFILE
	cp -f $SOURCE_CODE_DIR/out/target/product/k200/boot.img $DEST_DIR				2>> $ICS_LOGFILE
	cp -f $SOURCE_CODE_DIR/out/target/product/k200/recovery.img $DEST_DIR				2>> $ICS_LOGFILE
	cp -f $SOURCE_CODE_DIR/out/target/product/k200/u-boot.bin  $DEST_DIR				2>> $ICS_LOGFILE
	cp -f $SOURCE_CODE_DIR/device/amlogic/k200/u-boot-orig.bin  $DEST_DIR				2>> $ICS_LOGFILE
	cp -f $SOURCE_CODE_DIR/device/amlogic/k200/usb_spl.bin  $DEST_DIR				2>> $ICS_LOGFILE
	cp -f $SOURCE_CODE_DIR/$MANIFEST_FILE  $DEST_DIR				2>> $ICS_LOGFILE
	cp -f $SOURCE_CODE_DIR/out/target/product/k200/obj/KERNEL_OBJ/System.map $DEST_DIR							2>> $ICS_LOGFILE
	cp -f $SOURCE_CODE_DIR/out/target/product/k200/obj/KERNEL_OBJ/vmlinux $DEST_DIR							2>> $ICS_LOGFILE
	rm -fr  $SOURCE_CODE_DIR/out/target/product/k200/obj/KERNEL_OBJ 2>> $ICS_LOGFILE
	mkdir $SOURCE_CODE_DIR/out/target/product/k200/obj/KERNEL_OBJ 2>> $ICS_LOGFILE
	#device/amlogic/k200/quick_build_kernel.sh recoveryimage meson6_k200_usb_burning_defconfig 2>> $ICS_LOGFILE
	#cp -f $SOURCE_CODE_DIR/out/target/product/k200/recovery.img $SOURCE_CODE_DIR/out/target/product/k200/usb_burn_recovery.img 2>> $ICS_LOGFILE
    DATE=`date +%Y-%m-%d`
    UPDATE_ZIP=`ls $SOURCE_CODE_DIR/out/target/product/k200/k200*.zip`
    lftp -c "set ftp:list-options -a;
	open ftp://firmware.reference:Druf_T3t@ftp-china.amlogic.com/mbox/ref_fw_release/k200-M8-4.3-firmware
	mkdir -p $DATE
	cd $DATE
	put $DEST_DIR/boot.img
	put $DEST_DIR/recovery.img
#	put $DEST_DIR/usb_burn_recovery.img
	put $DEST_DIR/u-boot.bin
	put $DEST_DIR/$MANIFEST_FILE
	put $DEST_DIR/System.map
	put $DEST_DIR/vmlinux
	put $DEST_DIR/k200-A-$DATE.zip
	put $DEST_DIR/u-boot-orig.bin
	put $DEST_DIR/usb_spl.bin
	put $SOURCE_CODE_DIR/out/target/product/k200/aml_upgrade_package.img
	put $SOURCE_CODE_DIR/out/target/product/k200/aml_sdc_burn.ini
    bye"

	else
		echo "Sorry, no folder found, will exit...."							2>> $ICS_LOGFILE
	fi
	date "+%Y-%m-%d %H:%M:%S"
fi

# 4. rootfs_SKT make complie
if [ $STEP4_ROOTFS_MAKE_M8SKT -ne 0 ];then
	DATE=`date +%Y-%m-%d-%H-%M-%S`
	echo "start to make skt rootfs_SKT"
	. build/envsetup.sh
	lunch $LUNCH_NUM_SKT 2>> $ICS_LOGFILE_SKT
	make clean
	make  otapackage -j$TASK_NUM 2>> $ICS_LOGFILE_SKT
	if [ $? -ne 0 ];then
        echo "rootfs make rootfs_SKT  failed,exit!"
        exit
	fi
	echo "make skt finished"
	DATE=`date +%Y-%m-%d`
	mkdir -p $SOURCE_DIR_SKT/$DATE
	DEST_DIR_SKT="$SOURCE_DIR_SKT/$DATE"
	#ICS_LOGFILE_SKT="$DEST_DIR_SKT/autobuild_jb_$DATE.log"
	if [ -d $DEST_DIR_SKT ]; then
	cp -f $SOURCE_CODE_DIR/out/target/product/m8skt/m8skt*.zip  $DEST_DIR_SKT		2>> $ICS_LOGFILE_SKT
	cp -f $SOURCE_CODE_DIR/out/target/product/m8skt/boot.img $DEST_DIR_SKT				2>> $ICS_LOGFILE_SKT
	cp -f $SOURCE_CODE_DIR/out/target/product/m8skt/recovery.img $DEST_DIR_SKT				2>> $ICS_LOGFILE_SKT
	cp -f $SOURCE_CODE_DIR/out/target/product/m8skt/u-boot.bin  $DEST_DIR_SKT				2>> $ICS_LOGFILE_SKT
	cp -f $SOURCE_CODE_DIR/device/amlogic/m8skt/u-boot-orig.bin  $DEST_DIR_SKT				2>> $ICS_LOGFILE_SKT
	cp -f $SOURCE_CODE_DIR/device/amlogic/m8skt/usb_spl.bin  $DEST_DIR_SKT				2>> $ICS_LOGFILE_SKT
	cp -f $SOURCE_CODE_DIR/$MANIFEST_FILE  $DEST_DIR_SKT				2>> $ICS_LOGFILE_SKT
	cp -f $SOURCE_CODE_DIR/out/target/product/m8skt/obj/KERNEL_OBJ/System.map $DEST_DIR_SKT							2>> $ICS_LOGFILE_SKT
	cp -f $SOURCE_CODE_DIR/out/target/product/m8skt/obj/KERNEL_OBJ/vmlinux $DEST_DIR_SKT							2>> $ICS_LOGFILE_SKT
	rm -fr  $SOURCE_CODE_DIR/out/target/product/m8skt/obj/KERNEL_OBJ 2>> $ICS_LOGFILE_SKT
	mkdir $SOURCE_CODE_DIR/out/target/product/m8skt/obj/KERNEL_OBJ 2>> $ICS_LOGFILE_SKT
	#device/amlogic/k200/quick_build_kernel.sh recoveryimage meson6_k200_usb_burning_defconfig 2>> $ICS_LOGFILE
	#cp -f $SOURCE_CODE_DIR/out/target/product/k200/recovery.img $SOURCE_CODE_DIR/out/target/product/k200/usb_burn_recovery.img 2>> $ICS_LOGFILE
    DATE=`date +%Y-%m-%d`
    UPDATE_ZIP=`ls $SOURCE_CODE_DIR/out/target/product/m8skt/m8skt*.zip`
    lftp -c "set ftp:list-options -a;
	open ftp://firmware.reference:Druf_T3t@ftp-china.amlogic.com/mbox/ref_fw_release/m8skt-M8-4.3-firmware
	mkdir -p $DATE
	cd $DATE
	put $DEST_DIR_SKT/boot.img
	put $DEST_DIR_SKT/recovery.img
#	put $DEST_DIR_SKT/usb_burn_recovery.img
	put $DEST_DIR_SKT/u-boot.bin
	put $DEST_DIR_SKT/$MANIFEST_FILE
	put $DEST_DIR_SKT/System.map
	put $DEST_DIR_SKT/vmlinux
	put $DEST_DIR/m8skt*.zip
	put $DEST_DIR_SKT/u-boot-orig.bin
	put $DEST_DIR_SKT/usb_spl.bin
    bye"

	else
		echo "Sorry, no folder found, will exit...."							2>> $ICS_LOGFILE_SKT
	fi
	date "+%Y-%m-%d %H:%M:%S"
fi


# 5. rootfs_k200_B make complie
if [ $STEP3_ROOTFS_MAKE_K200_B -ne 0 ];then
	DATE=`date +%Y-%m-%d-%H-%M-%S`
	echo "start to k200-B make rootfs"
	cp ../patch/common-external-dac.patch common/
	cd ./common
	git apply common-external-dac.patch
	cd ../
	. build/envsetup.sh
	lunch $LUNCH_NUM 2>> $ICS_LOGFILE
	export BOARD_REVISION=b
	make clean
	make  otapackage -j$TASK_NUM 2>> $ICS_LOGFILE
	if [ $? -ne 0 ];then
        echo "rootfs make rootfs_k200_B failed,exit!"
        exit
	fi
	echo "make k200-B finished"
	DATE=`date +%Y-%m-%d`
	mkdir -p $SOURCE_DIR_B/$DATE
	DEST_DIR="$SOURCE_DIR_B/$DATE"
	#ICS_LOGFILE="$DEST_DIR/autobuild_jb_$DATE.log"
	if [ -d $DEST_DIR ]; then
	cp -f $SOURCE_CODE_DIR/out/target/product/k200/k200*.zip  $DEST_DIR/k200-B-$DATE.zip			2>> $ICS_LOGFILE
	cp -f $SOURCE_CODE_DIR/out/target/product/k200/boot.img $DEST_DIR				2>> $ICS_LOGFILE
	cp -f $SOURCE_CODE_DIR/out/target/product/k200/recovery.img $DEST_DIR				2>> $ICS_LOGFILE
	cp -f $SOURCE_CODE_DIR/out/target/product/k200/u-boot.bin  $DEST_DIR				2>> $ICS_LOGFILE
	cp -f $SOURCE_CODE_DIR/device/amlogic/k200/u-boot-orig.bin  $DEST_DIR				2>> $ICS_LOGFILE
	cp -f $SOURCE_CODE_DIR/device/amlogic/k200/usb_spl.bin  $DEST_DIR				2>> $ICS_LOGFILE
	cp -f $SOURCE_CODE_DIR/$MANIFEST_FILE  $DEST_DIR				2>> $ICS_LOGFILE
	cp -f $SOURCE_CODE_DIR/out/target/product/k200/obj/KERNEL_OBJ/System.map $DEST_DIR							2>> $ICS_LOGFILE
	cp -f $SOURCE_CODE_DIR/out/target/product/k200/obj/KERNEL_OBJ/vmlinux $DEST_DIR							2>> $ICS_LOGFILE
	rm -fr  $SOURCE_CODE_DIR/out/target/product/k200/obj/KERNEL_OBJ 2>> $ICS_LOGFILE
	mkdir $SOURCE_CODE_DIR/out/target/product/k200/obj/KERNEL_OBJ 2>> $ICS_LOGFILE
	#device/amlogic/k200/quick_build_kernel.sh recoveryimage meson6_k200_usb_burning_defconfig 2>> $ICS_LOGFILE
	#cp -f $SOURCE_CODE_DIR/out/target/product/k200/recovery.img $SOURCE_CODE_DIR/out/target/product/k200/usb_burn_recovery.img 2>> $ICS_LOGFILE
    DATE=`date +%Y-%m-%d`
    UPDATE_ZIP=`ls $SOURCE_CODE_DIR/out/target/product/k200/k200*.zip`
    lftp -c "set ftp:list-options -a;
	open ftp://firmware.reference:Druf_T3t@ftp-china.amlogic.com/mbox/ref_fw_release/k200-B-M8-4.3-firmware
	mkdir -p $DATE
	cd $DATE
	put $DEST_DIR/boot.img
	put $DEST_DIR/recovery.img
#	put $DEST_DIR/usb_burn_recovery.img
	put $DEST_DIR/u-boot.bin
	put $DEST_DIR/$MANIFEST_FILE
	put $DEST_DIR/System.map
	put $DEST_DIR/vmlinux
	put $DEST_DIR/k200-B-$DATE.zip
	put $DEST_DIR/u-boot-orig.bin
	put $DEST_DIR/usb_spl.bin
	put $SOURCE_CODE_DIR/out/target/product/k200/aml_upgrade_package.img
	put $SOURCE_CODE_DIR/out/target/product/k200/aml_sdc_burn.ini
    bye"

	else
		echo "Sorry, no folder found, will exit...."							2>> $ICS_LOGFILE
	fi
	date "+%Y-%m-%d %H:%M:%S"
fi
