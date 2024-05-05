# CO-LAB-RISCV Template

## 可参考的资料

- [https://co.ccslab.cn/rv/intro/](https://co.ccslab.cn/rv/intro/)
- [cqu-simple-core](https://github.com/cyyself/cyyrv64/tree/cqu_simple_core)

## 目录说明

- `core` 存放你的核的代码，你可以不使用框架，仅需要确保最外层模块名为`top_axi_wrapper`，且信号一致即可。

  - test 运行整个核的测试框架

    - `soft` 在你的 CPU 核上运行的软件，默认为一个串口输出的演示程序，具体可以查看 Makefile。
    - `sim`：整合[soc-simulator](https://github.com/cyyself/soc-simulator)与[cemu](https://github.com/cyyself/cemu)的文件，提供 Verilator 运行环境。

      - 编译 CPU 核到 Verilator

        直接`make`，编译后结果为`./obj_dir/Vtop_axi_wrapper`。

      - 运行 soft 中简单的代码（默认为类似 Hello World 打印 RISC-V Logo）

        执行`./obj_dir/Vtop_axi_wrapper`，若不带`-rvtest`则会加载`../soft/start.bin`，这一过程大家可以阅读`test/test_workbench/sim/src/sim_mycpu.cpp`的代码。

      - 波形图调试

        执行`./obj_dir/Vtop_axi_wrapper -trace [TRACE_TIME]`，其中`[TRACE_TIME]`替换为波形图输出时间，可以为`1000000000`。波形图会输出到`trace.vcd`文件，可以使用 gtkwave 打开。

      - RISC-V Tests

        - 首先确保已经编译 riscv 工具链，且已加入环境变量 PATH，前缀为`riscv64-unknown-linux-gnu-`
        - 确保 CPU 核已经编译完成
        - 使用`make riscv-test-build`进行编译，如果报错需要排查，建议先`rm -rf riscv-test`以及`rm -rf riscv-test`，打开 Makefile 一条条手动运行。
        - 运行`./run_riscv_test.py`执行测试
        - 如果测试不通过，观察错误的测试点，例如测试点为`rv64mi-p-ma_fetch`，可以使用以下命令单独运行并输出波形图：`./obj_dir/Vtop_axi_wrapper ./tests-bin/rv64mi-p-ma_fetch.bin -rvtest -trace 10000`

## 备注

如果能够自己按照其他逻辑设计乘除法器，可以不用进行乘除法器单元测试。
