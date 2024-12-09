## Author: Vincenzo Maisto <vincenzo.maisto2@unina.it>
## Description: Utility variables and macros for AXI interconnections in UninaSoC

# Define a list of all the source files
set src_file_list [ list \
    $::env(XILINX_ROOT)/rtl/uninasoc_pkg.sv         \
    $::env(XILINX_ROOT)/rtl/uninasoc_axi.svh        \
    $::env(XILINX_ROOT)/rtl/uninasoc_pcie.svh       \
    $::env(XILINX_ROOT)/rtl/uninasoc_ddr4.svh       \
    $::env(XILINX_ROOT)/rtl/sys_master.sv           \
    $::env(XILINX_ROOT)/rtl/rvm_socket.sv           \
    $::env(XILINX_ROOT)/rtl/virtual_uart.sv         \
    $::env(XILINX_ROOT)/rtl/axi4_full_uart.sv       \
    $::env(XILINX_ROOT)/rtl/ddr4_wrapper.sv         \
    $::env(XILINX_ROOT)/rtl/uninasoc.sv             \
]

# Add files to project
add_files -norecurse -fileset [current_fileset] $src_file_list