# Author: Stefano Toscano <stefa.toscano@studenti.unina.it>
# Author: Vincenzo Maisto <vincenzo.maisto2@unina.it>
# Description: Definitions of the property-specific parsing functions and checking constraint.
#			  If constraints aren't respected, correct values are used, issuing a warning and ignoring the input.

###################
# Import packages #
###################
# to print logging and error messages in the shell
import logging
# for math operations
import math
# configuration Class declaration
from configuration import *

def read_Interfaces (
		config,
		property_name : str,
		property_value: str,
	):
	# Reads the number of Master and Slave Interfaces
	# The range of possible values is (0..16) whith 1 as deafault value
	# If the value is missing or is incorrect in the csv file,  default value is used
	value = int(property_value)
	if (property_value != ""):
		if (value in range(0, 17)):
			match property_name :
				case "NUM_SI":
					config.NUM_SI = value
				case "NUM_MI":
					config.NUM_MI = value
		else:
			logging.warning(property_name  + " out-of-range (0..16). Using default value.")
	else:
		logging.info("No" + property_name  + " specified. Using default value.")
	return config

def read_STRATEGY (
		config,
		property_name : str,
		property_value: str,
	):
	# Reads the configuration STRATEGY
	# The range of possible values is [0 ; 2] whith 0 as deafault value
	# 0 => Use configuration STRATEGY in the Connectivity Mode property_name
	# 1 => SASD
	# 2 => SAMD
	# If the value is missing or is incorrect in the csv file,  default value is used
	value = int(property_value)
	if (property_value != ""):
		if (value in range(0, 3)):
			config.STRATEGY = value
		else:
			logging.warning("STRATEGY out-of-range [0 ; 2]. Using default value.")
	else:
		logging.info("No STRATEGY specified. Using default value.")
	return config

def read_R_REGISTER (
		config,
		property_name : str,
		property_value: str,
	):
	# Reads the R_REGISTER value
	# The range of possible values is (0, 1) whith 0 as deafault value
	# 1 => only if SASD configuration STRATEGY is selected
	# If the value is missing or is incorrect in the csv file,  default or coherent value is used
	value = int(property_value)
	if (config.STRATEGY == 2):
		config.R_REGISTER = 0
		logging.warning("configuration STRATEGY set to 2. By default Connectivity Mode is SAMD and R_REGISTER is 0. input Ignored.")
	else:
		if (property_value != ""):
			if (value in range(0, 2)):
				config.R_REGISTER = value
			else:
				logging.warning("R_REGISTER value out-of-range (0, 1). Using default value.")
		else:
			logging.info("NoR_Regiter value specified. Using default value.")
	return config

def read_PROTOCOL (
		config,
		property_name : str,
		property_value: str,
	):
	# Reads the AXI PROTOCOL Version
	# The range of possible values is (AXI4, AXI4LITE, AXI3) whith AXI4 as deafault value
	# If the value is missing or is incorrect in the csv file,  default value is used
	if (property_value != ""):
		if ((property_value == "AXI4") or (property_value == "AXI4LITE") or (property_value == "AXI3")):
			config.PROTOCOL = property_value
		else:
			logging.warning("PROTOCOL invalid. Using default value (AXI4).")
	else:
		logging.info("NoPROTOCOL specified. Using default value (AXI4).")
	return config

def read_ADDR_WIDTH (
		config,
		property_name : str,
		property_value: str,
	):
	# Reads the Address Widdth applied to all Interfaces
	# [AXI4 ; AXI3] => the range of possible values is (12..64)
	# AXI4LITE => the range of possible values is (1..64)
	# 32 is the default value in every scenario
	# If the value is missing or is incorrect in the csv file,  default value is used
	value = int(property_value)
	if (property_value != ""):
		if ((config.PROTOCOL == "AXI4LITE") and (value in range(1, 65))):
			config.ADDR_WIDTH = value
		elif (((config.PROTOCOL == "AXI4") or (config.PROTOCOL == "AXI3")) and (value in range(12, 65))):
			config.ADDR_WIDTH = value
		else:
			logging.warning("Address Width value isn't compatible with AXI PROTOCOL Used. Using default value.")
	else:
		logging.warning("NoAddress Width value specified. Using default value.")
	return config

