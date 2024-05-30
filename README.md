# 🧬 PUA-RISCV-DIFFTEST

对 AXI 结构的 [PUA-RISCV](https://github.com/Ciliphen/riscv-lab) 提供差分测试支持

差分测试框架修改自 [soc-simulator](https://github.com/cyyself/soc-simulator)

## 📑 目录说明

- `core` **存放待测试处理器的代码**，其顶层信号应与 `top_axi_wrapper` 中信号定义一致

- `test` 存放测试代码

- `src` 存放模拟器代码

## 🔨 使用方法

1. 将 CPU 代码放置到相对于本文件夹的 `core` 文件夹中。

1. 在本文件夹下，使用 `make` 命令完成编译编译结果位于 `obj_dir/Vtop_axi_wrapper`

1. 每次修改 CPU 代码后，需要重新 `make`，如果引入了一些时间早于编译产物的代码，需要先 `make clean` 再 `make`

## 🧪 参数说明

`makefile` 中已经预置了常用命令

在命令 `./obj_dir/Vtop_axi_wrapper` 后面可以加上不同参数，可以实现不同的功能：

- `无参数` 运行串口测试工具，打印 RISC-V LOGO

- `<测试文件路径> -rvtest` 运行对应测试文件的差分测试

  - 在上述命令后继续增加参数：
    - `-trace <记录波形时长>` 记录波形，并导出
    - `-pc` 报错时将额外输出最近的 PC 历史记录
    - `-delay` 行为不一致时将继续运行一段时间再停止
  - 评测功能，下述信号互斥，只能选择一个：
    - `-cpu_trace` 记录被测试的处理器的程序运行差分测试信号
    - `-golden_trace` 记录模拟器的程序运行差分测试信号

- `-os` 运行操作系统测试（目前支持Linux）
  - 在上述命令后继续增加参数：
    - `-trace <记录波形时长>` 记录波形，并导出
    - `-pc` 报错时将额外输出最近的 PC 历史记录
    - `-delay` 行为不一致时将继续运行一段时间再停止
    - `-nodiff` 不进行差分测试
    - `-starttrace <开始记录波形的时刻>` 从指定时刻开始记录一段固定时长的波形
    - `-emu` 使用模拟器进行测试
