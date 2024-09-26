# Variables
PYTHON = python3.10

all: xilinx hw sw

hw:

xilinx:
	${MAKE} -C ${XILINX_ROOT}

.PHONY:
sw:
	${MAKE} -C ${SW_ROOT}

.PHONY: sim xilinx sw

AXI_CONFIG  ?= config/axi_memory_map/configs/PoC_config.csv
# AXI_CONFIG  ?= config/axi_memory_map/configs/config.csv
OUTPUT_FILE ?= hw/xilinx/ips/xlnx_axi_crossbar/config.tcl
config_axi:
	${PYTHON} config/axi_memory_map/create_crossbar_config.py \
		${AXI_CONFIG} \
		${OUTPUT_FILE}
	@echo "Output file is at ${OUTPUT_FILE}"