def read_DATA_WIDTH (
		config,
		property_name : str,
		property_value: str,
	):
	# Reads the Address Widdth applied to all Interfaces
	# [AXI4 ; AXI3] => the range of possible values is {32 ,  64 ,  128 ,  256 ,  512 ,  1024}
	# AXI4LITE => the range of possible values is {32 ,  64}
	# 32 is the default value in every scenario
	# If the value is missing or is incorrect in the csv file,  default value is used
	value = int(property_value)
	if (property_value != ""):
		DATA_WIDTH_Found = False
		Base_Data = 32
		while ((DATA_WIDTH_Found == False) and (Base_Data <= 1024)):
			if (value == Base_Data):
				DATA_WIDTH_Found = True
			Base_Data = Base_Data * 2
		if ((config.PROTOCOL == "AXI4LITE") and ((value == 32) or (value == 64))):
			config.DATA_WIDTH = value
		elif (((config.PROTOCOL == "AXI4") or (config.PROTOCOL == "AXI3")) and (DATA_WIDTH_Found == True)):
			config.DATA_WIDTH = value
		else:
			logging.warning("Data Width value isn't compatible with AXI PROTOCOL Used. Using default value.")
	else:
		logging.warning("NoData Width value specified. Using default value.")
	return config

def read_IDWidth_UsersWidth_AddrRanges (
		config,
		property_name : str,
		property_value: str,
	    lower_bound   : int,
		higher_bound  : int,
    ):
	# Reads the Data Width applied to all Master Interfacess
	# The range of possible values is [4 ; 32] whith 4 as deafault value

	# Reads User Widths used by each Interface (the AXI PROTOCOL Signals)
	# The range of possible values is [0 ; 1024] whith 0 as deafault value

	# Reads the number of Address Ranges applaied to all Master Interfaces
	# The range of possible values is (1..16) whith 1 as deafault value

	# If the values are missing or are incorrect in the csv file,  default value is used
	value = int(property_value)
	if (property_value != ""):
		if (value in range(lower_bound, higher_bound+1)):
			match property_name :
				case "ID_WIDTH":
					config.ID_WIDTH = value
				case "AWUSER_WIDTH":
					config.AWUSER_WIDTH = value
				case "ARUSER_WIDTH":
					config.ARUSER_WIDTH = value
				case "WUSER_WIDTH":
					config.WUSER_WIDTH = value
				case "RUSER_WIDTH":
					config.RUSER_WIDTH = value
				case "BUSER_WIDTH":
					config.BUSER_WIDTH = value
				case "ADDR_RANGES":
					config.ADDR_RANGES = value
		else:
			logging.warning(property_name  + " value out-of-range [" + str(lower_bound) + " ; " + str(higher_bound) + "]. Using default value.")
	else:
		logging.info("No" + property_name  + " value specified. Using default value.")
	return config

def read_CONNECTIVITY_MODE (
		config,
		property_name : str,
		property_value: str,
	):
	# Reads the Connectivity Mode
	# The two possible values are SAMD and SASD
	# [configuration STRATEGY = 1 or R_REGISTER = 1] => SASD
	# [configuration STRATEGY = 2] => SAMD
	# If the value is missing or is incorrect in the csv file,  default or coherent value is used
	if ((config.STRATEGY == 1) or (config.R_REGISTER == 1)):
		config.CONNECTIVITY_MODE = "SASD"
		logging.warning("configuration STRATEGY or R_REGISTER set to 1. By default Connectivity Mode is SASD. input ignored.")
	elif (config.STRATEGY == 2):
		config.CONNECTIVITY_MODE = "SAMD"
		logging.warning("configuration STRATEGY set to 2. By default Connectivity Mode is SAMD. input ignored.")
	else:
		if (property_value != ""):
			if ((property_value == "SASD") or (property_value == "SAMD")):
				config.CONNECTIVITY_MODE = property_value
			else:
				logging.warning("Connectivity Mode invalid. Using default value (SASD).")
		else:
			logging.warning("Connectivity Mode invalid. Using default value (SASD).")
	return config

