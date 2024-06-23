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

test: obj_dir/V$(TOP_NAME)
	$(MAKE) -C ./test/lab_test/lab6 test
	# ./obj_dir/V$(TOP_NAME) ./test/lab_test/build/test.bin -rvtest -golden_trace # -initgprs # lab1记得初始化寄存器堆
	./obj_dir/V$(TOP_NAME) ./test/lab_test/build/test.bin -rvtest -perf # -trace 10000000 -pc # -initgprs # lab1记得初始化寄存器堆

clean:
	rm -rf obj_dir

perf: obj_dir/V$(TOP_NAME)
	count=0; \
	for test in ./test/bin/riscv-test/benchmarks/*; do \
		count=$$((count + 1)); \
		echo "Running test $$count: $$test"; \
		./obj_dir/V$(TOP_NAME) $$test -rvtest -pc -perf -dual_issue; \
	done; \

lab14: obj_dir/V$(TOP_NAME)
	count=0; \
	for test in $$(find ./test/bin/riscv-test/ \( -name "rv64ui-p-*" -o -name "rv64um-p-*" -o -name "rv64mi-p-*" -o -name "rv64si-p-*" -o -name "rv64ui-v-*" \) | grep -vE "rv64mi-p-access|rv64mi-p-illegal"); do \
		count=$$((count + 1)); \
		echo "Running test $$count: $$test"; \
		./obj_dir/V$(TOP_NAME) $$test -rvtest -pc -dual_issue; \
	done; \
	echo "Total tests run: $$count";

trace_lab14: obj_dir/V$(TOP_NAME)
	rm -rf ./trace.txt
	count=0; \
	for test in $$(find ./test/bin/riscv-test/ \( -name "rv64ui-p-*" -o -name "rv64um-p-*" -o -name "rv64mi-p-*" -o -name "rv64si-p-*" -o -name "rv64ui-v-*" \) | grep -vE "rv64mi-p-access|rv64mi-p-illegal"); do \
		count=$$((count + 1)); \
		echo "Running test $$count: $$test"; \
		./obj_dir/V$(TOP_NAME) $$test -rvtest -cpu_trace -writeappend -dual_issue; \
	done; \
	echo "Total tests run: $$count";

# mv:
# 	dir="./test/asm/riscv-test/isa/rv64ssvnapot-p-"; \
# 	mkdir -p "$$dir"; \
# 	find ./test/asm/riscv-test/isa/ -type f -name "rv64ssvnapot-p-*" -exec git mv {} "$$dir" \;