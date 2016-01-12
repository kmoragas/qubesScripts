#!/bin/bash
#
# To create a new disc:
# truncate -s 20GB util.img
# mkfs.ext4 util.img

function usage
{
	echo "usage: mount [-v vm_name] | [-h]"
}

VM=untrusted

if [ $# -eq 0 ]; then
	usage
	exit 1
fi

while [ "$1" != "" ]; do
	case $1 in
		-v | --vm )	shift
				VM=$1
				;;
		-h | -help )	usage
				exit
				;;
		* )		usage
				exit 1
	esac
	shift
done

if [ "$VM" == "dom0" ]; then
	# This script mount a util img on Dom0 using loop99
	sudo mknod -m 660 /dev/loop99 b 7 99
	sudo losetup /dev/loop99 /var/lib/qubes/extra-disk/util.img
	sudo mount /dev/loop99 /home/user/util/
        exit 0
fi

qvm-block -A $VM dom0:/var/lib/qubes/extra-disk/util.img -f xvdu
qvm-run $VM "sudo mkdir /media/util"
qvm-run $VM "sudo mount /dev/xvdu /media/util"
