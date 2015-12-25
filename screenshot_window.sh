#!/bin/bash
ksnapshot &
sleep 1

mypid=`pidof -s ksnapshot`
qdbus org.kde.ksnapshot-$mypid /KSnapshot org.kde.ksnapshot.setGrabMode 1
qdbus org.kde.ksnapshot-$mypid /KSnapshot org.kde.ksnapshot.setTime 0

qdbus org.kde.ksnapshot-$mypid /KSnapshot org.kde.ksnapshot.slotGrab

sleep 8

image_name=`date +"screenshot-%Y-%m-%d_%T.png"`

qdbus org.kde.ksnapshot-$mypid /KSnapshot org.kde.ksnapshot.setURL "/tmp/$image_name"

qdbus org.kde.ksnapshot-$mypid /KSnapshot org.kde.ksnapshot.slotSave

qdbus org.kde.ksnapshot-$mypid /KSnapshot org.kde.ksnapshot.exit

cat /tmp/$image_name | qvm-run --pass-io work-tec "cat > /home/user/Pictures/$image_name"
