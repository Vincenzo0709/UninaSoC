# Author: Zaira Abdel Majid <z.abdelmajid@studenti.unina.it>
# Author: Vincenzo Maisto <vincenzo.maisto2@unina.it>
# Description: tcl script used to transfer a .bin file in a BRAM memory using jtag2axi IP and axi transactions
# Input args:
#    -argv0: absolute path to bin file to transfer
#    -argv1: base address of BRAM
#    -argv2: whether to read-back data after writing

#########
# Utils #
#########

# Utility function to read binary file
proc read_file_to_words {filename fsize} {
    # Open file
    set fp [open $filename r]

    # Translate file to binary
    fconfigure $fp -translation binary

    # Read data
    set file_data [read $fp $fsize]

    # Close file
    close $fp

    # Return
    return $file_data
}

##############
# Parse args #
##############
if { $argc != 3 } {
    puts "Usage <filename> <base_address> <read_back>"
    puts "filename      : path to bin file to transfer"
    puts "base_address  : base address of BRAM"
    puts "read_back     : whether to read-back data after writing"
    return
} else {
    set filename        [lindex $argv 0]
    set base_address    [lindex $argv 1]
    set read_back       [lindex $argv 2]
}

########
# Init #
########

# Disable message limit
set_msg_config -id {Labtoolstcl 44-481} -limit 99999

# File size in bytes
set fsize [file size $filename]

# AXI transaction names
set gpio_wr_txn gpio_wr_txn
set gpio_rd_txn gpio_rd_txn

# Internal variables:
#    -data_list: binary file read at absolute path
#    -num_bursts: size of each "burst" (data sent) in each transaction in bytes (4 -> 32 bits). This parameter is architecture dependent.
#    -remaining bytes: reminder in terms of bytes that will handled with padding.
#    -segment: chunk of $burst_size bytes extracted from data_lists and converted in hexadecimal

# Read file
set data_list [read_file_to_words $filename $fsize]
# Burst size in bytes
set burst_size 4
# Number of $burst_size-bytes transaction
set num_bursts [expr {int( $fsize / $burst_size)}]
# Remining bytes
set remaining_bytes [expr {$fsize % $burst_size}]

# Print warning
if { $remaining_bytes != 0 } {
    # Padding size
    set pad_size [expr $burst_size - $remaining_bytes ]
    # Warning message
    puts stderr "\[WARINING\] Binary has non $burst_size-aligned size ($fsize), padding with $pad_size zero-bytes"
    # Pad with zeros
    for {set i 0} {$i < $pad_size} {incr i} {
        set data_list "$data_list\0"
    }
    # Add one burst
    incr num_bursts
}

###################
# Write to memory #
###################
# Run burst-based transactions
for {set i 0} {$i < $num_bursts} {incr i} {
    # Select $burst_size-wide segment to read
    set segment [string range $data_list [expr {$i * $burst_size}] [expr {($i + 1) * $burst_size} -1]]

    # Invert endiannes from string (0x01234567 -> 0x67543201)
    set str_tmp ""
    for {set j 0} {$j < $burst_size} {incr j} {
        set str_tmp [string index $segment $j]$str_tmp
    }
    set segment $str_tmp

    # Convert to binary
    binary scan $segment H* Memword

    # Calculate address
    set address [format 0x%x [expr {$base_address + $i * $burst_size}]]

    # Create and run transaction
    create_hw_axi_txn $gpio_wr_txn [get_hw_axis hw_axi_1] -type write -force -address $address -data $Memword -len $burst_size
    run_hw_axi [get_hw_axi_txns $gpio_wr_txn]

    # Debug
    # puts "Writing to address $address"
}

#########################
# Read-back from memory #
#########################

if { $read_back == "true" } {
    for {set i 0} {$i < $num_bursts} {incr i} {
        # Compose address
        set address [format 0x%x [expr {$base_address + $i * $burst_size}]]

        # Create and run transaction
        create_hw_axi_txn $gpio_rd_txn [get_hw_axis hw_axi_1] -type read -force -address $address
        run_hw_axi [get_hw_axi_txns $gpio_rd_txn]

        # Debug
        # puts "Reading from to address $address"
    }
}

############
# Clean up #
############
# Restore message limit
reset_msg_config -id {Labtoolstcl 44-481} -limit