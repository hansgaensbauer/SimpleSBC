FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += ""

do_configure:prepend() {
    # cp ${WORKDIR}/stm32mp157-simplesbc.dts ${TMPDIR}/work-shared/${MACHINE}/external-dt/stm32mp1/optee/
}