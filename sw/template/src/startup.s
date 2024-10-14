# Copyright lowRISC contributors.
# Licensed under the Apache License, Version 2.0, see LICENSE for details.
# SPDX-License-Identifier: Apache-2.0
#include "demo_system_regs.h"

.section .text

test_loop:
  li	x4, 0x3340006f
  #bne	x2, x3, sleep_loop
  ###
fin:
  li	x3, 0xffffffff
  sw	x3, 0(x0)
  lw	x2, 0(x0)
  bne	x3, x2, wrong_loop
  #bne   x2, x4, wrong_loop
 
ok_loop:
  j	ok_loop

sleep_loop:
  j sleep_loop
  
wrong_loop:
  j wrong_loop

reset_handler:

  /* set all registers to zero */
  mv  x1, x0
  mv  x2, x1
  mv  x3, x1
  mv  x4, x1
  mv  x5, x1
  mv  x6, x1
  mv  x7, x1
  mv  x8, x1
  mv  x9, x1
  mv x10, x1
  mv x11, x1
  mv x12, x1
  mv x13, x1
  mv x14, x1
  mv x15, x1
  mv x16, x1
  mv x17, x1
  mv x18, x1
  mv x19, x1
  mv x20, x1
  mv x21, x1
  mv x22, x1
  mv x23, x1
  mv x24, x1
  mv x25, x1
  mv x26, x1
  mv x27, x1
  mv x28, x1
  mv x29, x1
  mv x30, x1
  mv x31, x1
  
  #li	x5, 0x001000ff
  #li	x4, 0xffffffff
  #sw	x4, 0(x5)
  #li	x6, 0x1080006f
  
  #lw	x2, 0(x0)
  #bne 	x2, x0, test_loop
  #j default_exc_handler

  /* stack initilization */
  la   sp, _stack_start
  #sw   x5, 0(x0)
  #lw   x4, 0(x0)
  #bne  x5, x4, wrong_loop
  #j ok_loop
_start:
  .global _start

  /* clear BSS */
  la x26, _bss_start
  la x27, _bss_end

  bge x26, x27, zero_loop_end

zero_loop:
  sw x0, 0(x26)
  addi x26, x26, 4
  ble x26, x27, zero_loop
zero_loop_end:

/* jump to main program entry point (argc = argv = 0) */
  addi x10, x0, 0
  addi x11, x0, 0

  jal x1, main

default_exc_handler:
  j default_exc_handler

/* =================================================== [ exceptions ] === */
/* This section has to be down here, since we have to disable rvc for it  */

  .section .isr_vector, "ax"
  .option norvc;

  /* All unimplemented interrupts/exceptions go to the default_exc_handler. */
  # Two reset handler jumps to work both in simulation and in syntesis. However the first one is not required in synthesis and can be replaced
  .org 0x00
  jal x0, reset_handler      
  jal x0, default_exc_handler   
  .rept 30
  jal x0, default_exc_handler
  .endr
  jal x0, reset_handler         
