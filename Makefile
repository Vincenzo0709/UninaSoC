# Variables

all: xilinx hw sw

.PHONY: hw
hw:

.PHONY: xilinx
xilinx:
	${MAKE} -C ${XILINX_ROOT} bitstream

.PHONY: sw
sw:

.PHONY: sim
sim:



