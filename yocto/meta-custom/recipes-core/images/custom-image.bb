SUMMARY = "My custom Linux image."

IMAGE_INSTALL = "packagegroup-core-boot ${CORE_IMAGE_EXTRA_INSTALL}"

IMAGE_LINGUAS = " "

LICENSE = "MIT"

inherit core-image
inherit extrausers

# Set rootfs to 200 MiB by default
IMAGE_OVERHEAD_FACTOR ?= "1.0"
IMAGE_ROOTFS_SIZE ?= "204800"

# Change root password (note the capital -P)
EXTRA_USERS_PARAMS = "\
  usermod -p '$6$MmMB9wq64EQ1/HYo$UJtUk4dyLNcW3a5QlRWy6P6b2fUlmRV4rb995KgaXQSZCZMfBwc1GSyjOhJDeEDHk0dUly5YPpSarj8FhDZpw' root \
  "