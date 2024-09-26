#!/bin/python3.10
# Author: Stefano Toscano <stefa.toscano@studenti.unina.it>
# Author: Vincenzo Maisto <vincenzo.maisto2@unina.it>
# Description:
#   Generate a valid AXI Crossbar tcl configuration file.
# Args:
#   1: Input configuration file
#   2: Output generated tcl file

####################
# Import libraries #
####################
# Parse args
import sys
# Manipulate CSV
import pandas as pd
# Sub-scripts
import read_properties_wrapper
import write_tcl
import configuration

##############
# Parse args #
##############

# CSV configuration file path
# config_file_name = 'config/axi_memory_map/configs/config.csv'
config_file_name = 'config/axi_memory_map/configs/PoC_config.csv'
if len(sys.argv) >= 2:
	config_file_name = sys.argv[1]

# Target TCL file
config_tcl_file_name = 'hw/xilinx/ips/xlnx_axi_crossbar/config.tcl'
if len(sys.argv) >= 3:
	config_tcl_file_name = sys.argv[2]

###############
# Environment #
###############
# utility function to compose 2-digit index
def compose_index ( index_int : int ):
    # Return value
    index_string = ""

    # Add a zero char and cast
    if (index_int < 10):
        index_string = "0" + str(i)
    # just cast
    else:
        index_string = str(i)

    # Return
    return index_string

# Avoid Pandas data truncations
pd.set_option('display.max_colwidth', 1000)

# Init configuration
config = configuration.Configuration()

###############
# Read config #
###############
# Read CSV file
config_df = pd.read_csv(config_file_name, sep=",")

########################
# Update configuration #
########################
# Update configuration by calling wrapper function for each property
for index, row in config_df.iterrows():
	config = read_properties_wrapper.read_property(config, row["Property"], row["Value"])

####################
# Prepare commands #
####################
# Creates the config commands in tcl
single_value_config_list = []
# Minimum amount of commands to produce
count_commands = 10

# Basic configurations
single_value_config_list.append("CONFIG.PROTOCOL {"          + config.PROTOCOL          + "}")
single_value_config_list.append("CONFIG.CONNECTIVITY_MODE {" + config.CONNECTIVITY_MODE + "}")
single_value_config_list.append("CONFIG.ADDR_WIDTH {"        + str(config.ADDR_WIDTH)   + "}")
single_value_config_list.append("CONFIG.DATA_WIDTH {"        + str(config.DATA_WIDTH)   + "}")
single_value_config_list.append("CONFIG.ID_WIDTH {"          + str(config.ID_WIDTH)     + "}")
single_value_config_list.append("CONFIG.NUM_SI {"            + str(config.NUM_SI)       + "}")
single_value_config_list.append("CONFIG.NUM_MI {"            + str(config.NUM_MI)       + "}")
single_value_config_list.append("CONFIG.ADDR_RANGES {"       + str(config.ADDR_RANGES)  + "}")
single_value_config_list.append("CONFIG.STRATEGY {"          + str(config.STRATEGY)     + "}")
single_value_config_list.append("CONFIG.R_REGISTER {"        + str(config.R_REGISTER)   + "}")
# AXI user
single_value_config_list.append("CONFIG.AWUSER_WIDTH {"  + str(config.AWUSER_WIDTH) + "}")
single_value_config_list.append("CONFIG.ARUSER_WIDTH {"  + str(config.ARUSER_WIDTH) + "}")
single_value_config_list.append("CONFIG.WUSER_WIDTH {"   + str(config.WUSER_WIDTH)  + "}")
single_value_config_list.append("CONFIG.RUSER_WIDTH {"   + str(config.RUSER_WIDTH)  + "}")
single_value_config_list.append("CONFIG.BUSER_WIDTH {"   + str(config.BUSER_WIDTH)  + "}")
count_commands = count_commands + 5

# Address ranges
BASE_ADDR_config_list        = []
RANGE_ADDR_WIDTH_config_list = []

# For each master
for i in range (config.NUM_MI):
    # Compose master index
    master_index = compose_index ( i )

    # For each address range
    for j in range (config.ADDR_RANGES):
        # Compose range index
        range_index = compose_index ( j )

        # Prepare configs
        BASE_ADDR_config_list       .append("CONFIG.M" + master_index + "_A" + range_index + "_BASE_ADDR {"  +            config.BASE_ADDR[(config.ADDR_RANGES * i) + j]  + "}")
        RANGE_ADDR_WIDTH_config_list.append("CONFIG.M" + master_index + "_A" + range_index + "_ADDR_WIDTH {" + str(config.RANGE_ADDR_WIDTH[(config.ADDR_RANGES * i) + j]) + "}")
        count_commands = count_commands + 2
