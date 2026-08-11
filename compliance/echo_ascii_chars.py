#!/usr/bin/env python3

# SPDX-FileCopyrightText: © 2026 Sushant Mondal <contact@sushantmondal.com>
#
# SPDX-License-Identifier: GPL-3.0-only
#
# Echo ASCII characters from the printer sentinel address to the stdout, character by character.
# Required by run_tests.py to validate if a test passed or failed.
# Refs: rvmodel_macros.h/RVMODEL_IO_WRITE_STR (IO)

from typing import Any

import cocotb
from cocotb.triggers import RisingEdge

# Refs: rvmodel_macros.h/RVMODEL_IO_WRITE_STR (IO)
PRINT_ADDR = 0x7F8

# Termination
# ===========
# Refs: rvmodel_macros.h/RVMODEL_HALT_PASS
# Refs: rvmodel_macros.h/RVMODEL_HALT_FAIL
SENTINEL_ADDR = 0x7FC


async def echo_ascii_chars(*, dut: Any) -> None:
    while True:
        await RisingEdge(dut.clk)
        rst_n: int = int(dut.rst_n.value)
        if rst_n:
            ctrl_dmem_we: int = int(dut.u_rv32i_sc.ctrl_dmem_we.value)
            if ctrl_dmem_we:

                # Address of dmem to be read from (dmem[alu_result]).
                alu_result: int = int(dut.u_rv32i_sc.alu_result.value)

                # What is being written to dmem[alu_result].
                lsu_wdata: int = int(dut.u_rv32i_sc.lsu_wdata.value)

                if alu_result == PRINT_ADDR:
                    char_byte: int = lsu_wdata & 0xFF
                    print(chr(char_byte), end="", flush=True)

                # Get out of this infinite loop. Use Sail's timeout feature or the MaxCycles param
                # in the DUT as a safety net.
                elif alu_result == SENTINEL_ADDR:
                    if lsu_wdata == 1:
                        pass
                    else:
                        raise AssertionError("compliance-failure: Compliance test failed.")
        return None


@cocotb.test()
async def main(dut: Any) -> None:
    await echo_ascii_chars(dut=dut)
    return None
