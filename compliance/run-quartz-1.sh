#!/usr/bin/env bash

# SPDX-FileCopyrightText: © 2026 Sushant Mondal <sushant@renvatek.com>
#
# SPDX-License-Identifier: GPL-3.0-only

set -euo pipefail

# Constants
INSTR_ASM_FILE="imem_program"
DMEM_INIT_FILE="dmem_init"
COMPLIANCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ELF_DIR="$COMPLIANCE_DIR/tests"
PYTHON_BIN="$(cocotb-config --python-bin)"
PYTHON_LIB="$(cocotb-config --libpython)"
PYTHON_LIB_DIR="$(dirname "$PYTHON_LIB")"
SIM_BIN_FILE="$COMPLIANCE_DIR/bin/Vtop"

command -v awk >/dev/null || {
  echo "awk-not-found: awk is required."
  exit 1
}
command -v xxd >/dev/null || {
  echo "xxd-not-found: xxd is required."
  exit 1
}
while IFS= read -r -d '' ELF_FILE; do
  TMP_DIR="$(mktemp -d)"
  trap 'rm -rf "$TMP_DIR"' EXIT

  # imem
  riscv32-unknown-elf-objcopy -O binary \
    --only-section=.text.init --only-section=.text.rvtest --only-section=".text.rvtest.*" \
    --only-section=.text.rvmodel --only-section=".text.rvmodel.*" "$ELF_FILE" "$TMP_DIR"/temp.bin
  xxd -b -c 4 "$TMP_DIR"/temp.bin | awk '{print $5$4$3$2}' > "$TMP_DIR"/"$INSTR_ASM_FILE".bin

  # dmem
  riscv32-unknown-elf-objcopy -O verilog --only-section=.rodata --only-section=".rodata.*" \
    --only-section=.data --only-section=".data.*" --only-section=.bss --only-section=".bss.*" \
    "$ELF_FILE" "$TMP_DIR"/"$DMEM_INIT_FILE.hex"

  cd "$TMP_DIR"
  PYTHONPATH="$COMPLIANCE_DIR${PYTHONPATH:+:$PYTHONPATH}" \
    LD_LIBRARY_PATH="$PYTHON_LIB_DIR${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}" \
    LIBPYTHON_LOC="$PYTHON_LIB" PYGPI_PYTHON_BIN="$PYTHON_BIN" \
    COCOTB_TEST_MODULES=echo_ascii_chars "$SIM_BIN_FILE"
  rm -rf "$TMP_DIR"
  trap - EXIT
done < <(find "$ELF_DIR" -type f -name '*.elf' -print0)
exit 0
