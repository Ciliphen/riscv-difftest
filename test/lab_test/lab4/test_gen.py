import random
import os

random.seed(0)

reg = [f"x{i}" for i in range(32)]
# Define R-type arithmetic instructions
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
file_name = "test"

mem_start = 0x80200000
mem_end = 0x80210000

# Initialize register status: 0 means available.
reg_status = {r: 0 for r in reg}


def get_available_reg(reg, reg_status):
    available_regs = [r for r, status in reg_status.items() if status == 0]
    if not available_regs:  # If no register available, return x0.
        return reg[0]
    return random.choice(available_regs)


def update_reg_status(reg_status):
    for r in reg_status:
        if reg_status[r] > 0:
            reg_status[r] -= 1  # Countdown to register availability


def test_reg_inst(insts=inst_reg):
    inst = random.choice(insts)
    rd = get_available_reg(reg, reg_status)
    rs1 = get_available_reg(reg, reg_status)
    rs2 = get_available_reg(reg, reg_status)
    f.write(f"\t{inst} {rd}, {rs1}, {rs2}\n")
    reg_status[rd] = 4  # Delay to avoid data hazard
    update_reg_status(reg_status)


def test_imm_inst():
    inst = random.choice(inst_imm)
    rd = get_available_reg(reg, reg_status)
    rs1 = get_available_reg(reg, reg_status)
    if inst in inst_shift_imm6:
        imm = random.randint(0, 2**6 - 1)
    elif inst in inst_shift_imm5:
        imm = random.randint(0, 2**5 - 1)
    else:
        imm = random.randint(-(2**11), 2**11 - 1)
    f.write(f"\t{inst} {rd}, {rs1}, {imm}\n")
    reg_status[rd] = 4
    update_reg_status(reg_status)


def test_lui_inst():
    inst = random.choice(inst_lui)
    rd = get_available_reg(reg, reg_status)
    imm = random.randint(0, 2**20 - 1)
    f.write(f"\t{inst} {rd}, {imm}\n")
    reg_status[rd] = 4
    update_reg_status(reg_status)


def wait_gpr(index):
    while reg_status["x{}".format(index)] > 0:
        f.write("\tnop\n")
        update_reg_status(reg_status)


def insert_nop(n=3):
    for i in range(n):
        f.write("\tnop\n")
        update_reg_status(reg_status)


def test_lb():
    f.write("\taddiw x1, x0, 1025\n")
    insert_nop()
    f.write("\tslli x1, x1, 0x15\n")  # x1 = 0x80200000
    insert_nop()
    rd = get_available_reg(reg, reg_status)
    while rd == "x1":
        rd = get_available_reg(reg, reg_status)
    rs1 = "x1"
    imm = random.randint(-(2**11), 2**11 - 1)
    f.write(f"\tsb {rd}, {imm}({rs1})\n")
    f.write(f"\tlb {rd}, {imm}({rs1})\n")
    reg_status[rd] = 4
    update_reg_status(reg_status)
    rd = get_available_reg(reg, reg_status)
    while rd == "x1":
        rd = get_available_reg(reg, reg_status)
    f.write(f"\tlbu {rd}, {imm}({rs1})\n")
    reg_status[rd] = 4
    update_reg_status(reg_status)


def test_lh():
    f.write("\taddiw x1, x0, 1025\n")
    insert_nop()
    f.write("\tslli x1, x1, 0x15\n")  # x1 = 0x80200000
    insert_nop()
    rd = get_available_reg(reg, reg_status)
    while rd == "x1":
        rd = get_available_reg(reg, reg_status)
    rs1 = "x1"
    # Align immediate for halfword access (even address)
    imm = random.randint(-(2**11), 2**11 - 1) & 0xFFFFFFFFFFFFFFFE
    f.write(f"\tsh {rd}, {imm}({rs1})\n")
    f.write(f"\tlh {rd}, {imm}({rs1})\n")
    reg_status[rd] = 4
    update_reg_status(reg_status)
    rd = get_available_reg(reg, reg_status)
    while rd == "x1":
        rd = get_available_reg(reg, reg_status)
    f.write(f"\tlhu {rd}, {imm}({rs1})\n")
    reg_status[rd] = 4
    update_reg_status(reg_status)


def test_lw():
    f.write("\taddiw x1, x0, 1025\n")
    insert_nop()
    f.write("\tslli x1, x1, 0x15\n")  # x1 = 0x80200000
    insert_nop()
    rd = get_available_reg(reg, reg_status)
    while rd == "x1":
        rd = get_available_reg(reg, reg_status)
    rs1 = "x1"
    # Align immediate for word access (multiple of 4)
    imm = random.randint(-(2**11), 2**11 - 1) & 0xFFFFFFFFFFFFFFFC
    f.write(f"\tsw {rd}, {imm}({rs1})\n")
    f.write(f"\tlw {rd}, {imm}({rs1})\n")
    reg_status[rd] = 4
    update_reg_status(reg_status)
    rd = get_available_reg(reg, reg_status)
    while rd == "x1":
        rd = get_available_reg(reg, reg_status)
    f.write(f"\tlwu {rd}, {imm}({rs1})\n")
    reg_status[rd] = 4
    update_reg_status(reg_status)


