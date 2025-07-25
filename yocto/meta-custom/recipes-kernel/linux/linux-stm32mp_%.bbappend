FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += " \
    file://0001-change-i2c-pinmux.patch \
    file://dts/stm32mp157-simplesbc.dts \
    file://0004-custom-device-tree.patch \
"

do_configure:append() {
    # Create the external-dt directory structure
    # mkdir -p ${TMPDIR}/work-shared/${MACHINE}/external-dt/stm32mp1/linux
    
    # Copy your device tree source file
    cp ${WORKDIR}/dts/stm32mp157-simplesbc.dts ${TMPDIR}/work-shared/${MACHINE}/external-dt/stm32mp1/linux/
    
    # Also copy to arch/arm/dts
    cp ${WORKDIR}/dts/stm32mp157-simplesbc.dts ${S}/arch/arm/boot/dts/st/
}
