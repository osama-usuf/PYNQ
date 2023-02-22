FILESEXTRAPATHS:prepend := "${THISDIR}/files_daffodil:"
SRC_URI:append = "\
    file://pynq_xlnk_zynq.dtsi \
    file://pynq_bootargs.dtsi \
    file://pynq_daffodil.dtsi \
    file://pynq_zynq.dtsi \
"
# 
#    file://pynq_zocl_intc_zynq.dtsi \
# PYNQ_BOARDNAME="${BB_ORIGENV[PYNQ_BOARDNAME]}"
# FPGA_MANAGER="${BB_ORIGENV[FPGA_MANAGER]}"

do_configure:append:zynq () {
    PYNQ_BOARDNAME="${@d.getVar('BB_ORIGENV', False).getVar('PYNQ_BOARDNAME', True)}"
    FPGA_MANAGER="${@d.getVar('BB_ORIGENV', False).getVar('FPGA_MANAGER', True)}"
    echo '/include/ "pynq_zynq.dtsi"' >> ${DT_FILES_PATH}/system-top.dts
    echo '/include/ "pynq_daffodil.dtsi"' >> ${DT_FILES_PATH}/system-top.dts
    # echo "/include/ \"pynq_zocl_intc_zynq.dtsi\"" >> ${DT_FILES_PATH}/system-top.dts
    if [ "${FPGA_MANAGER}" = 1 ]; then
        echo "FPGA Manager should be off, error in device-tree.bbappend. Interrupts can't be dynamically loaded (https://discuss.pynq.io/t/pynq-2-6-1-xrt-zynq/1965/10)"
        exit 1
    else
        echo "FPGA Manager is off, continuing"
    fi
    if [ -n "${PYNQ_BOARDNAME}" ]; then
        echo "/ { chosen { pynq_board = \"${PYNQ_BOARDNAME}\"; }; };" >> ${DT_FILES_PATH}/system-top.dts
    else
        echo "No board set"
        exit 1
    fi
}

do_configure[vardepsexclude] = "BB_ORIGENV"