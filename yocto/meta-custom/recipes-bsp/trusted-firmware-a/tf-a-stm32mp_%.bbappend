FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += " \
    file://0001-i2c4-pinmux-tfa.patch \
    file://stm32mp157-simplesbc.dts \
    file://stm32mp157-simplesbc-fw-config.dts \
"

# Copy the device tree to TF-A's fdts directory
do_configure:prepend() {
    cp ${WORKDIR}/stm32mp157-simplesbc.dts ${S}/fdts/
    cp ${WORKDIR}/stm32mp157-simplesbc-fw-config.dts ${S}/fdts/
}