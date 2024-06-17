import random
import os

random.seed(0)

reg = [f"x{i}" for i in range(32)]
# 定义R型运算类指令
inst_r = [
    "add",
    "sub",
    "sll",
    "slt",
    "sltu",
    "xor",
    "srl",
    "sra",
    "or",
    "and",
    "addw",
    "subw",
    "sllw",
    "srlw",
    "sraw",
]

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


with open("./build/{}.s".format(file_name), "w") as f:
    f.write(".text\n")
    f.write(".global _start\n")
    f.write("_start:\n")
    for i in range(1000):
        update_reg_status(reg_status)  # 更新寄存器状态
        inst = random.choice(inst_r)
        rd = get_available_reg(reg, reg_status)
        rs1 = get_available_reg(reg, reg_status)
        rs2 = get_available_reg(reg, reg_status)
        f.write(f"\t{inst} {rd}, {rs1}, {rs2}\n")
        reg_status[rd] = 5  # 寄存器被写入后设置为5，表示5个循环后可用
    # 结束程序
    f.write("\tli x3, 1\n")
    f.write("\tli x17, 93\n")
    f.write("\tli x10, 0\n")
    f.write("\tecall\n")

# 将生成的R型指令测试样例汇编成bin文件
os.system(
    "riscv64-unknown-linux-gnu-as -o ./build/{}.o ./build/{}.s".format(
        file_name, file_name
    )
)
os.system(
    "riscv64-unknown-linux-gnu-ld -T ./linker.ld -o ./build/{} ./build/{}.o".format(
        file_name, file_name
    )
)
os.system(
    "riscv64-unknown-linux-gnu-objcopy -O binary ./build/{} ./build/{}.bin".format(
        file_name, file_name
    )
)
os.system(
    "riscv64-unknown-linux-gnu-objdump -d -M no-aliases,numeric  ./build/{} > ./build/{}.s".format(
        file_name, file_name
    )
)
