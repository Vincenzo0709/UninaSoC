# Author: Stefano Toscano <stefa.toscano@studenti.unina.it>
# Description: Declaration of wrapper class for configuration properties with their default values (if any). Lists are just initialized as empty.

# Wrapper class for configuration properties
class Configuration:
	PROTOCOL			: str = "AXI4"	# AXI PROTOCOL used
	CONNECTIVITY_MODE	: str = "SASD"	# Crossbar Configuration, Shared-Address/Multiple-Data(SAMD) or Shared-Address/Shared-Data(SASD)
	ADDR_WIDTH			: int = 32 		# Address Width
	DATA_WIDTH			: int = 32 		# Data Width
	ID_WIDTH			: int = 4		# ID Data Width for MI and SI (a subset of it is used by the Interfaces Thread IDs)
	NUM_MI				: int = 2 		# Master Interface (MI) Number
	NUM_SI				: int = 1 		# Slave Interface (SI) Number
	ADDR_RANGES			: list = 1 		# Number of Address Ranges for all MI
	BASE_ADDR			: list = [] 	# the Base Address of each Range of each Master
	RANGE_ADDR_WIDTH	: list = [] 	# the width of each Range of each Master
	Read_Connectivity	: list = [] 	# the enable option for each MI_to_SI possible Connection for Read Operations
	Write_Connectivity	: list = [] 	# the enable option for each MI_to_SI possible Connection for Write Operations
	STRATEGY			: int = 0 		# Implementation strategy, Minimize Area (1), Maximize Performance (2)
	R_REGISTER			: int = 0 		# Internal Registers division
	Slave_Priorities	: list = [] 	# Scheduling Priority for each Slave
	SI_Read_Acceptance	: list = [] 	# Number of possible Active Read Transaction at the same time for each Slave
	SI_Write_Acceptance	: list = [] 	# Number of possible Active Write Transaction at the same time for each Slave
	Thread_ID_WIDTH		: list = [] 	# Number of ID bits used by each SI for thei respective Threads
	Single_Thread		: list = [] 	# Enable options for each SI in regards to the Single Thread Option
	Base_ID				: list = [] 	# Base ID for each SI
	MI_Read_Issuing		: list = [] 	# Number of possible Active Read Transaction at the same time for each Master
	MI_Write_Issuing	: list = [] 	# Number of possible Active Write Transaction at the same time for each Master
	Secure				: list = [] 	# Master secure mode
	AWUSER_WIDTH		: int = 0		# AXI AW User width
	ARUSER_WIDTH		: int = 0		# AXI AR User width
	WUSER_WIDTH			: int = 0		# AXI  W User width
	RUSER_WIDTH			: int = 0		# AXI  R User width
	BUSER_WIDTH			: int = 0		# AXI  B User width

