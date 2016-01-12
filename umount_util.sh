#!/bin/bash
#
# To create a new disc:
# truncate -s 20GB util.img
# mkfs.ext4 util.img

function usage
{
        echo "usage: umount [-v vm_name] | [-h]"
}

VM=untrusted

if [ $# -eq 0 ]; then
        usage
        exit 1
fi

while [ "$1" != "" ]; do
        case $1 in
                -v | --vm )     shift
                                VM=$1
                                ;;
                -h | -help )    usage
                                exit
                                ;;
                * )             usage
                                exit 1
        esac
        shift
done

if [ "$VM" == "dom0" ]; then
	# This script umount util from dom0
	sudo umount /home/user/util/
	sudo losetup -d /dev/loop99

        exit 0
fi


qvm-run $VM "sudo umount /dev/xvdu /media/util"
qvm-block -d $VM -f xvdu