def read_Slave_Priority (
		config,
		property_name : str,
		property_value: str,
	):
	# Reads every Slave Interface Priority
	# The range of possible values is (0..16) whith 0 (Round-Robin) as deafault value
	# If the values are missing or are incorrect in the csv file,  default value is used (input validity check is done for the single Slave)
	values = []
	if (property_value != ""):
		values = property_value.split()
	if ((len(values) == config.NUM_SI) and (property_value != "")):
		for i in range(config.NUM_SI):
			number = int(values[i])
			if (number in range(0, 17)):
				config.Slave_Priorities.append(number)
			else:
				config.Slave_Priorities.append(0)
				if (i < 10):
					logging.warning("A Priority value is out-of-range (0..16). Using default value for this Slave." + " - S0" + str(i))
				else:
					logging.warning("A Priority value is out-of-range (0..16). Using default value for this Slave." + " - S" + str(i))
	else:
		for i in range(config.NUM_SI):
			config.Slave_Priorities.append(0)
		logging.warning("Not enough Priority values have been given. Using default values.")
	return config

def read_Acceptance (
		config,
		property_name : str,
		property_value: str,
	):
	# Reads the number of Active Read or Write Transactions that each Slave Interface can generate
	# The range of possible values is (1..32) whith 2 as deafault value
	# SASD => 1
	# If the value is missing or is incorrect in the csv file,  default or coherent value is used (input validity check is done for the single Slave)
	values = []
	if (property_value != ""):
		values = property_value.split()
	if (config.CONNECTIVITY_MODE == "SASD"):
		for i in range(config.NUM_SI):
			match property_name :
				case "SI_Read_Acceptance":
					config.SI_Read_Acceptance.append(1)
				case "SI_Write_Acceptance":
					config.SI_Write_Acceptance.append(1)
		logging.warning("Connectivity Mode set to SASD. By default every " + property_name  + " value is set to 1. input Ignored.")
	elif ((len(values) == config.NUM_SI) and (property_value != "")):
		for i in range(config.NUM_SI):
			number = int(values[i])
			if (number in range(1, 33)):
				match property_name :
					case "SI_Read_Acceptance":
						config.SI_Read_Acceptance.append(number)
					case "SI_Write_Acceptance":
						config.SI_Write_Acceptance.append(number)
			else:
				match property_name :
					case "SI_Read_Acceptance":
						config.SI_Read_Acceptance.append(2)
					case "SI_Write_Acceptance":
						config.SI_Write_Acceptance.append(2)
				if (i < 10):
					logging.warning("A " + property_name  + " value is out-of-range (1..32). Using default value for this Slave." + " - S0" + str(i))
				else:
					logging.warning("A " + property_name  + " value is out-of-range (1..32). Using default value for this Slave." + " - S" + str(i))
	else:
		for i in range(config.NUM_SI):
				match property_name :
					case "SI_Read_Acceptance":
						config.SI_Read_Acceptance.append(2)
					case "SI_Write_Acceptance":
						config.SI_Write_Acceptance.append(2)
		logging.warning("Not enough " + property_name  + " values have been given. Using default values.")
	return config

def read_Thread_ID_WIDTH (
		config,
		property_name : str,
		property_value: str,
	):
	# Reads the number of ID bits used by each Slave Interface for its Thread IDs
	# For the moment whe don't use the and these numbers are set to 0,  the default value (input validity check is done for the single Slave)
	values = []
	if (property_value != ""):
		values = property_value.split()
	Bits_Available = math.floor(config.ID_WIDTH - math.log2(config.NUM_SI))
	if (Bits_Available < 0):
		Bits_Available = 0
	Bits_Available = 0 # At the moment we don't need them
	if (Bits_Available == 0):
		for i in range(config.NUM_SI):
			config.Thread_ID_WIDTH.append(0)
		logging.info("There are no bits available for Thread IDs. Setting all values to 0")
	elif ((len(values) == config.NUM_SI) and (property_value != "")):
		for i in range(config.NUM_SI):
			number = int(values[i])
			if (number in range(1, Bits_Available+1)):
				config.Thread_ID_WIDTH.append(number)
			else:
				config.Thread_ID_WIDTH.append(0)
				if (i < 10):
					logging.warning("A Thread ID value is out-of-range [0 ; Bits_Available]. Using default value for this Slave." + " - S0" + str(i))
				else:
					logging.warning("A Thread ID value is out-of-range [0 ; Bits_Available]. Using default value for this Slave." + " - S" + str(i))
	else:
		for i in range(config.NUM_SI):
			config.Thread_ID_WIDTH.append(0)
		logging.warning("Not enough Thread IDs values have been given. Using default values.")
	return config

