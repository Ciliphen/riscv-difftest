TOP_NAME := top_axi_wrapper
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
	./obj_dir/Vtop_axi_wrapper -os -pc -printpc 

no_diff: obj_dir/V$(TOP_NAME)
	./obj_dir/Vtop_axi_wrapper -os -pc -printpc -nodiff

func: obj_dir/V$(TOP_NAME)
	# ./obj_dir/Vtop_axi_wrapper ./test/bin/riscv-test/rv64ui-p-lui.bin -rvtest -trace 100000 -pc #-delay
	# ./obj_dir/Vtop_axi_wrapper ./test/bin/riscv-test/mm.riscv.bin -rvtest #-trace 10000000 -pc #-delay
	# ./obj_dir/Vtop_axi_wrapper -os -pc -printpc # -starttrace 184530000 #-nodiff 
	# ./obj_dir/Vtop_axi_wrapper -os -pc -printpc
	# ./obj_dir/Vtop_axi_wrapper -trace 100000 -pc
	./test/run_riscv_test.py

os: obj_dir/V$(TOP_NAME)
	./obj_dir/Vtop_axi_wrapper -os -pc -cemu

perf: obj_dir/V$(TOP_NAME)
	./obj_dir/Vtop_axi_wrapper ./test/bin/riscv-test/dhrystone.riscv.bin -rvtest -perf

# 生成My的trace
trace: obj_dir/V$(TOP_NAME)
	./obj_dir/Vtop_axi_wrapper ./test/bin/riscv-test/rv64ui-p-lui.bin -rvtest -cpu_trace

# 生成RV模拟器的标准trace
golden_trace: obj_dir/V$(TOP_NAME)
	./obj_dir/Vtop_axi_wrapper ./test/bin/riscv-test/rv64ui-p-lui.bin -rvtest -golden_trace

clean:
	rm -rf obj_dir