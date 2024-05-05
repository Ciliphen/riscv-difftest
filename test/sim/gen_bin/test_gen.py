import random
import os


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

file_name = "test_r"

# 自动生成R型指令测试样例1000个输出到file_name文件中
# 新建build文件夹存放生成的文件
if not os.path.exists("build"):
    os.mkdir("build")
with open("./build/{}.s".format(file_name), "w") as f:
    f.write(".text\n")
    f.write(".global _start\n")
    f.write("_start:\n")
    for i in range(1000):
        inst = random.choice(inst_r)
        rd = random.choice(reg)
        rs1 = random.choice(reg)
        rs2 = random.choice(reg)
        f.write(f"\t{inst} {rd}, {rs1}, {rs2}\n")

# 将生成的R型指令测试样例汇编成bin文件
os.system("riscv64-unknown-linux-gnu-as -o ./build/{}.o ./build/{}.s".format(file_name, file_name))
os.system("riscv64-unknown-linux-gnu-ld -o ./build/{} ./build/{}.o".format(file_name, file_name))
os.system("riscv64-unknown-linux-gnu-objcopy -O binary ./build/{} ./build/{}.bin".format(file_name, file_name))