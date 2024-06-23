import random
import os

random.seed(0)

testnum = 2

MSTATUS_UIE = 0x00000001
MSTATUS_SIE = 0x00000002
MSTATUS_HIE = 0x00000004
MSTATUS_MIE = 0x00000008
MSTATUS_UPIE = 0x00000010
MSTATUS_SPIE = 0x00000020
MSTATUS_HPIE = 0x00000040
MSTATUS_MPIE = 0x00000080
MSTATUS_SPP = 0x00000100
MSTATUS_VS = 0x00000600
MSTATUS_MPP = 0x00001800
MSTATUS_FS = 0x00006000
MSTATUS_XS = 0x00018000
MSTATUS_MPRV = 0x00020000
MSTATUS_SUM = 0x00040000
MSTATUS_MXR = 0x00080000
MSTATUS_TVM = 0x00100000
MSTATUS_TW = 0x00200000
MSTATUS_TSR = 0x00400000
MSTATUS32_SD = 0x80000000
MSTATUS_UXL = 0x0000000300000000
MSTATUS_SXL = 0x0000000C00000000
MSTATUS64_SD = 0x8000000000000000

SSTATUS_UIE = 0x00000001
SSTATUS_SIE = 0x00000002
SSTATUS_UPIE = 0x00000010
SSTATUS_SPIE = 0x00000020
SSTATUS_SPP = 0x00000100
SSTATUS_VS = 0x00000600
SSTATUS_FS = 0x00006000
SSTATUS_XS = 0x00018000
SSTATUS_SUM = 0x00040000
SSTATUS_MXR = 0x00080000
SSTATUS32_SD = 0x80000000
SSTATUS_UXL = 0x0000000300000000
SSTATUS64_SD = 0x8000000000000000


def test_start():
    f.write(".text\n")
    f.write(".global _start\n")
    f.write("_start:\n")


def test_end():
    f.write("\tli x3, 1\n")
    f.write("\tli x17, 93\n")
    f.write("\tli x10, 0\n")
    f.write("\tecall\n")


def insert_nop(n):
    for i in range(n):
        f.write(f"\tnop\n")


def mask_xlen(x):
    return x & ((1 << 63 << 1) - 1)


def test_pass():
    # f.write(f"\tfence\n")
    f.write(f"\tli x3, 1\n")
    f.write(f"\tli x17, 93\n")
    f.write(f"\tli x10, 0\n")
    f.write(f"\tecall\n")


def test_fail():
    # f.write(f"\tfence\n")
    f.write(f"1:\tbeqz x3, 1b\n")
    f.write(f"\tsll x3, x3, 1\n")
    f.write(f"\tor x3, x3, 1\n")
    f.write(f"\tli x17, 93\n")
    f.write(f"\taddi x10, x3, 0\n")
    f.write(f"\tecall\n")


def test_case(testreg, correctval, code):
    global testnum
    f.write(f"test_{testnum}:\n")
    f.write(f"\tli x3, {testnum}\n")
    f.write(code)
    f.write(f"\tli x7, {mask_xlen(correctval)}\n")
    f.write(f"\tbne {testreg}, x7, fail\n")
    testnum += 1


def test_passfail():
    f.write(f"\tbne x0, x3, pass\n")
    f.write(f"fail:\n")
    test_fail()
    f.write(f"pass:\n")
    test_pass()


if not os.path.exists("build"):
    os.mkdir("build")
