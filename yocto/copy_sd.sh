#! /bin/bash
sudo dd if=arm-trusted-firmware/tf-a-stm32mp157f-dk2-sdcard.stm32 of=/dev/mmcblk0p1
sudo dd if=arm-trusted-firmware/tf-a-stm32mp157f-dk2-sdcard.stm32 of=/dev/mmcblk0p2
sudo dd if=fip/fip-stm32mp157f-dk2-trusted.bin of=/dev/mmcblk0p3
sudo dd if=st-image-bootfs-poky-stm32mp1.ext4 of=/dev/mmcblk0p4 bs=1M
sudo dd if=custom-image-stm32mp1.ext4 of=/dev/mmcblk0p5 bs=1M