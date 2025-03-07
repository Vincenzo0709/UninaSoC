# Import IP by version
create_ip -name axi_protocol_converter -vendor xilinx.com -library ip -version 2.1 -module_name $::env(IP_NAME)

# Configure IP
set_property -dict  [list	CONFIG.MI_PROTOCOL      {AXI4} \
							CONFIG.READ_WRITE_MODE  {READ_WRITE} \
							CONFIG.SI_PROTOCOL      {AXI4LITE} \
							CONFIG.TRANSLATION_MODE {2} \
                    ] [get_ips $::env(IP_NAME)]

# Use envvars out of list
set_property CONFIG.DATA_WIDTH  $::env(AXI_DATA_WIDTH)  [get_ips $::env(IP_NAME)]
set_property CONFIG.ADDR_WIDTH  $::env(AXI_ADDR_WIDTH)  [get_ips $::env(IP_NAME)]

