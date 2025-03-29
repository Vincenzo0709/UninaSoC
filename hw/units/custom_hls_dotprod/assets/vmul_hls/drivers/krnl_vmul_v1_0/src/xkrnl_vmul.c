// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2024.2 (64-bit)
// Tool Version Limit: 2024.11
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
/***************************** Include Files *********************************/
#include "xkrnl_vmul.h"

/************************** Function Implementation *************************/
#ifndef __linux__
int XKrnl_vmul_CfgInitialize(XKrnl_vmul *InstancePtr, XKrnl_vmul_Config *ConfigPtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(ConfigPtr != NULL);

    InstancePtr->Control_BaseAddress = ConfigPtr->Control_BaseAddress;
    InstancePtr->IsReady = XIL_COMPONENT_IS_READY;

    return XST_SUCCESS;
}
#endif

void XKrnl_vmul_Start(XKrnl_vmul *InstancePtr) {
    u32 Data;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XKrnl_vmul_ReadReg(InstancePtr->Control_BaseAddress, XKRNL_VMUL_CONTROL_ADDR_AP_CTRL) & 0x80;
    XKrnl_vmul_WriteReg(InstancePtr->Control_BaseAddress, XKRNL_VMUL_CONTROL_ADDR_AP_CTRL, Data | 0x01);
}

u32 XKrnl_vmul_IsDone(XKrnl_vmul *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XKrnl_vmul_ReadReg(InstancePtr->Control_BaseAddress, XKRNL_VMUL_CONTROL_ADDR_AP_CTRL);
    return (Data >> 1) & 0x1;
}

u32 XKrnl_vmul_IsIdle(XKrnl_vmul *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XKrnl_vmul_ReadReg(InstancePtr->Control_BaseAddress, XKRNL_VMUL_CONTROL_ADDR_AP_CTRL);
    return (Data >> 2) & 0x1;
}

u32 XKrnl_vmul_IsReady(XKrnl_vmul *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XKrnl_vmul_ReadReg(InstancePtr->Control_BaseAddress, XKRNL_VMUL_CONTROL_ADDR_AP_CTRL);
    // check ap_start to see if the pcore is ready for next input
    return !(Data & 0x1);
}

void XKrnl_vmul_Continue(XKrnl_vmul *InstancePtr) {
    u32 Data;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XKrnl_vmul_ReadReg(InstancePtr->Control_BaseAddress, XKRNL_VMUL_CONTROL_ADDR_AP_CTRL) & 0x80;
    XKrnl_vmul_WriteReg(InstancePtr->Control_BaseAddress, XKRNL_VMUL_CONTROL_ADDR_AP_CTRL, Data | 0x10);
}

void XKrnl_vmul_EnableAutoRestart(XKrnl_vmul *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XKrnl_vmul_WriteReg(InstancePtr->Control_BaseAddress, XKRNL_VMUL_CONTROL_ADDR_AP_CTRL, 0x80);
}

void XKrnl_vmul_DisableAutoRestart(XKrnl_vmul *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XKrnl_vmul_WriteReg(InstancePtr->Control_BaseAddress, XKRNL_VMUL_CONTROL_ADDR_AP_CTRL, 0);
}

void XKrnl_vmul_Set_A(XKrnl_vmul *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XKrnl_vmul_WriteReg(InstancePtr->Control_BaseAddress, XKRNL_VMUL_CONTROL_ADDR_A_DATA, (u32)(Data));
    XKrnl_vmul_WriteReg(InstancePtr->Control_BaseAddress, XKRNL_VMUL_CONTROL_ADDR_A_DATA + 4, (u32)(Data >> 32));
}

u64 XKrnl_vmul_Get_A(XKrnl_vmul *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XKrnl_vmul_ReadReg(InstancePtr->Control_BaseAddress, XKRNL_VMUL_CONTROL_ADDR_A_DATA);
    Data += (u64)XKrnl_vmul_ReadReg(InstancePtr->Control_BaseAddress, XKRNL_VMUL_CONTROL_ADDR_A_DATA + 4) << 32;
    return Data;
}

