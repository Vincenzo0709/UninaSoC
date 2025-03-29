// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2024.2 (64-bit)
// Tool Version Limit: 2024.11
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
#ifndef __linux__

#include "xstatus.h"
#ifdef SDT
#include "xparameters.h"
#endif
#include "xkrnl_vmul.h"

extern XKrnl_vmul_Config XKrnl_vmul_ConfigTable[];

#ifdef SDT
XKrnl_vmul_Config *XKrnl_vmul_LookupConfig(UINTPTR BaseAddress) {
	XKrnl_vmul_Config *ConfigPtr = NULL;

	int Index;

	for (Index = (u32)0x0; XKrnl_vmul_ConfigTable[Index].Name != NULL; Index++) {
		if (!BaseAddress || XKrnl_vmul_ConfigTable[Index].Control_BaseAddress == BaseAddress) {
			ConfigPtr = &XKrnl_vmul_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XKrnl_vmul_Initialize(XKrnl_vmul *InstancePtr, UINTPTR BaseAddress) {
	XKrnl_vmul_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XKrnl_vmul_LookupConfig(BaseAddress);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XKrnl_vmul_CfgInitialize(InstancePtr, ConfigPtr);
}
#else
XKrnl_vmul_Config *XKrnl_vmul_LookupConfig(u16 DeviceId) {
	XKrnl_vmul_Config *ConfigPtr = NULL;

	int Index;

	for (Index = 0; Index < XPAR_XKRNL_VMUL_NUM_INSTANCES; Index++) {
		if (XKrnl_vmul_ConfigTable[Index].DeviceId == DeviceId) {
			ConfigPtr = &XKrnl_vmul_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XKrnl_vmul_Initialize(XKrnl_vmul *InstancePtr, u16 DeviceId) {
	XKrnl_vmul_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XKrnl_vmul_LookupConfig(DeviceId);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XKrnl_vmul_CfgInitialize(InstancePtr, ConfigPtr);
}
#endif

#endif