def test_ld():
    f.write("\taddiw x1, x0, 1025\n")
    insert_nop()
    f.write("\tslli x1, x1, 0x15\n")  # x1 = 0x80200000
    insert_nop()
    rd = get_available_reg(reg, reg_status)
    while rd == "x1":
        rd = get_available_reg(reg, reg_status)
    rs1 = "x1"
    # Align immediate for doubleword access (multiple of 8)
    imm = random.randint(-(2**11), 2**11 - 1) & 0xFFFFFFFFFFFFFFF8
    f.write(f"\tsd {rd}, {imm}({rs1})\n")
    f.write(f"\tld {rd}, {imm}({rs1})\n")
    reg_status[rd] = 4
    update_reg_status(reg_status)


def test_store_load_cycle():
    """
    This function stores several registers into memory using store instructions 
    with properly aligned immediates, then overwrites those memory addresses, 
    and finally loads the values back using the corresponding load instructions.
    """
    # Set up x1 as the memory base address (0x80200000)
    f.write("\taddiw x1, x0, 1025\n")
    insert_nop()
    f.write("\tslli x1, x1, 0x15\n")
    insert_nop()
    
    cycle_count = 5  # Number of store instructions in each cycle.
    store_entries = []

    # First, store values using a randomly chosen store instruction.
    for _ in range(cycle_count):
        rd = get_available_reg(reg, reg_status)
        while rd == "x1":
            rd = get_available_reg(reg, reg_status)
            
        store_inst = random.choice(inst_store)
        if store_inst == "sb":
            imm = random.randint(-(2**11), 2**11 - 1)
        elif store_inst == "sh":
            # Align immediate to an even address.
            imm = random.randint(-(2**11), 2**11 - 1) & 0xFFFFFFFFFFFFFFFE
        elif store_inst == "sw":
            # Align immediate to a multiple of 4.
            imm = random.randint(-(2**11), 2**11 - 1) & 0xFFFFFFFFFFFFFFFC
        elif store_inst == "sd":
            # Align immediate to a multiple of 8.
            imm = random.randint(-(2**11), 2**11 - 1) & 0xFFFFFFFFFFFFFFF8
        f.write(f"\t{store_inst} {rd}, {imm}(x1)\n")
        store_entries.append((store_inst, imm, rd))
        reg_status[rd] = 4
        update_reg_status(reg_status)
    
    # Overwrite the previously stored addresses with new values.
    overwrite_entries = []
    for _ in range(cycle_count):
        rd = get_available_reg(reg, reg_status)
        while rd == "x1":
            rd = get_available_reg(reg, reg_status)
            
        store_inst = random.choice(inst_store)
        if store_inst == "sb":
            imm = random.randint(-(2**11), 2**11 - 1)
        elif store_inst == "sh":
            imm = random.randint(-(2**11), 2**11 - 1) & 0xFFFFFFFFFFFFFFFE
        elif store_inst == "sw":
            imm = random.randint(-(2**11), 2**11 - 1) & 0xFFFFFFFFFFFFFFFC
        elif store_inst == "sd":
            imm = random.randint(-(2**11), 2**11 - 1) & 0xFFFFFFFFFFFFFFF8
        f.write(f"\t{store_inst} {rd}, {imm}(x1)\n")
        overwrite_entries.append((store_inst, imm, rd))
        reg_status[rd] = 4
        update_reg_status(reg_status)
    
    # Now, load back the values stored in the first cycle.
    for store_inst, imm, reg_written in store_entries:
        rd = get_available_reg(reg, reg_status)
        while rd == "x1":
            rd = get_available_reg(reg, reg_status)
        # Choose an appropriate load instruction corresponding to the store type.
        if store_inst == "sb":
            load_inst = random.choice(["lb", "lbu"])
        elif store_inst == "sh":
            load_inst = random.choice(["lh", "lhu"])
        elif store_inst == "sw":
            load_inst = random.choice(["lw", "lwu"])
        elif store_inst == "sd":
            load_inst = "ld"
        f.write(f"\t{load_inst} {rd}, {imm}(x1)\n")
        reg_status[rd] = 4
        update_reg_status(reg_status)
    
    # Similarly, load back the values from the overwrite cycle.
    for store_inst, imm, reg_written in overwrite_entries:
        rd = get_available_reg(reg, reg_status)
        while rd == "x1":
            rd = get_available_reg(reg, reg_status)
        if store_inst == "sb":
            load_inst = random.choice(["lb", "lbu"])
        elif store_inst == "sh":
            load_inst = random.choice(["lh", "lhu"])
        elif store_inst == "sw":
            load_inst = random.choice(["lw", "lwu"])
        elif store_inst == "sd":
            load_inst = "ld"
        f.write(f"\t{load_inst} {rd}, {imm}(x1)\n")
        reg_status[rd] = 4
        update_reg_status(reg_status)


# Create the build directory if it doesn't exist.
if not os.path.exists("build"):
    os.mkdir("build")

with open("./build/{}.s".format(file_name), "w") as f:
    f.write(".text\n")
    f.write(".global _start\n")
    f.write("_start:\n")
    # Generate some immediate and LUI instructions.
    for i in range(100):
        test_imm_inst()
        test_lui_inst()
    instructions = [test_lb, test_lh, test_lw, test_ld]
    for i in range(10000):
        test_reg_inst()
        random.choice([test_imm_inst, test_lui_inst, test_reg_inst])()
        random.choice(instructions)()
    # End the program.
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
