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
	./obj_dir/V$(TOP_NAME) -os -pc -printpc 

no_diff: obj_dir/V$(TOP_NAME)
	./obj_dir/V$(TOP_NAME) -os -pc -printpc -nodiff

func: obj_dir/V$(TOP_NAME)
	./obj_dir/V$(TOP_NAME) ./test/bin/riscv-test/rv64mi-p-csr.bin -rvtest -trace 10000000 -pc #-delay
	# ./test/run_riscv_test.py

test: obj_dir/V$(TOP_NAME)
	$(MAKE) -C ./test/lab_test/lab5 test
	./obj_dir/V$(TOP_NAME) ./test/lab_test/build/test.bin -rvtest -golden_trace # -initgprs # lab1记得初始化寄存器堆
	./obj_dir/V$(TOP_NAME) ./test/lab_test/build/test.bin -rvtest -trace 10000000 -pc # -initgprs # lab1记得初始化寄存器堆

perf: obj_dir/V$(TOP_NAME)
	./obj_dir/V$(TOP_NAME) ./test/bin/riscv-test/dhrystone.riscv.bin -rvtest -perf

# 生成My的trace
trace: obj_dir/V$(TOP_NAME)
	./obj_dir/V$(TOP_NAME) ./test/bin/riscv-test/rv64ui-p-lui.bin -rvtest -cpu_trace

# 生成RV模拟器的标准trace
golden_trace: obj_dir/V$(TOP_NAME)
	./obj_dir/V$(TOP_NAME) ./test/bin/riscv-test/rv64ui-p-lui.bin -rvtest -golden_trace

clean:
	rm -rf obj_dir

lab1: obj_dir/V$(TOP_NAME)
	./obj_dir/V$(TOP_NAME) ./test/bin/lab-test/lab1.bin -rvtest -initgprs -trace 10000000 -pc

trace_lab1: obj_dir/V$(TOP_NAME)
	./obj_dir/V$(TOP_NAME) ./test/bin/lab-test/lab1.bin -rvtest -initgprs -cpu_trace

TESTS := lab2 lab3 lab4
TRACE_TESTS := $(addprefix trace_,$(TESTS))

$(TESTS): %: obj_dir/V$(TOP_NAME)
	./obj_dir/V$(TOP_NAME) ./test/bin/lab-test/$@.bin -rvtest -trace 10000000 -pc

$(TRACE_TESTS): trace_%: obj_dir/V$(TOP_NAME)
	./obj_dir/V$(TOP_NAME) ./test/bin/lab-test/$*.bin -rvtest -cpu_trace

lab6: obj_dir/V$(TOP_NAME)
	count=0; \
	for test in ./test/bin/am-tests/*; do \
		count=$$((count + 1)); \
		echo "Running test $$count: $$test"; \
		./obj_dir/V$(TOP_NAME) $$test -rvtest -pc; \
	done; \
	echo "Total tests run: $$count";

trace_lab6: obj_dir/V$(TOP_NAME)
	rm -rf ./trace.txt
	count=0; \
	for test in ./test/bin/am-tests/*; do \
		count=$$((count + 1)); \
		echo "Running test $$count: $$test"; \
		./obj_dir/V$(TOP_NAME) $$test -rvtest -cpu_trace -writeappend; \
	done; \
	echo "Total tests run: $$count";

# mv:
# 	dir="./test/asm/riscv-test/isa/rv64ssvnapot-p-"; \
# 	mkdir -p "$$dir"; \
# 	find ./test/asm/riscv-test/isa/ -type f -name "rv64ssvnapot-p-*" -exec git mv {} "$$dir" \;