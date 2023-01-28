FILESEXTRAPATHS:prepend := "${THISDIR}/files_daffodil:"
SRC_URI:append = "\
    file://pynq_bootargs.dtsi \
    file://pynq_daffodil.dtsi \
"

# PYNQ_BOARDNAME="${BB_ORIGENV[PYNQ_BOARDNAME]}"
# FPGA_MANAGER="${BB_ORIGENV[FPGA_MANAGER]}"

do_configure:append:zynq () {
    PYNQ_BOARDNAME="${@d.getVar('BB_ORIGENV', False).getVar('PYNQ_BOARDNAME', True)}"
    FPGA_MANAGER="${@d.getVar('BB_ORIGENV', False).getVar('FPGA_MANAGER', True)}"
    echo '/include/ "pynq_bootargs.dtsi"' >> ${DT_FILES_PATH}/system-top.dts
    echo '/include/ "pynq_daffodil.dtsi"' >> ${DT_FILES_PATH}/system-top.dts
    if [ "${FPGA_MANAGER}" = 1 ]; then
        echo "FPGA Manager should be off, error in device-tree.bbappend"
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
