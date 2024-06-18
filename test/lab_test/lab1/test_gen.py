import random
import os

random.seed(0)

reg = [f"x{i}" for i in range(32)]
# 定义R型运算类指令
inst_add = ["add", "sub", "xor", "or", "and", "addw", "subw", "slt", "sltu"]
inst_shift = ["sll", "srl", "sra", "sllw", "srlw", "sraw"]

file_name = "test"

# 自动生成R型指令测试样例1000个输出到file_name文件中
# 新建build文件夹存放生成的文件
# 初始化寄存器状态，0表示可用
reg_status = {r: 0 for r in reg}


def get_available_reg(reg, reg_status):
    reg_status["x1"] = 4  # x1寄存器一直被占用，不可用
    available_regs = [r for r, status in reg_status.items() if status == 0]
    if not available_regs:  # 如果没有可用的寄存器，则返回x0
        return reg[0]
    return random.choice(available_regs)


def update_reg_status(reg_status):
    for r in reg_status:
        if reg_status[r] > 0:
            reg_status[r] -= 1  # 减少计数，向可用状态靠近


def set_gpr(index, value):
    while reg_status[index] > 0:
        f.write(f"\tnop\n")
        update_reg_status(reg_status)
    # 初始化寄存器
    f.write(f"\tadd {index}, x0, x0\n")
    for i in range(3):
        f.write(f"\tnop\n")
    for i in range(value):
        f.write(f"\tadd {index}, {index}, x1\n")
        for i in range(3):
            f.write(f"\tnop\n")


def init_gpr():
    for i in range(2, 32):
        set_gpr(f"x{i}", i)


def test_inst(inst, n=10000):
    for i in range(n):
        rd = get_available_reg(reg, reg_status)
        rs1 = get_available_reg(reg, reg_status)
        rs2 = get_available_reg(reg, reg_status)
        f.write(f"\t{inst} {rd}, {rs1}, {rs2}\n")
        reg_status[rd] = 4
        update_reg_status(reg_status)  # 更新寄存器状态


def random_test_inst(insts, n=10000):
    for i in range(n):
        inst = random.choice(insts)
        rd = get_available_reg(reg, reg_status)
        rs1 = get_available_reg(reg, reg_status)
        rs2 = get_available_reg(reg, reg_status)
        f.write(f"\t{inst} {rd}, {rs1}, {rs2}\n")
        reg_status[rd] = 4
        update_reg_status(reg_status)  # 更新寄存器状态

if not os.path.exists("build"):
    os.mkdir("build")
with open("./build/{}.s".format(file_name), "w") as f:
    f.write(".text\n")
    f.write(".global _start\n")
    f.write("_start:\n")
    init_gpr()
    random_test_inst(inst_add)
    init_gpr()
    for i in inst_shift:
        test_inst(i, 100)
        init_gpr()
    # 结束程序
    set_gpr("x3", 1)
    set_gpr("x17", 93)
    set_gpr("x10", 0)
    f.write("\tecall\n")

# 将生成的R型指令测试样例汇编成bin文件
os.system(
    "riscv64-unknown-linux-gnu-as -o ./build/{}.o ./build/{}.s".format(
        file_name, file_name
    )
)
os.system(
    "riscv64-unknown-linux-gnu-ld -T ../config/linker.ld -o ./build/{} ./build/{}.o".format(
        file_name, file_name
    )
)
os.system(
    "riscv64-unknown-linux-gnu-objcopy -O binary ./build/{} ./build/{}.bin".format(
        file_name, file_name
    )
)
os.system(
    "riscv64-unknown-linux-gnu-objdump -d -M no-aliases,numeric  ./build/{} > ./build/{}.asm".format(
        file_name, file_name
    )
)
os.system("rm -rf ../build")
os.system("mv ./build ../")
