// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2024.2 (64-bit)
// Tool Version Limit: 2024.11
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
#ifndef XKRNL_VMUL_H
#define XKRNL_VMUL_H

#ifdef __cplusplus
extern "C" {
#endif

/***************************** Include Files *********************************/
#ifndef __linux__
#include "xil_types.h"
#include "xil_assert.h"
#include "xstatus.h"
#include "xil_io.h"
#else
#include <stdint.h>
#include <assert.h>
#include <dirent.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <unistd.h>
#include <stddef.h>
#endif
#include "xkrnl_vmul_hw.h"

/**************************** Type Definitions ******************************/
#ifdef __linux__
typedef uint8_t u8;
typedef uint16_t u16;
typedef uint32_t u32;
typedef uint64_t u64;
#else
typedef struct {
#ifdef SDT
    char *Name;
#else
    u16 DeviceId;
#endif
    u64 Control_BaseAddress;
} XKrnl_vmul_Config;
#endif

typedef struct {
    u64 Control_BaseAddress;
    u32 IsReady;
} XKrnl_vmul;

typedef u32 word_type;

/***************** Macros (Inline Functions) Definitions *********************/
#ifndef __linux__
#define XKrnl_vmul_WriteReg(BaseAddress, RegOffset, Data) \
    Xil_Out32((BaseAddress) + (RegOffset), (u32)(Data))
#define XKrnl_vmul_ReadReg(BaseAddress, RegOffset) \
    Xil_In32((BaseAddress) + (RegOffset))
#else
#define XKrnl_vmul_WriteReg(BaseAddress, RegOffset, Data) \
    *(volatile u32*)((BaseAddress) + (RegOffset)) = (u32)(Data)
#define XKrnl_vmul_ReadReg(BaseAddress, RegOffset) \
    *(volatile u32*)((BaseAddress) + (RegOffset))

#define Xil_AssertVoid(expr)    assert(expr)
#define Xil_AssertNonvoid(expr) assert(expr)

#define XST_SUCCESS             0
#define XST_DEVICE_NOT_FOUND    2
#define XST_OPEN_DEVICE_FAILED  3
#define XIL_COMPONENT_IS_READY  1
#endif

/************************** Function Prototypes *****************************/
#ifndef __linux__
#ifdef SDT
int XKrnl_vmul_Initialize(XKrnl_vmul *InstancePtr, UINTPTR BaseAddress);
XKrnl_vmul_Config* XKrnl_vmul_LookupConfig(UINTPTR BaseAddress);
#else
int XKrnl_vmul_Initialize(XKrnl_vmul *InstancePtr, u16 DeviceId);
XKrnl_vmul_Config* XKrnl_vmul_LookupConfig(u16 DeviceId);
#endif
int XKrnl_vmul_CfgInitialize(XKrnl_vmul *InstancePtr, XKrnl_vmul_Config *ConfigPtr);
#else
int XKrnl_vmul_Initialize(XKrnl_vmul *InstancePtr, const char* InstanceName);
int XKrnl_vmul_Release(XKrnl_vmul *InstancePtr);
#endif

void XKrnl_vmul_Start(XKrnl_vmul *InstancePtr);
u32 XKrnl_vmul_IsDone(XKrnl_vmul *InstancePtr);
u32 XKrnl_vmul_IsIdle(XKrnl_vmul *InstancePtr);
u32 XKrnl_vmul_IsReady(XKrnl_vmul *InstancePtr);
void XKrnl_vmul_Continue(XKrnl_vmul *InstancePtr);
void XKrnl_vmul_EnableAutoRestart(XKrnl_vmul *InstancePtr);
void XKrnl_vmul_DisableAutoRestart(XKrnl_vmul *InstancePtr);

void XKrnl_vmul_Set_A(XKrnl_vmul *InstancePtr, u64 Data);
u64 XKrnl_vmul_Get_A(XKrnl_vmul *InstancePtr);
void XKrnl_vmul_Set_B(XKrnl_vmul *InstancePtr, u64 Data);
u64 XKrnl_vmul_Get_B(XKrnl_vmul *InstancePtr);
void XKrnl_vmul_Set_out_r(XKrnl_vmul *InstancePtr, u64 Data);
u64 XKrnl_vmul_Get_out_r(XKrnl_vmul *InstancePtr);
void XKrnl_vmul_Set_size(XKrnl_vmul *InstancePtr, u32 Data);
u32 XKrnl_vmul_Get_size(XKrnl_vmul *InstancePtr);

void XKrnl_vmul_InterruptGlobalEnable(XKrnl_vmul *InstancePtr);
void XKrnl_vmul_InterruptGlobalDisable(XKrnl_vmul *InstancePtr);
void XKrnl_vmul_InterruptEnable(XKrnl_vmul *InstancePtr, u32 Mask);
void XKrnl_vmul_InterruptDisable(XKrnl_vmul *InstancePtr, u32 Mask);
void XKrnl_vmul_InterruptClear(XKrnl_vmul *InstancePtr, u32 Mask);
u32 XKrnl_vmul_InterruptGetEnabled(XKrnl_vmul *InstancePtr);
u32 XKrnl_vmul_InterruptGetStatus(XKrnl_vmul *InstancePtr);

#ifdef __cplusplus
}
#endif

#endif