with open("./build/test.s".format(), "w") as f:
    test_start()

    test_case(
        "a0",
        0x2,
        "\tcsrr a0, misa\n\
    srl a0, a0, 62\n",
    )
    test_case("a0", 0x0, "\tcsrr a0, mhartid\n")  # test 3
    f.write(
        f"\tcsrr a0, mimpid\n\
    csrr a0, mimpid\n\
    csrr a0, marchid\n\
    csrr a0, mvendorid\n\
    li t0, 0\n\
    csrs mtvec, t0\n\
    csrs mepc, t0\n"
    )

    # ======================================
    # If running in M mode, use mstatus.MPP to check existence of U mode.
    f.write(
        f"li t0, {MSTATUS_MPP}\n\
    csrc mstatus, t0\n\
    csrr t1, mstatus\n\
    and t0, t0, t1\n\
    bnez t0, 1f\n"
    )

    # If U mode is present, UXL should be 2 (XLEN = 64-bit)
    test_case(
        "a0",
        SSTATUS_UXL & (SSTATUS_UXL << 1),
        f"\tcsrr a0, mstatus\n\
    li a1, {SSTATUS_UXL}\n\
    and a0, a0, a1\n",
    )

    f.write(f"\tj 2f\n\t1:\n")
    # If U mode is not present, UXL should be 0
    test_case(
        "a0",
        0,
        f"\tcsrr a0, mstatus\n\
    li a1, {SSTATUS_UXL}\n\
    and a0, a0, a1\n",
    )

    f.write(f"2:\n")

    # Make sure reading the cycle counter in four ways doesn't trap.
    test_case("x0", 0, "\tcsrrc  x0, cycle, x0\n")
    test_case("x0", 0, "\tcsrrs  x0, cycle, x0\n")
    test_case("x0", 0, "\tcsrrci x0, cycle, 0\n")
    test_case("x0", 0, "\tcsrrsi x0, cycle, 0\n")

    test_case("a0", 0, "\tcsrw mscratch, zero\n\tcsrr a0, mscratch\n")
    test_case("a0", 0, "\tcsrrwi a0, mscratch, 0\n\tcsrrwi a0, mscratch, 0xF\n")
    test_case("a0", 0x1F, "\tcsrrsi x0, mscratch, 0x10\n\tcsrr a0, mscratch\n")

    f.write("\tcsrwi mscratch, 3\n")
    test_case("a0", 3, "\tcsrr a0, mscratch\n")
    test_case("a1", 3, "\tcsrrci a1, mscratch, 1\n")
    test_case("a2", 2, "\tcsrrsi a2, mscratch, 4\n")
    test_case("a3", 6, "\tcsrrwi a3, mscratch, 2\n")
    test_case("a1", 2, "\tli a0, 0xbad1dea;csrrw a1, mscratch, a0\n")
    test_case("a1", 0xBAD1DEA, "\tli a0, 0x0001dea;csrrc a1, mscratch, a0\n")
    test_case("a1", 0xBAD0000, "\tli a0, 0x000beef;csrrs a1, mscratch, a0\n")
    test_case("a0", 0xBADBEEF, "\tli a0, 0xbad1dea;csrrw a0, mscratch, a0\n")
    test_case("a0", 0xBAD1DEA, "\tli a0, 0x0001dea;csrrc a0, mscratch, a0\n")
    test_case("a0", 0xBAD0000, "\tli a0, 0x000beef;csrrs a0, mscratch, a0\n")
    test_case("a0", 0xBADBEEF, "\tcsrr a0, mscratch\n")

    f.write(
        f"\tcsrr a0, misa\n\
    andi a0, a0, (1 << ('F' - 'A'))\n\
    beqz a0, 1f\n"
    )

    f.write(
        f"1:\n\
    # Figure out if 'U' is set in misa\n\
    csrr a0, misa   # a0 = csr(misa)\n\
    srli a0, a0, 20 # a0 = a0 >> 20\n\
    andi a0, a0, 1  # a0 = a0 & 1\n\
    beqz a0, finish # if no user mode, skip the rest of these checks\n\
    # Enable access to the cycle counter\n\
    csrwi mcounteren, 1\n\
    # Figure out if 'S' is set in misa\n\
    csrr a0, misa   # a0 = csr(misa)\n\
    srli a0, a0, 18 # a0 = a0 >> 20\n\
    andi a0, a0, 1  # a0 = a0 & 1\n\
    beqz a0, 1f\n\
    # Enable access to the cycle counter\n\
    csrwi scounteren, 1\n\
1:\n\
    # jump to user land\n\
    li t0, {SSTATUS_SPP}\n\
    csrc mstatus, t0\n\
    la t0, 1f\n\
    csrw mepc, t0\n\
    nop\n\
    1:\n\
    "
    )

    test_case("x0", 0, "\tnop\n")

    f.write("finish:\n")
    test_pass()
    test_passfail()

# 将生成的R型指令测试样例汇编成bin文件
os.system("riscv64-unknown-linux-gnu-as -o ./build/test.o ./build/test.s")
os.system(
    "riscv64-unknown-linux-gnu-ld -T ../config/linker.ld -o ./build/test ./build/test.o"
)
os.system("riscv64-unknown-linux-gnu-objcopy -O binary ./build/test ./build/test.bin")
os.system(
    "riscv64-unknown-linux-gnu-objdump -d -M no-aliases,numeric  ./build/test > ./build/test.asm"
)
os.system("rm -rf ../build")
os.system("mv ./build ../")