void XKrnl_vmul_Set_B(XKrnl_vmul *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XKrnl_vmul_WriteReg(InstancePtr->Control_BaseAddress, XKRNL_VMUL_CONTROL_ADDR_B_DATA, (u32)(Data));
    XKrnl_vmul_WriteReg(InstancePtr->Control_BaseAddress, XKRNL_VMUL_CONTROL_ADDR_B_DATA + 4, (u32)(Data >> 32));
}

u64 XKrnl_vmul_Get_B(XKrnl_vmul *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XKrnl_vmul_ReadReg(InstancePtr->Control_BaseAddress, XKRNL_VMUL_CONTROL_ADDR_B_DATA);
    Data += (u64)XKrnl_vmul_ReadReg(InstancePtr->Control_BaseAddress, XKRNL_VMUL_CONTROL_ADDR_B_DATA + 4) << 32;
    return Data;
}

void XKrnl_vmul_Set_out_r(XKrnl_vmul *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XKrnl_vmul_WriteReg(InstancePtr->Control_BaseAddress, XKRNL_VMUL_CONTROL_ADDR_OUT_R_DATA, (u32)(Data));
    XKrnl_vmul_WriteReg(InstancePtr->Control_BaseAddress, XKRNL_VMUL_CONTROL_ADDR_OUT_R_DATA + 4, (u32)(Data >> 32));
}

u64 XKrnl_vmul_Get_out_r(XKrnl_vmul *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XKrnl_vmul_ReadReg(InstancePtr->Control_BaseAddress, XKRNL_VMUL_CONTROL_ADDR_OUT_R_DATA);
    Data += (u64)XKrnl_vmul_ReadReg(InstancePtr->Control_BaseAddress, XKRNL_VMUL_CONTROL_ADDR_OUT_R_DATA + 4) << 32;
    return Data;
}

void XKrnl_vmul_Set_size(XKrnl_vmul *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XKrnl_vmul_WriteReg(InstancePtr->Control_BaseAddress, XKRNL_VMUL_CONTROL_ADDR_SIZE_DATA, Data);
}

u32 XKrnl_vmul_Get_size(XKrnl_vmul *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XKrnl_vmul_ReadReg(InstancePtr->Control_BaseAddress, XKRNL_VMUL_CONTROL_ADDR_SIZE_DATA);
    return Data;
}

void XKrnl_vmul_InterruptGlobalEnable(XKrnl_vmul *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XKrnl_vmul_WriteReg(InstancePtr->Control_BaseAddress, XKRNL_VMUL_CONTROL_ADDR_GIE, 1);
}

void XKrnl_vmul_InterruptGlobalDisable(XKrnl_vmul *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XKrnl_vmul_WriteReg(InstancePtr->Control_BaseAddress, XKRNL_VMUL_CONTROL_ADDR_GIE, 0);
}

void XKrnl_vmul_InterruptEnable(XKrnl_vmul *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XKrnl_vmul_ReadReg(InstancePtr->Control_BaseAddress, XKRNL_VMUL_CONTROL_ADDR_IER);
    XKrnl_vmul_WriteReg(InstancePtr->Control_BaseAddress, XKRNL_VMUL_CONTROL_ADDR_IER, Register | Mask);
}

void XKrnl_vmul_InterruptDisable(XKrnl_vmul *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XKrnl_vmul_ReadReg(InstancePtr->Control_BaseAddress, XKRNL_VMUL_CONTROL_ADDR_IER);
    XKrnl_vmul_WriteReg(InstancePtr->Control_BaseAddress, XKRNL_VMUL_CONTROL_ADDR_IER, Register & (~Mask));
}

void XKrnl_vmul_InterruptClear(XKrnl_vmul *InstancePtr, u32 Mask) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XKrnl_vmul_WriteReg(InstancePtr->Control_BaseAddress, XKRNL_VMUL_CONTROL_ADDR_ISR, Mask);
}

u32 XKrnl_vmul_InterruptGetEnabled(XKrnl_vmul *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XKrnl_vmul_ReadReg(InstancePtr->Control_BaseAddress, XKRNL_VMUL_CONTROL_ADDR_IER);
}

u32 XKrnl_vmul_InterruptGetStatus(XKrnl_vmul *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XKrnl_vmul_ReadReg(InstancePtr->Control_BaseAddress, XKRNL_VMUL_CONTROL_ADDR_ISR);
}