def read_Single_Thread (
		config,
		property_name : str,
		property_value: str,
	):
	# Reads the Silngle Thread Mode option for each Slave Interface
	# The range of possible values is (0, 1) whith 0 as deafault value
	# 0 => Multiple Threads
	# 1 => Single Thread
	# If the value is missing or is incorrect in the csv file,  default value is used (input validity check is done for the single Slave)
	values = []
	if (property_value != ""):
		values = property_value.split()
	if ((len(values) == config.NUM_SI) and (property_value != "")):
		for i in range(config.NUM_SI):
			number = int(values[i])
			if (number in range(0, 2)):
				config.Single_Thread.append(number)
			else:
				config.Single_Thread.append(0)
				if (i < 10):
					logging.warning("A Single Thread value is out-of-range (0, 1). Using default value for this Slave." + " - S0" + str(i))
				else:
					logging.warning("A Single Thread value is out-of-range (0, 1). Using default value for this Slave." + " - S" + str(i))
	else:
		for i in range(config.NUM_SI):
			config.Single_Thread.append(0)
		logging.warning("Not enough Single Thread values have been given. Using default values.")
	return config

def read_Base_ID (
		config,
		property_name : str,
		property_value: str,
	):
	# Reads the 32 bit Base ID value for each Slave Interface
	# The range of possible values is [0x00000000 ; 0xffffffff] whith 0x00000000 as deafault value
	# If the value is missing or is incorrect in the csv file,  default value is used
	# It also check input format validity
	values = []
	if (property_value != ""):
		values = property_value.split()
	Correct_Format = True
	if ((len(values) != config.NUM_SI) or (property_value == "")):
		Correct_Format = False
	for i in range(config.NUM_SI):
		if (Correct_Format == False):
			break
		if ((len(values[i]) != 10) or (values[i][0] != "0") or (values[i][1] != "x")):
			Correct_Format = False
			break
		for j in range(8):
			if ((ord(values[i][j+2]) in range(48, 58)) or (ord(values[i][j+2]) in range (97, 103))):
				continue
			else:
				Correct_Format = False
				break
	if ((len(values) == config.NUM_SI) and (property_value != "") and (Correct_Format == True)):
		for i in range(config.NUM_SI):
			config.Base_ID.append(values[i])
	else:
		for i in range(config.NUM_SI):
			config.Base_ID.append("0x00000000")
		logging.warning("Not enough correct Base IDs values have been given. Using default values.")
	return config

def read_Issuing (
		config,
		property_name : str,
		property_value: str,
	):
	# Reads the number of Active Read or Write Transactions that each Master Interface can generate
	# The range of possible values is (1..32) whith 4 as deafault value
	# [AXI4LITE ; AXI3] => 1
	# If the value is missing or is incorrect in the csv file,  default or coherent value is used (input validity check is done for the single Master)
	values = []
	if (property_value != ""):
		values = property_value.split()
	if ((config.PROTOCOL == "AXI3") or (config.PROTOCOL == "AXI4LITE")):
		for i in range(config.NUM_MI):
			match property_name :
				case "MI_Read_Issuing":
					config.MI_Read_Issuing.append(1)
				case "MI_Write_Issuing":
					config.MI_Write_Issuing.append(1)
		logging.warning("PROTOCOL is set to " + config.PROTOCOL + ". By default every value is set to 1. input Ignored.")
	elif ((len(values) == config.NUM_MI) and (property_value != "")):
		for i in range(config.NUM_MI):
			number = int(values[i])
			if (number in range(1, 33)):
				match property_name :
					case "MI_Read_Issuing":
						config.MI_Read_Issuing.append(number)
					case "MI_Write_Issuing":
						config.MI_Write_Issuing.append(number)
			else:
				match property_name :
					case "MI_Read_Issuing":
						config.MI_Read_Issuing.append(4)
					case "MI_Write_Issuing":
						config.MI_Write_Issuing.append(4)
				if (i < 10):
					logging.warning("An " + property_name  + " value is out-of-range (1..32). Using default value for this Master." + " - M0" + str(i))
				else:
					logging.warning("An " + property_name  + " value is out-of-range (1..32). Using default value for this Master." + " - M" + str(i))
	else:
		for i in range(config.NUM_MI):
			match property_name :
				case "MI_Read_Issuing":
					config.MI_Read_Issuing.append(4)
				case "MI_Write_Issuing":
					config.MI_Write_Issuing.append(4)
		logging.warning("Not enough correct " + property_name  + " values have been given. Using default values.")
	return config

