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
	$(MAKE) -C ./test/lab_test/lab5 test
	# ./obj_dir/V$(TOP_NAME) ./test/lab_test/build/test.bin -rvtest -golden_trace -hasdelayslot
	./obj_dir/V$(TOP_NAME) ./test/lab_test/build/test.bin -rvtest -trace 10000000 -pc -hasdelayslot

clean:
	rm -rf obj_dir

perf: obj_dir/V$(TOP_NAME)
	count=0; \
	for test in ./test/bin/riscv-test/benchmarks/*; do \
		count=$$((count + 1)); \
		echo "Running test $$count: $$test"; \
		./obj_dir/V$(TOP_NAME) $$test -rvtest -pc -perf; \
	done; \

lab1: obj_dir/V$(TOP_NAME)
	./obj_dir/V$(TOP_NAME) ./test/bin/lab-test/lab1.bin -rvtest -initgprs -trace 10000000 -pc

trace_lab1: obj_dir/V$(TOP_NAME)
	./obj_dir/V$(TOP_NAME) ./test/bin/lab-test/lab1.bin -rvtest -initgprs -cpu_trace

TESTS234 := lab2 lab3 lab4
TRACE_TESTS234 := $(addprefix trace_,$(TESTS234))

$(TESTS234): %: obj_dir/V$(TOP_NAME)
	./obj_dir/V$(TOP_NAME) ./test/bin/lab-test/$@.bin -rvtest -trace 10000000 -pc

$(TRACE_TESTS234): trace_%: obj_dir/V$(TOP_NAME)
	./obj_dir/V$(TOP_NAME) ./test/bin/lab-test/$*.bin -rvtest -cpu_trace

lab5: obj_dir/V$(TOP_NAME)
	./obj_dir/V$(TOP_NAME) ./test/bin/lab-test/lab5.bin -rvtest -trace 10000000 -pc -hasdelayslot

trace_lab5: obj_dir/V$(TOP_NAME)
	./obj_dir/V$(TOP_NAME) ./test/bin/lab-test/lab5.bin -rvtest -cpu_trace -hasdelayslot

TEST67 := lab6 lab7
TRACE_TESTS67 := $(addprefix trace_,$(TEST67))

$(TEST67): obj_dir/V$(TOP_NAME)
	count=0; \
	for test in ./test/bin/am-tests/*; do \
		count=$$((count + 1)); \
		echo "Running test $$count: $$test"; \
		./obj_dir/V$(TOP_NAME) $$test -rvtest -pc; \
	done; \
	count=$$((count + 1)); \
	echo "Running test $$count: ./test/bin/lab-test/lab6.bin"; \
	./obj_dir/V$(TOP_NAME) ./test/bin/lab-test/lab6.bin -rvtest -pc -perf; \
	echo "Total tests run: $$count";

$(TRACE_TESTS67): obj_dir/V$(TOP_NAME)
	rm -rf ./trace.txt
	count=0; \
	for test in ./test/bin/am-tests/*; do \
		count=$$((count + 1)); \
		echo "Running test $$count: $$test"; \
		./obj_dir/V$(TOP_NAME) $$test -rvtest -cpu_trace -writeappend; \
	done; \
	count=$$((count + 1)); \
	echo "Running test $$count: ./test/bin/lab-test/lab6.bin"; \
	./obj_dir/V$(TOP_NAME) ./test/bin/lab-test/lab6.bin -rvtest -cpu_trace -writeappend; \
	echo "Total tests run: $$count";

lab9: obj_dir/V$(TOP_NAME)
	count=0; \
	for test in $$(find ./test/bin/riscv-test/ \( -name "rv64ui-p-*" -o -name "rv64um-p-*" -o -name "rv64mi-p-*" \) | grep -vE "rv64ui-p-fence_i|rv64mi-p-access"); do \
		count=$$((count + 1)); \
		echo "Running test $$count: $$test"; \
		./obj_dir/V$(TOP_NAME) $$test -rvtest -pc; \
	done; \
	echo "Total tests run: $$count";

trace_lab9: obj_dir/V$(TOP_NAME)
	count=0; \
	for test in $$(find ./test/bin/riscv-test/ \( -name "rv64ui-p-*" -o -name "rv64um-p-*" -o -name "rv64mi-p-*" \) | grep -vE "rv64ui-p-fence_i|rv64mi-p-access"); do \
		count=$$((count + 1)); \
		echo "Running test $$count: $$test"; \
		./obj_dir/V$(TOP_NAME) $$test -rvtest -cpu_trace -writeappend; \
	done; \
	echo "Total tests run: $$count";

# mv:
# 	dir="./test/asm/riscv-test/isa/rv64ssvnapot-p-"; \
# 	mkdir -p "$$dir"; \
# 	find ./test/asm/riscv-test/isa/ -type f -name "rv64ssvnapot-p-*" -exec git mv {} "$$dir" \;