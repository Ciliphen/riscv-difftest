TOP_NAME := top_axi_wrapper
SRC_DIR  := ../../core
SRC_FILE := $(shell find $(SRC_DIR) -name '*.svh') $(shell find $(SRC_DIR) -name '*.v') $(shell find $(SRC_DIR) -name '*.sv')
CHISEL_DIR = ../../../chisel
BUILD_DIR = $(CHISEL_DIR)/build

.PHONY: clean riscv-tests-build

obj_dir/V$(TOP_NAME): src/* $(SRC_FILE) ../soft/start.bin
	verilator --cc -Wno-fatal --exe --trace-fst --trace-structs -LDFLAGS "-lpthread" --build src/sim_mycpu.cpp $(SRC_FILE) -I$(SRC_DIR) --top $(TOP_NAME) -j `nproc`

verilog:
	$(MAKE) -C $(CHISEL_DIR) verilog
	cp $(CHISEL_DIR)/build/PuaCpu.v $(SRC_DIR)
	$(MAKE) func

func: obj_dir/V$(TOP_NAME)
	# ./obj_dir/Vtop_axi_wrapper ./tests-bin/rv64ua-v-lrsc.bin -rvtest -trace 100000 -pc
	# ./obj_dir/Vtop_axi_wrapper -linux -pc -starttrace 127940000 -printpc
	# ./obj_dir/Vtop_axi_wrapper -linux -pc -printpc -trace 1000000
	./obj_dir/Vtop_axi_wrapper -linux -pc -printpc
	# ./obj_dir/Vtop_axi_wrapper -trace 100000 -pc
	# ./run_riscv_test.py

trace: obj_dir/V$(TOP_NAME)
	./obj_dir/Vtop_axi_wrapper ./tests-bin/rv64ua-v-lrsc.bin -rvtest -golden_trace
../soft/start.bin:
	cd ../soft && make

copy:
	cp  ~/test/opensbi/build/platform/generic/firmware/fw_payload.bin ./linux/

riscv-tests:
	git clone git@github.com:cyyself/riscv-tests.git -b cqu-co-lab-riscv
	cd riscv-tests && git submodule update --init --recursive && autoupdate && autoconf && ./configure

riscv-tests-build: riscv-tests
	mkdir -p riscv-tests-build
	make -C riscv-tests-build -f ../riscv-tests/Makefile RISCV_PREFIX=riscv64-unknown-linux-gnu- benchmarks

clean:
	rm -rf obj_dir