def read_Secure(
		config,
		property_name : str,
		property_value: str,
	):
	# Reads the TrustZone Activation option for each Master Interface
	# The range of possible values is (0, 1) whith 0 as deafault value
	# 0 => Non Secure
	# 1 => Secure
	# If the value is missing or is incorrect in the csv file,  default value is used (input validity check is done for the single Master)
	values = []
	if (property_value != ""):
		values = property_value.split()
	if ((len(values) == config.NUM_MI) and (property_value != "")):
		for i in range(config.NUM_MI):
			number = int(values[i])
			if (number in range(0, 2)):
				config.Secure.append(number)
			else:
				config.Secure.append(0)
				if (i < 10):
					logging.warning("A Secure value is out-of-range (0, 1). Using default value for this Master." + " - M0" + str(i))
				else:
					logging.warning("A Secure value is out-of-range (0, 1). Using default value for this Master." + " - M" + str(i))
	else:
		for i in range(config.NUM_MI):
			config.Secure.append(0)
		logging.warning("Not enough correct Secure values have been given. Using default values.")
	return config

def read_RANGE_BASE_ADDR (
		config,
		property_name : str,
		property_value: str,
	):
	# Reads every 64 bit Range Base Address for each Master Interface
	# The range of possible values is [0x0000000000000000 ; 0xffffffffffffffff] whith 0xffffffffffffffff (not used) as deafault value (0x0000000000100000 for the first Range of every Master)
	# If the value is missing or is incorrect in the csv file,  default value is used
	# It also check input format validity
	values = []
	if (property_value != ""):
		values = property_value.split()
	Correct_Format = True
	if ((len(values) != config.NUM_MI*config.ADDR_RANGES) or (property_value == "")):
		Correct_Format = False
	for i in range(config.NUM_MI*config.ADDR_RANGES):
		if (Correct_Format == False):
			break
		if ((len(values[i]) != 18) or (values[i][0] != "0") or (values[i][1] != "x")):
			Correct_Format = False
			break
		for j in range(16):
			if ((ord(values[i][j+2]) in range(48, 58)) or (ord(values[i][j+2]) in range (97, 103))):
				continue
			else:
				Correct_Format = False
				break
	if ((len(values) == config.NUM_MI*config.ADDR_RANGES) and (property_value != "") and (Correct_Format == True)):
		for i in range(config.NUM_MI):
			for j in range(config.ADDR_RANGES):
				config.BASE_ADDR.append(values[config.ADDR_RANGES*i+j])
	else:
		for i in range(config.NUM_MI):
			for j in range(config.ADDR_RANGES):
				if (j == 0):
					config.BASE_ADDR.append("0x0000000000100000")
				else:
					config.BASE_ADDR.append("0xffffffffffffffff")
		logging.warning("Not enough correct Ranges' Base Adress values have been given. Using default values.")
	return config

