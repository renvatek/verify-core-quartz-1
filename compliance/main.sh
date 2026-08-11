#!/usr/bin/env bash

# SPDX-FileCopyrightText: © 2026 Sushant Mondal <sushant@renvatek.com>
#
# SPDX-License-Identifier: GPL-3.0-only

set -euo pipefail

# Constants
COMPLIANCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TMP_DIR="$COMPLIANCE_DIR/tmp"
OBJCOPY="$COMPLIANCE_DIR/bin/riscv32-unknown-elf-objcopy"
ACT4_RUNNER_FILE="run-quartz-1.sh"
ACT4_PASSED_ASCII_FILE="act4_passed.txt"
ACT4_FAILED_ASCII_FILE="act4_failed.txt"

if [[ ! -x "$OBJCOPY" ]]; then
  echo "objcopy-invalid: Bundled riscv32-unknown-elf-objcopy is missing or not executable."
  exit 1
fi
cleanup() {
  deactivate 2>/dev/null || true
  rm -rf "$TMP_DIR"
}
trap cleanup EXIT
export PATH="$COMPLIANCE_DIR/bin:$PATH"

# Dependencies
mkdir -p "$TMP_DIR"
cd "$TMP_DIR"
export UV_UNMANAGED_INSTALL="$TMP_DIR/uv"
export UV_PYTHON_INSTALL_DIR="$TMP_DIR/python"
export UV_CACHE_DIR="$TMP_DIR/uv-cache"
curl -LsSf https://astral.sh/uv/install.sh | env UV_UNMANAGED_INSTALL="$TMP_DIR/uv" sh
export PATH="$TMP_DIR/uv:$PATH"
uv python install 3.13
uv venv --python 3.13 "$TMP_DIR/.venv"
source "$TMP_DIR/.venv/bin/activate"
uv pip install cocotb==2.0.1 cocotb-test==0.2.6 pytest==9.1.1

cd "$COMPLIANCE_DIR"
chmod +x ./"$ACT4_RUNNER_FILE"
if ./"$ACT4_RUNNER_FILE"; then
  printf '\033[32m'
  cat "$ACT4_PASSED_ASCII_FILE"
  printf '\033[0m'
  exit 0
else
  printf '\033[31m'
  cat "$ACT4_FAILED_ASCII_FILE"
  printf '\033[0m'
  exit 1
fi
