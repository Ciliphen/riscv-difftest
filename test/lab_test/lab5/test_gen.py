import random
import os

random.seed(0)

testnum = 2


def test_start():
    f.write(".text\n")
    f.write(".global _start\n")
    f.write("_start:\n")


def test_end():
    f.write("\tli x3, 1\n")
    f.write("\tli x17, 93\n")
    f.write("\tli x10, 0\n")
    f.write("\tecall\n")


def test_br2_op_taken(inst, val1, val2):
    global testnum
    f.write(f"test_{testnum}:\n")
    f.write(f"\tli x3, {testnum}\n")
    if val1 == 0xFFFFFFFF:
        f.write(f"addiw x1, x0, 1\n")
        insert_nop(4)
        f.write(f"slli x1, x1, 0x20\n")
        insert_nop(4)
        f.write(f"addiw x1, x1, -1\n")
    elif val1 == 0xFFFFFFFE:
        f.write(f"addiw x1, x0, 1\n")
        insert_nop(4)
        f.write(f"slli x1, x1, 0x20\n")
        insert_nop(4)
        f.write(f"addiw x1, x1, -2\n")
    elif val1 == 0x7FFFFFFF:
        f.write(f"lui x1, 0x80000\n")
        insert_nop(4)
        f.write(f"addiw x1, x1, -1\n")
    elif val1 == 0x80000000:
        f.write(f"addiw x1, x0, 1\n")
        insert_nop(4)
        f.write(f"slli x1, x1, 0x1f\n")
    else:
        f.write(f"\tli x1, {val1}\n")
    if val2 == 0xFFFFFFFF:
        f.write(f"addiw x2, x0, 1\n")
        insert_nop(4)
        f.write(f"slli x2, x2, 0x20\n")
        insert_nop(4)
        f.write(f"addiw x2, x2, -1\n")
    elif val2 == 0xFFFFFFFE:
        f.write(f"addiw x2, x0, 1\n")
        insert_nop(4)
        f.write(f"slli x2, x2, 0x20\n")
        insert_nop(4)
        f.write(f"addiw x2, x2, -2\n")
    elif val2 == 0x7FFFFFFF:
        f.write(f"lui x2, 0x80000\n")
        insert_nop(4)
        f.write(f"addiw x2, x2, -1\n")
    elif val2 == 0x80000000:
        f.write(f"addiw x2, x0, 1\n")
        insert_nop(4)
        f.write(f"slli x2, x2, 0x1f\n")
    else:
        f.write(f"\tli x2, {val2}\n")
    insert_nop(4)
    f.write(f"\t{inst} x1, x2, 2f\n")
    insert_nop(2)
    f.write(f"\tbne x0, x3, fail\n")
    insert_nop(2)
    f.write(f"1:\tbne x0, x3, 3f\n")
    insert_nop(2)
    f.write(f"2:\t{inst} x1, x2, 1b\n")
    insert_nop(2)
    f.write(f"bne x0, x3, fail\n")
    insert_nop(2)
    f.write(f"3:\n")
    testnum += 1


def test_br2_op_nottaken(inst, val1, val2):
    global testnum
    f.write(f"test_{testnum}:\n")
    f.write(f"\tli x3, {testnum}\n")
    if val1 == 0xFFFFFFFF:
        f.write(f"addiw x1, x0, 1\n")
        insert_nop(4)
        f.write(f"slli x1, x1, 0x20\n")
        insert_nop(4)
        f.write(f"addiw x1, x1, -1\n")
    elif val1 == 0xFFFFFFFE:
        f.write(f"addiw x1, x0, 1\n")
        insert_nop(4)
        f.write(f"slli x1, x1, 0x20\n")
        insert_nop(4)
        f.write(f"addiw x1, x1, -2\n")
    elif val1 == 0x7FFFFFFF:
        f.write(f"lui x1, 0x80000\n")
        insert_nop(4)
        f.write(f"addiw x1, x1, -1\n")
    elif val1 == 0x80000000:
        f.write(f"addiw x1, x0, 1\n")
        insert_nop(4)
        f.write(f"slli x1, x1, 0x1f\n")
    else:
        f.write(f"\tli x1, {val1}\n")
    if val2 == 0xFFFFFFFF:
        f.write(f"addiw x2, x0, 1\n")
        insert_nop(4)
        f.write(f"slli x2, x2, 0x20\n")
        insert_nop(4)
        f.write(f"addiw x2, x2, -1\n")
    elif val2 == 0xFFFFFFFE:
        f.write(f"addiw x2, x0, 1\n")
        insert_nop(4)
        f.write(f"slli x2, x2, 0x20\n")
        insert_nop(4)
        f.write(f"addiw x2, x2, -2\n")
    elif val2 == 0x7FFFFFFF:
        f.write(f"lui x2, 0x80000\n")
        insert_nop(4)
        f.write(f"addiw x2, x2, -1\n")
    elif val2 == 0x80000000:
        f.write(f"addiw x2, x0, 1\n")
        insert_nop(4)
        f.write(f"slli x2, x2, 0x1f\n")
    else:
        f.write(f"\tli x2, {val2}\n")
    insert_nop(4)
    f.write(f"\t{inst} x1, x2, 1f\n")
    insert_nop(2)
    f.write(f"bne x0, x3, 2f\n")
    insert_nop(2)
    f.write(f"1:\tbne x0, x3, fail\n")
    insert_nop(2)
    f.write(f"2:\t{inst} x1, x2, 1b\n")
    insert_nop(2)
    f.write(f"3:\n")
    testnum += 1