def read_RANGE_ADDR_WIDTH (
		config,
		property_name : str,
		property_value: str,
	):
	# Reads every Range Address Width for each Master Interface. It must be inferior to the global Address Width
	# [AXI4 ; AXI3] => the range of possible values is (12..64) whith 0 as deafault value (12 for the first Range of every Master)
	# AXI4LITE => the range of possible values is (1..64) whith 0 as deafault value (12 for the first Range of every Master)
	# If the value is missing or is incorrect in the csv file,  default or coherent value is used (input validity check is done for the single Master)
	values = []
	if (property_value != ""):
		values = property_value.split()
	if ((len(values) == config.NUM_MI*config.ADDR_RANGES) and (property_value != "")):
		if (config.PROTOCOL == "AXI4LITE"):
			for i in range(config.NUM_MI):
				for j in range(config.ADDR_RANGES):
					number = int(values[config.ADDR_RANGES*i+j])
					if ((number in range(1, 65)) and (number <= config.ADDR_WIDTH)):
						config.RANGE_ADDR_WIDTH.append(number)
					elif (j == 0):
						config.RANGE_ADDR_WIDTH.append(12)
						if (i < 10):
							logging.warning("A RANGE_ADDR_WIDTH value is out-of-range (1..64) or greater than global Address Width. Using default value for this Master." + " - M0" + str(i) + ",  Range " + str(j))
						else:
							logging.warning("A RANGE_ADDR_WIDTH value is out-of-range (1..64) or greater than global Address Width. Using default value for this Master." + " - M" + str(i) + ",  Range " + str(j))
					else:
						config.RANGE_ADDR_WIDTH.append(0)
						if (i < 10):
							logging.warning("A RANGE_ADDR_WIDTH value is out-of-range (1..64) or greater than global Address Width. Using default value for this Master." + " - M0" + str(i) + ",  Range " + str(j))
						else:
							logging.warning("A RANGE_ADDR_WIDTH value is out-of-range (1..64) or greater than global Address Width. Using default value for this Master." + " - M" + str(i) + ",  Range " + str(j))
		else:
			for i in range(config.NUM_MI):
				for j in range(config.ADDR_RANGES):
					number = int(values[config.ADDR_RANGES*i+j])
					if ((number in range(12, 65)) and (number <= config.ADDR_WIDTH)):
						config.RANGE_ADDR_WIDTH.append(number)
					elif (j == 0):
						config.RANGE_ADDR_WIDTH.append(12)
						if (i < 10):
							logging.warning("A RANGE_ADDR_WIDTH value is out-of-range (12..64) or greater than global Address Width. Using default value for this Master." + " - M0" + str(i) + ",  Range " + str(j))
						else:
							logging.warning("A RANGE_ADDR_WIDTH value is out-of-range (12..64) or greater than global Address Width. Using default value for this Master." + " - M" + str(i) + ",  Range " + str(j))
					else:
						config.RANGE_ADDR_WIDTH.append(0)
						if (i < 10):
							logging.warning("A RANGE_ADDR_WIDTH value is out-of-range (12..64) or greater than global Address Width. Using default value for this Master." + " - M0" + str(i) + ",  Range " + str(j))
						else:
							logging.warning("A RANGE_ADDR_WIDTH value is out-of-range (12..64) or greater than global Address Width. Using default value for this Master." + " - M" + str(i) + ",  Range " + str(j))
	else:
		for i in range(config.NUM_MI):
			for j in range(config.ADDR_RANGES):
					if (j == 0):
						config.RANGE_ADDR_WIDTH.append(12)
					else:
						config.RANGE_ADDR_WIDTH.append(0)
		logging.warning("Not enough correct Range Width values have been given. Using default values.")
	return config

def read_Connectivity (
		config,
		property_name : str,
		property_value: str,
	):
	# Reads the Activation option for each Master-Slave Connectione for Read or Write Transactions
	# The range of possible values is (0, 1) whith 1 as deafault value
	# 0 => Connection Activated
	# 1 => Connection Deactivated
	# If the value is missing or is incorrect in the csv file,  default value is used (input validity check is done for the single Connection)
	values = []
	if (property_value != ""):
		values = property_value.split()
	if ((len(values) == config.NUM_MI*config.NUM_SI) and (property_value != "")):
		for i in range(config.NUM_MI):
			for j in range(config.NUM_SI):
				number = int(values[config.NUM_SI*i+j])
				if (number in range(0, 2)):
					match property_name :
						case "Read_Connectivity":
							config.Read_Connectivity.append(number)
						case "Write_Connectivity":
							config.Write_Connectivity.append(number)
				else:
					match property_name :
						case "Read_Connectivity":
							config.Read_Connectivity.append(1)
						case "Write_Connectivity":
							config.Write_Connectivity.append(1)
					index = ""
					if (i < 10):
						index = " - M0" + str(i)
					else:
						index = " - M" + str(i)
					if (j < 10):
						index = index + "S0" + str(j)
					else:
						index = index + "S" + str(j)
					logging.warning("A " + property_name  + " value is out-of-range (0, 1). Using default value for this Master and Slave." + index)
	else:
		for i in range(config.NUM_MI):
			for j in range(config.NUM_SI):
				match property_name :
					case "Read_Connectivity":
						config.Read_Connectivity.append(1)
					case "Write_Connectivity":
						config.Write_Connectivity.append(1)
		logging.warning("Not enough correct " + property_name  + " values have been given. Using default values.")
	return config