# Append to list
single_value_config_list.extend(BASE_ADDR_config_list)
single_value_config_list.extend(RANGE_ADDR_WIDTH_config_list)

# Slave interfaces configurations
Slave_Priorities_config_list    = []
SI_Read_Acceptance_config_list  = []
SI_Write_Acceptance_config_list = []
Thread_ID_WIDTH_config_list     = []
Single_Thread_config_list       = []
Base_ID_config_list             = []
# For each slave interface
for i in range (config.NUM_SI):
    # Compose slave index
    slave_index = compose_index ( i )

    # Prepare configs
    Slave_Priorities_config_list    .append("CONFIG.S" + slave_index + "_ARB_PRIORITY {"     + str(config.Slave_Priorities[i])    + "}")
    SI_Read_Acceptance_config_list  .append("CONFIG.S" + slave_index + "_READ_ACCEPTANCE {"  + str(config.SI_Read_Acceptance[i])  + "}")
    SI_Write_Acceptance_config_list .append("CONFIG.S" + slave_index + "_WRITE_ACCEPTANCE {" + str(config.SI_Write_Acceptance[i]) + "}")
    Thread_ID_WIDTH_config_list     .append("CONFIG.S" + slave_index + "_THREAD_ID_WIDTH {"  + str(config.Thread_ID_WIDTH[i])     + "}")
    Single_Thread_config_list       .append("CONFIG.S" + slave_index + "_SINGLE_THREAD {"    + str(config.Single_Thread[i])       + "}")
    Base_ID_config_list             .append("CONFIG.S" + slave_index + "_BASE_ID {"          + config.Base_ID[i]                  + "}")
    count_commands = count_commands + 6
# Append to list
single_value_config_list.extend(Slave_Priorities_config_list)
single_value_config_list.extend(SI_Read_Acceptance_config_list)
single_value_config_list.extend(SI_Write_Acceptance_config_list)
single_value_config_list.extend(Thread_ID_WIDTH_config_list)
single_value_config_list.extend(Single_Thread_config_list)
single_value_config_list.extend(Base_ID_config_list)

# Slave interfaces configurations
MI_Read_Issuing_config_list = []
MI_Write_Issuing_config_list = []
Secure_config_list = []
# For each master interface
for i in range (config.NUM_MI):
    # Compose master index
    master_index = compose_index ( i )

    # Prepare configs
    MI_Read_Issuing_config_list .append("CONFIG.M" + master_index + "_READ_ISSUING {"  + str(config.MI_Read_Issuing[i])  + "}")
    MI_Write_Issuing_config_list.append("CONFIG.M" + master_index + "_WRITE_ISSUING {" + str(config.MI_Write_Issuing[i]) + "}")
    Secure_config_list          .append("CONFIG.M" + master_index + "_SECURE {"        + str(config.Secure[i])           + "}")
    count_commands = count_commands + 3
# Append to list
single_value_config_list.extend(MI_Read_Issuing_config_list)
single_value_config_list.extend(MI_Write_Issuing_config_list)
single_value_config_list.extend(Secure_config_list)

# Slave to master connectivity
Read_connectivity_config_list = []
Write_connectivity_config_list = []
for i in range (config.NUM_MI):
    # Compose master index
    master_index = compose_index ( i )

    # For each slave
    for j in range (config.NUM_SI):
        # Compose slave index
        slave_index = compose_index ( j )

        # Prepare configs
        Read_connectivity_config_list .append("CONFIG.M" + master_index + "_S" + slave_index + "_READ_CONNECTIVITY {"  + str(config.Read_Connectivity[config.NUM_SI*i+j])  + "}")
        Write_connectivity_config_list.append("CONFIG.M" + master_index + "_S" + slave_index + "_WRITE_CONNECTIVITY {" + str(config.Write_Connectivity[config.NUM_SI*i+j]) + "}")
        count_commands = count_commands + 2
# Append to list
single_value_config_list.extend(Read_connectivity_config_list)
single_value_config_list.extend(Write_connectivity_config_list)

##################
# Write TCL file #
##################

# Creates the actual TCL file
file = open(config_tcl_file_name,  "w")
# Write header lines
write_tcl.initialize_File(file)

# Write properties
for command in single_value_config_list:
	write_tcl.write_single_value_configuration(file, command)
	# Add new line
	file.write(" \\\r                         ")

# Write closing lines
write_tcl.end_File(file)

# Close file
file.close
