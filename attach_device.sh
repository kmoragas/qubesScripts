#/bin/bash

# To create a new device:
# truncate -s 5GB /var/lib/qubes/cache.img
qvm-block -A work-tec dom0:/var/lib/qubes/appvms/work-tec/music.img
