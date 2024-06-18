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
inst_reg += [
    "mul",
    "mulh",
    "mulhsu",
    "mulhu",
    "div",
    "divu",
    "rem",
    "remu",
    "mulw",
    "divw",
    "divuw",
    "remw",
    "remuw",
]
inst_load = ["lb", "lh", "lw", "ld", "lbu", "lhu", "lwu"]
inst_store = ["sb", "sh", "sw", "sd"]
inst_branch = ["beq", "bne", "blt", "bge", "bltu", "bgeu"]
inst_jal = ["jal"]
inst_jalr = ["jalr"]
file_name = "test"

mem_start = 0x80200000
mem_end = 0x80210000

# 自动生成R型指令测试样例1000个输出到file_name文件中
# 新建build文件夹存放生成的文件
# 初始化寄存器状态，0表示可用


def test_reg_inst(insts=inst_reg):
    inst = random.choice(insts)
    rd = random.choice(reg)
    rs1 = random.choice(reg)
    rs2 = random.choice(reg)
    f.write(f"\t{inst} {rd}, {rs1}, {rs2}\n")


def test_imm_inst():
    inst = random.choice(inst_imm)
    rd = random.choice(reg)
    rs1 = random.choice(reg)
    if inst in inst_shift_imm6:
        imm = random.randint(0, 2**6 - 1)
    elif inst in inst_shift_imm5:
        imm = random.randint(0, 2**5 - 1)
    else:
        imm = random.randint(-(2**11), 2**11 - 1)
    f.write(f"\t{inst} {rd}, {rs1}, {imm}\n")


def test_lui_inst():
    inst = random.choice(inst_lui)
    rd = random.choice(reg)
    imm = random.randint(0, 2**20 - 1)
    f.write(f"\t{inst} {rd}, {imm}\n")


def test_lb():
    f.write("\taddiw x1, x0, 1025\n")
    f.write("\tslli x1, x1, 0x15\n")  # x1=0x80200000
    rd = random.choice(reg)
    while rd == "x1":
        rd = random.choice(reg)
    rs1 = "x1"
    imm = random.randint(-(2**11), 2**11 - 1)
    f.write(f"\tsb {rd}, {imm}({rs1})\n")
    f.write(f"\tlb {rd}, {imm}({rs1})\n")
    rd = random.choice(reg)
    while rd == "x1":
        rd = random.choice(reg)
    f.write(f"\tlbu {rd}, {imm}({rs1})\n")


def test_lh():
    f.write("\taddiw x1, x0, 1025\n")
    f.write("\tslli x1, x1, 0x15\n")  # x1=0x80200000
    rd = random.choice(reg)
    while rd == "x1":
        rd = random.choice(reg)
    rs1 = "x1"
    imm = random.randint(-(2**11), 2**11 - 1) & 0xFFFFFFFFFFFFFFFE
    f.write(f"\tsh {rd}, {imm}({rs1})\n")
    f.write(f"\tlh {rd}, {imm}({rs1})\n")
    rd = random.choice(reg)
    while rd == "x1":
        rd = random.choice(reg)
    f.write(f"\tlhu {rd}, {imm}({rs1})\n")


def test_lw():
    f.write("\taddiw x1, x0, 1025\n")
    f.write("\tslli x1, x1, 0x15\n")  # x1=0x80200000
    rd = random.choice(reg)
    while rd == "x1":
        rd = random.choice(reg)
    rs1 = "x1"
    imm = random.randint(-(2**11), 2**11 - 1) & 0xFFFFFFFFFFFFFFFC
    f.write(f"\tsw {rd}, {imm}({rs1})\n")
    f.write(f"\tlw {rd}, {imm}({rs1})\n")
    rd = random.choice(reg)
    while rd == "x1":
        rd = random.choice(reg)
    f.write(f"\tlwu {rd}, {imm}({rs1})\n")


def test_ld():
    f.write("\taddiw x1, x0, 1025\n")
    f.write("\tslli x1, x1, 0x15\n")  # x1=0x80200000
    rd = random.choice(reg)
    while rd == "x1":
        rd = random.choice(reg)
    rs1 = "x1"
    imm = random.randint(-(2**11), 2**11 - 1) & 0xFFFFFFFFFFFFFFF8
    f.write(f"\tsd {rd}, {imm}({rs1})\n")
    f.write(f"\tld {rd}, {imm}({rs1})\n")


if not os.path.exists("build"):
    os.mkdir("build")
with open("./build/{}.s".format(file_name), "w") as f:
    f.write(".text\n")
    f.write(".global _start\n")
    f.write("_start:\n")
    for i in range(100):
        test_imm_inst()
        test_lui_inst()
    instructions = [test_lb, test_lh, test_lw, test_ld]
    for i in range(20000):
        test_reg_inst()
        if random.randint(0, 20) == 0:
            random.choice([test_imm_inst, test_lui_inst])()
        if random.randint(0, 40) == 0:
            random.choice(instructions)()
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