def insert_nop(n):
    for i in range(n):
        f.write(f"\tnop\n")


def mask_xlen(x):
    return x & ((1 << 63 << 1) - 1)


def test_br2_src12_bypass(src1_nops, src2_nops, inst, val1, val2):
    f.write(f"test_{testnum}:\n")
    f.write(f"\tli x3, {testnum}\n")
    f.write(f"\tli x4, 0\n")
    f.write(f"1:\tli x1, {val1}\n")
    insert_nop(src1_nops)
    f.write(f"\tli x2, {val2}\n")
    insert_nop(src2_nops)
    f.write(f"\t{inst} x1, x2, fail\n")
    f.write(f"\taddi x4, x4, 1\n")
    f.write(f"\tli x5, 2\n")
    f.write(f"\tbne x4, x5, 1b\n")


def test_case(testreg, correctval, code):
    f.write(f"test_{testnum}:\n")
    f.write(f"\tli x3, {testnum}\n")
    f.write(code)
    f.write(f"\tli x7, {mask_xlen(correctval)}\n")
    f.write(f"\tbne {testreg}, x7, fail\n")
    insert_nop(2)


def test_pass():
    # f.write(f"\tfence\n")
    f.write(f"\tli x3, 1\n")
    f.write(f"\tli x17, 93\n")
    f.write(f"\tli x10, 0\n")
    f.write(f"\tecall\n")


def test_fail():
    # f.write(f"\tfence\n")
    f.write(f"1:\tbeqz x3, 1b\n")
    insert_nop(2)
    f.write(f"\tsll x3, x3, 1\n")
    insert_nop(4)
    f.write(f"\tor x3, x3, 1\n")
    f.write(f"\tli x17, 93\n")
    insert_nop(2)
    f.write(f"\taddi x10, x3, 0\n")
    f.write(f"\tecall\n")


def test_passfail():
    f.write(f"\tbne x0, x3, pass\n")
    insert_nop(2)
    f.write(f"fail:\n")
    test_fail()
    f.write(f"pass:\n")
    test_pass()


if not os.path.exists("build"):
    os.mkdir("build")
