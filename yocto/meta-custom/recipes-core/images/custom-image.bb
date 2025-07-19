SUMMARY = "My custom Linux image."

IMAGE_INSTALL = "packagegroup-core-boot ${CORE_IMAGE_EXTRA_INSTALL}"

IMAGE_LINGUAS = " "

LICENSE = "MIT"

# Set rootfs to 200 MiB by default
IMAGE_OVERHEAD_FACTOR ?= "1.0"
IMAGE_ROOTFS_SIZE ?= "204800"

inherit core-image
inherit extrausers

PASSWD = "\$5\$nTqg9LWqDkNcJIxO\$Jf1POTZeqpRHR501QeHjitntLFlXjgD9r8iIUWGV9u9"
EXTRA_USERS_PARAMS = " \
  usermod -p '${PASSWD}' root; \
"