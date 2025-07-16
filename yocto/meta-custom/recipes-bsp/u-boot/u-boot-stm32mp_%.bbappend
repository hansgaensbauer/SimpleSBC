FILESEXTRAPATHS:prepend := "${THISDIR}/u-boot-stm32mp:"

SRC_URI += " \
    file://0003-remove-sdmmc1-cd.patch \
    file://0005-add-simplesbc-dtb-uboot.patch \
    file://stm32mp157-simplesbc.dts \
    file://stm32mp157-simplesbc-u-boot.dtsi \
"

do_configure:prepend() {
    # Create the external-dt directory structure
    mkdir -p ${TMPDIR}/work-shared/${MACHINE}/external-dt/stm32mp1/u-boot
    
    # Copy your device tree source file
    cp ${WORKDIR}/stm32mp157-simplesbc.dts ${TMPDIR}/work-shared/${MACHINE}/external-dt/stm32mp1/u-boot/
    cp ${WORKDIR}/stm32mp157-simplesbc-u-boot.dtsi ${TMPDIR}/work-shared/${MACHINE}/external-dt/stm32mp1/u-boot/
    
    # Also copy to arch/arm/dts
    cp ${WORKDIR}/stm32mp157-simplesbc.dts ${S}/arch/arm/dts/
    cp ${WORKDIR}/stm32mp157-simplesbc-u-boot.dtsi ${S}/arch/arm/dts/
}