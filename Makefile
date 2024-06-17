TOP_NAME := top
SRC_DIR  := ./core
SRC_FILE := $(shell find $(SRC_DIR) -name '*.svh') $(shell find $(SRC_DIR) -name '*.v') $(shell find $(SRC_DIR) -name '*.sv')
CHISEL_DIR = ../chisel
BUILD_DIR = $(CHISEL_DIR)/build

.PHONY: clean

obj_dir/V$(TOP_NAME): src/* $(SRC_FILE)
	verilator --cc -Wno-fatal --exe --trace-fst --trace-structs -LDFLAGS "-lpthread" --build src/sim_mycpu.cpp $(SRC_FILE) -I$(SRC_DIR) --top $(TOP_NAME) -j `nproc`

verilog:
	$(MAKE) -C $(CHISEL_DIR) verilog
	cp $(CHISEL_DIR)/build/PuaCpu.v $(SRC_DIR)

no_trace: obj_dir/V$(TOP_NAME)
	./obj_dir/Vtop -os -pc -printpc 

no_diff: obj_dir/V$(TOP_NAME)
	./obj_dir/Vtop -os -pc -printpc -nodiff

func: obj_dir/V$(TOP_NAME)
	./obj_dir/Vtop ./test/bin/riscv-test/rv64mi-p-csr.bin -rvtest -trace 10000000 -pc #-delay
	# ./test/run_riscv_test.py

lab1: obj_dir/V$(TOP_NAME)
	./obj_dir/Vtop ./test/bin/lab-test/lab1.bin -rvtest -initgprs -trace 10000000 -pc

trace_lab1: obj_dir/V$(TOP_NAME)
	./obj_dir/Vtop ./test/bin/lab-test/lab1.bin -rvtest -initgprs -cpu_trace

test: obj_dir/V$(TOP_NAME)
	./obj_dir/Vtop ./test/gen_bin/build/test.bin -rvtest -golden_trace
	./obj_dir/Vtop ./test/gen_bin/build/test.bin -rvtest -trace 10000000 -pc

perf: obj_dir/V$(TOP_NAME)
	./obj_dir/Vtop ./test/bin/riscv-test/dhrystone.riscv.bin -rvtest -perf

# 生成My的trace
trace: obj_dir/V$(TOP_NAME)
	./obj_dir/Vtop ./test/bin/riscv-test/rv64ui-p-lui.bin -rvtest -cpu_trace

# 生成RV模拟器的标准trace
golden_trace: obj_dir/V$(TOP_NAME)
	./obj_dir/Vtop ./test/bin/riscv-test/rv64ui-p-lui.bin -rvtest -golden_trace

clean:
	rm -rf obj_dir