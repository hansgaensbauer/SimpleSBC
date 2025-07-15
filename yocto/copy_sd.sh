# #! /bin/bash

#!/bin/bash
set -e

SDCARD="/dev/sda"
IMAGEPATH="build-simplesbc/tmp/deploy/images/stm32mp1"

echo "WARNING: This will erase ALL data on $SDCARD!"
read -p "Type YES to continue: " confirm
if [[ "$confirm" != "YES" ]]; then
    echo "Aborting."
    exit 1
fi

# Unmount all partitions first
umount ${SDCARD}* || true

# Define partition sizes in sectors (512 bytes each)
# Sizes from your layout:

SECTOR_SIZE=512
fsbl1_size="511"
fsbl2_size="511"
metadata1_size="1023"
metadata2_size="1023"
fip_size="2M"
bootfs_size="64M"
vendorfs_size="2M"

# Create fdisk input
fdisk ${SDCARD} <<EEOF
d
7
d
6
d
5
d
4
d
3
d
2
d
g
n
1

+$fsbl1_size
t
11
n
2

+$fsbl2_size
t
2
11
n
3

+$metadata1_size
t
3
11
n
4

+$metadata2_size
t
4
11
n
5

+$fip_size
t
5
11
n
6

+$bootfs_size
t
6
20
n
7


t
7
20
x
n
1
fsbl1
n
2
fsbl2
n
3
metadata1
n
4
metadata2
n
5
fip-a
n
6
bootfs
n
7
rootfs
A
6
p
r
w
EEOF

# Let kernel detect new partitions
sleep 2

dd if=${IMAGEPATH}/arm-trusted-firmware/tf-a-stm32mp157f-dk2-optee-sdcard.stm32 of=${SDCARD}1
dd if=${IMAGEPATH}/arm-trusted-firmware/tf-a-stm32mp157f-dk2-optee-sdcard.stm32 of=${SDCARD}2
dd if=${IMAGEPATH}/arm-trusted-firmware/metadata.bin of=${SDCARD}3
dd if=${IMAGEPATH}/arm-trusted-firmware/metadata.bin of=${SDCARD}4
dd if=${IMAGEPATH}/fip/fip-stm32mp157f-dk2-optee-sdcard.bin of=${SDCARD}5
dd if=${IMAGEPATH}/st-image-bootfs-poky-stm32mp1.bootfs.ext4 of=${SDCARD}6 bs=1M
dd if=${IMAGEPATH}/custom-image-stm32mp1.rootfs.ext4 of=${SDCARD}7 bs=1M

sgdisk --partition-guid=3:8A7A84A0-8387-40F6-AB41-A8B9A5A60D23 ${SDCARD}
sgdisk --partition-guid=4:8A7A84A0-8387-40F6-AB41-A8B9A5A60D23 ${SDCARD}
sgdisk --partition-guid=5:4fd84c93-54ef-463f-a7ef-ae25ff887087 ${SDCARD}
sgdisk --typecode=5:19D5DF83-11B0-457b-BE2C-7559C13142A5 ${SDCARD}
sgdisk --partition-guid=6:0FC63DAF-8483-4772-8E79-3D69D8477DE4 ${SDCARD}
sgdisk --partition-guid=7:e91c4e10-16e6-4c0e-bd0e-77becf4a3582 ${SDCARD}


sync
echo "All done!"

