# Author: Stefano Toscano <stefa.toscano@studenti.unina.it>
# Description: this script contains the functions used to create the tcl Configuration file for the Crossbar Component.

def initialize_File(file): # Creates the standard initial part of the tcl Configuration file
    file.write("# This file is auto-generated with CreateCrossbarConfiguration.py\n")
    file.write("# Import IP\n")
    file.write("create_ip -name axi_crossbar -vendor xilinx.com -library ip -version 2.1 -module_name $::env(IP_NAME)\n")
    file.write("# Configure IP\n")
    file.write("set_property -dict [list ")

def end_File(file): # Creates the standard final part of the tcl Configuration file
    file.write("] [get_ips $::env(IP_NAME)]")

def write_single_value_configuration(file, command): # Creates a single property of the tcl Configuration file
    file.write(command)

