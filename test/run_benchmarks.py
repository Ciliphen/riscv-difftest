#!/usr/bin/env python3

import os

# build riscv-tests to this folder
BUILD_DIR = "./test/asm/riscv-test/benchmarks"
DST_DIR = "./test/bin/riscv-test"
TEST_PRIFIX = [
    "dhrystone",
    "median",
    "mm",
    "mt-matmul",
    "mt-vvadd",
    "multiply",
    "pmp",
    "qsort",
    "rsort",
    "spmv",
    "towers",
    "vvadd",
]
RISCV_PREFIX = "riscv64-unknown-linux-gnu-"

file_list = []
for dirpath, dirnames, filenames in os.walk(BUILD_DIR):
    for x in filenames:
        if x.endswith(".dump"):
            continue
        for y in TEST_PRIFIX:
            if x.startswith(y):
                file_list.append(x)
file_list.sort()


def run_all():
    for x in file_list:
        print("========================================")
        print("Testing {}: \n".format(x), end="", flush=True)
        os.system(
            "./obj_dir/Vtop {}/{}.bin -rvtest -perf".format(DST_DIR, x)
        )


run_all()
