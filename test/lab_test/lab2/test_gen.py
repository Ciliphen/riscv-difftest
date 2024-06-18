import random
import os

random.seed(0)

reg = [f"x{i}" for i in range(32)]
# 定义R型运算类指令
inst_reg = [
    "add",
    "sub",
    "xor",
    "or",
    "and",
    "addw",
    "subw",
    "slt",
    "sltu",
    "sll",
    "srl",
    "sra",
    "sllw",
    "srlw",
    "sraw",
]
inst_imm = [
    "addi",
    "slti",
    "sltiu",
    "xori",
    "ori",
    "andi",
    "slli",
    "srli",
    "srai",
    "addiw",
    "slliw",
    "srliw",
    "sraiw",
]
inst_lui = ["lui", "auipc"]
inst_shift_imm6 = ["slli", "srli", "srai"]
inst_shift_imm5 = ["slliw", "srliw", "sraiw"]

file_name = "test"

# 自动生成R型指令测试样例1000个输出到file_name文件中
# 新建build文件夹存放生成的文件
# 初始化寄存器状态，0表示可用
reg_status = {r: 0 for r in reg}


def get_available_reg(reg, reg_status):
    available_regs = [r for r, status in reg_status.items() if status == 0]
    if not available_regs:  # 如果没有可用的寄存器，则返回x0
        return reg[0]
    return random.choice(available_regs)


def update_reg_status(reg_status):
    for r in reg_status:
        if reg_status[r] > 0:
            reg_status[r] -= 1  # 减少计数，向可用状态靠近


def test_reg_inst():
    inst = random.choice(inst_reg)
    rd = get_available_reg(reg, reg_status)
    rs1 = get_available_reg(reg, reg_status)
    rs2 = get_available_reg(reg, reg_status)
    f.write(f"\t{inst} {rd}, {rs1}, {rs2}\n")
    reg_status[rd] = 4
    update_reg_status(reg_status)  # 更新寄存器状态


def test_imm_inst():
    inst = random.choice(inst_imm)
    rd = get_available_reg(reg, reg_status)
    rs1 = get_available_reg(reg, reg_status)
    if inst in inst_shift_imm6:
        imm = random.randint(0, 2**6 - 1)
    elif inst in inst_shift_imm5:
        imm = random.randint(0, 2**5 - 1)
    else:
        imm = random.randint(-2**11, 2**11 - 1)
    f.write(f"\t{inst} {rd}, {rs1}, {imm}\n")
    reg_status[rd] = 4
    update_reg_status(reg_status)  # 更新寄存器状态


def test_lui_inst():
    inst = random.choice(inst_lui)
    rd = get_available_reg(reg, reg_status)
    imm = random.randint(0, 2**20 - 1)
    f.write(f"\t{inst} {rd}, {imm}\n")
    reg_status[rd] = 4
    update_reg_status(reg_status)  # 更新寄存器状态


def wait_gpr(index):
    while reg_status["x{}".format(index)] > 0:
        f.write("\tnop\n")
        update_reg_status(reg_status)


if not os.path.exists("build"):
    os.mkdir("build")
with open("./build/{}.s".format(file_name), "w") as f:
    f.write(".text\n")
    f.write(".global _start\n")
    f.write("_start:\n")
    for i in range(100):
        test_lui_inst()
        test_imm_inst()
    for i in range(20000):
        test_imm_inst()
        test_lui_inst()
        test_reg_inst()
    # 结束程序
    wait_gpr(3)
    f.write("\tli x3, 1\n")
    wait_gpr(17)
    f.write("\tli x17, 93\n")
    wait_gpr(10)
    f.write("\tli x10, 0\n")
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