with open("./build/test.s".format(), "w") as f:
    test_start()
    # -------------------------------------------------------------
    # Branch tests
    # -------------------------------------------------------------

    # Each test checks both forward and backward branches

    test_br2_op_taken("beq", 0, 0)  # test 2
    test_br2_op_taken("beq", 1, 1)
    test_br2_op_taken("beq", -1, -1)
    test_br2_op_nottaken("beq", 0, 1)  # test 5
    test_br2_op_nottaken("beq", 1, 0)
    test_br2_op_nottaken("beq", -1, 1)
    test_br2_op_nottaken("beq", 1, -1)
    test_br2_op_taken("bge", 0, 0)
    test_br2_op_taken("bge", 1, 1)  # test 10
    test_br2_op_taken("bge", -1, -1)
    test_br2_op_taken("bge", 1, 0)
    test_br2_op_taken("bge", 1, -1)
    test_br2_op_taken("bge", -1, -2)
    test_br2_op_nottaken("bge", 0, 1)  # test 15
    test_br2_op_nottaken("bge", -1, 1)
    test_br2_op_nottaken("bge", -2, -1)
    test_br2_op_nottaken("bge", -2, 1)
    test_br2_op_taken("bgeu", 0x00000000, 0x00000000)
    test_br2_op_taken("bgeu", 0x00000001, 0x00000001)  # test 20
    test_br2_op_taken("bgeu", 0xFFFFFFFF, 0xFFFFFFFF)  # test 21
    test_br2_op_taken("bgeu", 0x00000001, 0x00000000)
    test_br2_op_taken("bgeu", 0xFFFFFFFF, 0xFFFFFFFE)  # test 23
    test_br2_op_taken("bgeu", 0xFFFFFFFF, 0x00000000)
    test_br2_op_nottaken("bgeu", 0x00000000, 0x00000001)  # test 25
    test_br2_op_nottaken("bgeu", 0xFFFFFFFE, 0xFFFFFFFF)  # test 26
    test_br2_op_nottaken("bgeu", 0x00000000, 0xFFFFFFFF)
    test_br2_op_nottaken("bgeu", 0x7FFFFFFF, 0x80000000)  # test 28
    test_br2_op_taken("blt", 0, 1)
    test_br2_op_taken("blt", -1, 1)  # test 30
    test_br2_op_taken("blt", -2, -1)
    test_br2_op_nottaken("blt", 1, 0)
    test_br2_op_nottaken("blt", 1, -1)
    test_br2_op_nottaken("blt", -1, -2)
    test_br2_op_nottaken("blt", 1, -2)  # test 35
    test_br2_op_taken("bltu", 0x00000000, 0x00000001)
    test_br2_op_taken("bltu", 0xFFFFFFFE, 0xFFFFFFFF)
    test_br2_op_taken("bltu", 0x00000000, 0xFFFFFFFF)
    test_br2_op_nottaken("bltu", 0x00000001, 0x00000000)
    test_br2_op_nottaken("bltu", 0xFFFFFFFF, 0xFFFFFFFE)  # test 40
    test_br2_op_nottaken("bltu", 0xFFFFFFFF, 0x00000000)
    test_br2_op_nottaken("bltu", 0x80000000, 0x7FFFFFFF)
    test_br2_op_taken("bne", 0, 1)
    test_br2_op_taken("bne", 1, 0)
    test_br2_op_taken("bne", -1, 1)  # test 45
    test_br2_op_taken("bne", 1, -1)
    test_br2_op_nottaken("bne", 0, 0)
    test_br2_op_nottaken("bne", 1, 1)
    test_br2_op_nottaken("bne", -1, -1)

    # -------------------------------------------------------------
    # jal tests
    # -------------------------------------------------------------
    f.write(f"test_{testnum}:\n")  # test 50
    f.write(f"\tli x3, {testnum}\n")
    f.write(f"\tli ra, 0\n")
    f.write(f"\tjal x4, target_{testnum}\n")
    f.write(f"linkaddr_{testnum}:\n")
    insert_nop(2)
    f.write(f"\tj fail\n")
    insert_nop(2)
    f.write(f"target_{testnum}:\n")
    # f.write(f"\tla x2, linkaddr_{testnum}\n")
    f.write(f"\tauipc x2, 0x0\n")
    insert_nop(4)
    f.write(f"\taddi x2, x2, -20\n")
    insert_nop(4)
    f.write(f"\tbne x2, x4, fail\n")
    insert_nop(2)
    testnum += 1

    # -------------------------------------------------------------
    # jalr tests
    # -------------------------------------------------------------
    f.write(f"test_{testnum}:\n")  # test 51
    f.write(f"\tli x3, {testnum}\n")
    f.write(f"\tli t0, 0\n")
    # f.write(f"\tla t1, target_{testnum}\n")
    f.write(f"\tauipc x6, 0x0\n")
    insert_nop(4)
    f.write(f"\taddi x6, x6, 64\n")
    insert_nop(4)
    f.write(f"\tjalr t0, t1, 0\n")
    f.write(f"linkaddr_{testnum}:\n")
    insert_nop(2)
    f.write(f"\tj fail\n")
    insert_nop(2)
    f.write(f"target_{testnum}:\n")
    f.write(f"\tla t1, linkaddr_{testnum}\n")
    insert_nop(4)
    f.write(f"\tbne t0, t1, fail\n")
    insert_nop(2)
    testnum += 1

    f.write(f"test_{testnum}:\n") # test 52
    f.write(f"\tli x3, {testnum}\n")
    # f.write(f"\tla t0, target_{testnum}\n")
    f.write(f"\tauipc x5, 0x0\n")
    insert_nop(4)
    f.write(f"\taddi x5, x5, 64\n")
    insert_nop(4)
    f.write(f"\tjalr t0, t0, 0\n")
    f.write(f"linkaddr_{testnum}:\n")
    insert_nop(2)
    f.write(f"\tj fail\n")
    insert_nop(2)
    f.write(f"target_{testnum}:\n")
    # f.write(f"\tla t1, linkaddr_{testnum}\n")
    f.write(f"\tauipc x6, 0x0\n")
    insert_nop(4)
    f.write(f"\taddi x6, x6, -20\n")
    insert_nop(4)
    f.write(f"\tbne t0, t1, fail\n")
    insert_nop(2)

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
