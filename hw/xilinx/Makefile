# Basic variables for Vivado
XILINX_VIVADO_CMD ?= vivado
XILINX_VIVADO_MODE ?= batch
# Build directory
XILINX_PROJECT_BUILD_DIR ?= ${XILINX_ROOT}/build/
# Vivado project directory
XILINX_PROJECT_DIR ?= ${XILINX_PROJECT_BUILD_DIR}/${XILINX_PROJECT_NAME}
# Vivado's compilation reports directory
XILINX_PROJECT_REPORTS_DIR ?= ${XILINX_PROJECT_BUILD_DIR}/reports


# List of the Xilinx IPs to build and import in the design
# Parsing from directory ips/
XILINX_IP_LIST = $(shell basename --multiple ${XILINX_IPS_ROOT}/xlnx_*)

# List of IPs' xci files
XILINX_IP_LIST_XCI := $(foreach ip,${XILINX_IP_LIST},${XILINX_IPS_ROOT}/${ip}/build/${ip}.srcs/sources_1/ip/${ip}/${ip}.xci)

#path to demo_j2a compilation script
COMPILE_BLINKLED_SCRIPT_PATH := sw/src/PoC_jtag2axi/compile.sh

# Runtime optimized run strategies
SYNTH_STRATEGY ?= Flow_RuntimeOptimized
IMPL_STRATEGY ?= Flow_RuntimeOptimized

# Full environment variables list for Vivado
# XILINX_PROJECT_LTX=${XILINX_PROJECT_LTX}
XILINX_VIVADO_ENV ?=              					\
	SYNTH_STRATEGY=${SYNTH_STRATEGY}				\
	IMPL_STRATEGY=${IMPL_STRATEGY}					\
    XILINX_PART_NUMBER=${XILINX_PART_NUMBER}   		\
    XILINX_PROJECT_NAME=${XILINX_PROJECT_NAME}   	\
    XILINX_BOARD=${XILINX_BOARD}   					\
    XILINX_HW_SERVER_HOST=${XILINX_HW_SERVER_HOST}  \
    XILINX_HW_SERVER_PORT=${XILINX_HW_SERVER_PORT}  \
    XILINX_FPGA_DEVICE=${XILINX_FPGA_DEVICE}		\
    XILINX_BITSTREAM=${XILINX_BITSTREAM}   			\
	XILINX_IP_LIST_XCI="${XILINX_IP_LIST_XCI}" 		\
	XILINX_ROOT=${XILINX_ROOT}						\
    QUESTA_PATH=${QUESTA_PATH}   					\
    GCC_PATH=${GCC_PATH}   							\
    XILINX_SIMLIB_PATH=${XILINX_SIMLIB_PATH}  

# Package Vivado command in a single variable
XILINX_VIVADO := ${XILINX_VIVADO_ENV} ${XILINX_VIVADO_CMD} -mode ${XILINX_VIVADO_MODE}
XILINX_VIVADO_BATCH := ${XILINX_VIVADO_ENV} ${XILINX_VIVADO_CMD} -mode batch

all: bitstream

# Open project
open:
	cd ${XILINX_PROJECT_BUILD_DIR};			\
	${XILINX_VIVADO_ENV} ${XILINX_VIVADO_CMD} \
	-mode tcl ${XILINX_PROJECT_NAME}.xpr

# Open project
gui:
	cd ${XILINX_PROJECT_BUILD_DIR};			\
	${XILINX_VIVADO_ENV} ${XILINX_VIVADO_CMD} \
	-mode gui ${XILINX_PROJECT_NAME}.xpr

# Build bitstream from scratch
bitstream: ips
	mkdir -p ${XILINX_PROJECT_DIR}
	mkdir -p ${XILINX_PROJECT_REPORTS_DIR}
	cd ${XILINX_PROJECT_BUILD_DIR};			\
	${XILINX_VIVADO} -source ${XILINX_ROOT}/synth/tcl/build_bitstream.tcl

# Generate ips
XILINX_IP_NAMES ?= $(addsuffix .xci, ${XILINX_IP_LIST})
ips: ${XILINX_IP_NAMES}

# Build single IP
%.xci: IP_NAME=$*
%.xci: IP_BUILD_DIR=${XILINX_IPS_ROOT}/$*/build
%.xci: ips/%/config.tcl
	@echo "Generating IP $@"
	mkdir -p ${IP_BUILD_DIR}; 						 		\
	cd       ${IP_BUILD_DIR}; 						 		\
	export IP_NAME=${IP_NAME}; ${XILINX_VIVADO_BATCH}		\
		-source ${XILINX_IPS_ROOT}/common/pre_config.tcl 	\
		-source ${XILINX_IPS_ROOT}/$*/config.tcl			\
		-source ${XILINX_IPS_ROOT}/common/post_config.tcl
	touch $@

# Start hardware server
start_hw_server:
	hw_server -stcp::3232 -p3120 --init=/home/vcu128-02/vivado_scripts/hw_server_startup.txt

# Open Vivado hardware manager
open_hw_manager:
	${XILINX_VIVADO} \
		-source ${XILINX_SYNTH_TCL_ROOT}/$@.tcl
# -source ${XILINX_SYNTH_TCL_ROOT}/set_ila_trigger.tcl

program_bitstream:
	${XILINX_VIVADO} \
		-source ${XILINX_SYNTH_TCL_ROOT}/$@.tcl

# Simulation
sim_compile_simlib:
	${XILINX_VIVADO_BATCH} -source ${XILINX_SIM_TCL_ROOT}/compile_simlib.tcl

sim_export_%: ${XILINX_IPS_ROOT}/%/questa/compile.do
${XILINX_IPS_ROOT}/%/questa/compile.do: ${XILINX_SIM_IP_ROOT}
	cd ${XILINX_SIMLIB_PATH}; \
	VIVADO_PROJECT=${XILINX_IPS_ROOT}/$*/build/$*.xpr \
	${XILINX_VIVADO_BATCH} -source ${XILINX_SIM_TCL_ROOT}/export_simulation.tcl

${XILINX_SIM_IP_ROOT}/ips:
	mkdir -p $@

# Start Demo Jtag to Axi
# IMPORTANT! Write absolute path between two high quotes with double slashes 
# i.e. "C:\\Users\\user\\Downloads\\blink.bin"
# command should be launched like this <make demo_j2a path="C:\\Users\\user\\Downloads\\blink.bin" base_address="0x4000000">

demo_j2a:
	#compile blinkled demo project
	@sh $(COMPILE_BLINKLED_SCRIPT_PATH)
	#transfer it to BRAM with tcl script
	@if [ -z "$(path)" ] || [ -z "$(base_address)" ]; then \
		echo "Usage: make demo_j2a path=<path_to_bin_file> base_address=<address_value>"; \
		exit 1; \
	fi
	@echo "Running TCL script with path=$(path) and base_address=$(base_address)"
	${XILINX_VIVADO} \
		-mode batch -source ${XILINX_SYNTH_TCL_ROOT}/jtag2axi_master_load_binary.tcl -tclargs $(path) $(base_address)

# Clean up project
clean:
	rm -rf ${XILINX_PROJECT_BUILD_DIR}

clean_ips:
	rm -rf ${XILINX_IPS_ROOT}/*/build
	rm -rf *.xci

###########
# PHONIES #
###########
.PHONY: open gui bitstream ips open_hw_manager sim_compile_simlib clean clean_ips

