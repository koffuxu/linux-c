#!/system/bin/sh

mount -rw -o remount /system
rm /system/app/FileBrowser.apk 
echo "remove FileBrowser done"
