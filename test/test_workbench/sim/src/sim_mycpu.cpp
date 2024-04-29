#include "verilated.h"
// #include "verilated_fst_c.h"
#include "verilated_fst_c.h"
#include "Vtop_axi_wrapper.h"
#include "rv_systembus.hpp"
#include "rv_core.hpp"
#include "rv_clint.hpp"
#include "rv_plic.hpp"
#include <stdio.h>

bool running = true;
bool run_riscv_test = false;
bool dump_pc_history = false;
bool print_pc = false;
bool should_delay = false;
bool dual_issue = true;
bool golden_trace = false;
const uint64_t commit_timeout = 3000;
const uint64_t print_pc_cycle = 5e5;
long trace_start_time = 0; // -starttrace [time]
std::atomic_bool trace_on = false;
long sim_time = 1e5;

VerilatedFstC fst;

void open_trace()
{
    fst.open("trace.fst");
    trace_on.store(true, std::memory_order_seq_cst);
}

#undef assert
void assert(bool expr, const char *msg = "")
{
    if (!expr)
    {
        running = false;
        printf("%s\n", msg);
        printf("soc_simulator assert failed!\n");
    }
}

#include "axi4.hpp"
#include "axi4_mem.hpp"
#include "axi4_xbar.hpp"
#include "mmio_mem.hpp"
#include "uartlite.hpp"

#include <iostream>
#include <termios.h>
#include <unistd.h>
#include <thread>
#include <csignal>
#include <sstream>

void connect_wire(axi4_ptr<32, 64, 4> &mmio_ptr, Vtop_axi_wrapper *top)
{
    // connect
    // mmio
    // aw
    mmio_ptr.awaddr = &(top->MAXI_awaddr);
    mmio_ptr.awburst = &(top->MAXI_awburst);
    mmio_ptr.awid = &(top->MAXI_awid);
    mmio_ptr.awlen = &(top->MAXI_awlen);
    mmio_ptr.awready = &(top->MAXI_awready);
    mmio_ptr.awsize = &(top->MAXI_awsize);
    mmio_ptr.awvalid = &(top->MAXI_awvalid);
    // w
    mmio_ptr.wdata = &(top->MAXI_wdata);
    mmio_ptr.wlast = &(top->MAXI_wlast);
    mmio_ptr.wready = &(top->MAXI_wready);
    mmio_ptr.wstrb = &(top->MAXI_wstrb);
    mmio_ptr.wvalid = &(top->MAXI_wvalid);
    // b
    mmio_ptr.bid = &(top->MAXI_bid);
    mmio_ptr.bready = &(top->MAXI_bready);
    mmio_ptr.bresp = &(top->MAXI_bresp);
    mmio_ptr.bvalid = &(top->MAXI_bvalid);
    // ar
    mmio_ptr.araddr = &(top->MAXI_araddr);
    mmio_ptr.arburst = &(top->MAXI_arburst);
    mmio_ptr.arid = &(top->MAXI_arid);
    mmio_ptr.arlen = &(top->MAXI_arlen);
    mmio_ptr.arready = &(top->MAXI_arready);
    mmio_ptr.arsize = &(top->MAXI_arsize);
    mmio_ptr.arvalid = &(top->MAXI_arvalid);
    // r
    mmio_ptr.rdata = &(top->MAXI_rdata);
    mmio_ptr.rid = &(top->MAXI_rid);
    mmio_ptr.rlast = &(top->MAXI_rlast);
    mmio_ptr.rready = &(top->MAXI_rready);
    mmio_ptr.rresp = &(top->MAXI_rresp);
    mmio_ptr.rvalid = &(top->MAXI_rvalid);
}

void uart_input(uartlite &uart)
{
    termios tmp;
    tcgetattr(STDIN_FILENO, &tmp);
    tmp.c_lflag &= (~ICANON & ~ECHO);
    tcsetattr(STDIN_FILENO, TCSANOW, &tmp);
    while (running)
    {
        char c = getchar();
        if (c == 10)
            c = 13; // convert lf to cr
        uart.putc(c);
    }
}

void workbench_run(Vtop_axi_wrapper *top, axi4_ref<32, 64, 4> &mmio_ref)
{
    axi4<32, 64, 4> mmio_sigs;
    axi4_ref<32, 64, 4> mmio_sigs_ref(mmio_sigs);
    axi4_xbar<32, 64, 4> mmio;

    // loader {
    const uint64_t riscv_test_text_start = 0x60000000;
    uint32_t loader_instr[5] = {
        0x000800b7u, // lui	ra,0x80000
        0x00108093u, // addi ra, ra, 1
        0x00c09093u, // slli ra, ra, 0xc
        0x0000b083u, // ld ra,0(ra) # 80001000
        0x000080e7u  // jalr	ra
    };
    // loader }

    mmio_mem cemu_loader_ram(262144 * 4);
    assert(cemu_loader_ram.do_write(0, 20, (uint8_t *)&loader_instr), "cemu boot ram loader");
    assert(cemu_loader_ram.do_write(0x1000, 8, (uint8_t *)&riscv_test_text_start), "cemu boot ram text start");

    mmio_mem rtl_boot_ram(262144 * 4);
    rtl_boot_ram.do_write(0, 20, (uint8_t *)&loader_instr);
    rtl_boot_ram.do_write(0x1000, 8, (uint8_t *)&riscv_test_text_start);

    // setup boot ram
    mmio_mem boot_ram(262144 * 4, "../soft/start.bin");

    // setup uart
    uartlite uart;
    std::thread *uart_input_thread = new std::thread(uart_input, std::ref(uart));
    assert(mmio.add_dev(0x60000000, 0x100000, &boot_ram));
    assert(mmio.add_dev(0x60100000, 0x10000, &uart));
    assert(mmio.add_dev(0x80000000, 262144 * 4, &rtl_boot_ram), "mimo boot ram");

    // setup cemu {
    rv_systembus cemu_system_bus;
    mmio_mem cemu_boot_ram(262144 * 4, "../soft/start.bin");
    uartlite cemu_uart;
    assert(cemu_system_bus.add_dev(0x60000000, 0x100000, &cemu_boot_ram));
    assert(cemu_system_bus.add_dev(0x60100000, 1024 * 1024, &cemu_uart));
    assert(cemu_system_bus.add_dev(0x80000000, 262144 * 4, &cemu_loader_ram), "cemu boot ram");
    rv_core cemu_rvcore(cemu_system_bus, 0);
    cemu_rvcore.jump(0x80000000);
    // setup cemu }

    // connect fst for trace
    top->trace(&fst, 0);
    if (trace_on)
        open_trace();

    uint64_t rst_ticks = 10;
    uint64_t ticks = 0;
    uint64_t last_commit = ticks;

    while (!Verilated::gotFinish() && sim_time > 0 && running)
    {
        if (rst_ticks > 0)
        {
            top->reset = 1;
            rst_ticks--;
        }
        else
            top->reset = 0;
        top->clock = !top->clock;
        if (top->clock && !top->reset)
            mmio_sigs.update_input(mmio_ref);
        top->eval();
        if (top->clock && !top->reset)
        {
            mmio.beat(mmio_sigs_ref);
            mmio_sigs.update_output(mmio_ref);
            top->eval();
            if (uart.exist_tx())
            {
                printf("%c", uart.getc());
                fflush(stdout);
            }
        }
        if (((top->clock && !dual_issue) || (top->debug_pc && dual_issue)) && top->debug_commit)
        { // instr retire
            cemu_rvcore.step(0, 0, 0, 0);
            last_commit = ticks;
            if (top->debug_pc != cemu_rvcore.debug_pc ||
                cemu_rvcore.debug_reg_num != 0 && (top->debug_reg_num != cemu_rvcore.debug_reg_num ||
                                                   top->debug_wdata != cemu_rvcore.debug_reg_wdata))
            {
                printf("\033[1;31mError!\033[0m\n");
                printf("reference: PC = 0x%016lx, wb_rf_wnum = 0x%02x, wb_rf_wdata = 0x%016lx\n", cemu_rvcore.debug_pc, cemu_rvcore.debug_reg_num, cemu_rvcore.debug_reg_wdata);
                printf("mycpu    : PC = 0x%016lx, wb_rf_wnum = 0x%02x, wb_rf_wdata = 0x%016lx\n", top->debug_pc, top->debug_reg_num, top->debug_wdata);
                running = false;
                if (dump_pc_history)
                    cemu_rvcore.dump_pc_history();
            }
        }
        if (trace_on)
        {
            top->eval(); // update rtl status changed by axi, this will only affect waveform
            fst.dump(ticks);
            sim_time--;
        }
        if (trace_start_time != 0 && ticks == trace_start_time)
        {
            open_trace();
        }
        ticks++;
        if (ticks - last_commit >= commit_timeout)
        {
            printf("\033[1;31mError!\033[0m\n");
            printf("CPU stuck for %ld cycles!\n", commit_timeout / 2);
            running = false;
            if (dump_pc_history)
                cemu_rvcore.dump_pc_history();
        }
    }
    if (trace_on)
        fst.close();
    top->final();
    pthread_kill(uart_input_thread->native_handle(), SIGKILL);
    printf("total_ticks: %lu\n", ticks);
}

void linux_run(Vtop_axi_wrapper *top, axi4_ref<32, 64, 4> &mmio_ref)
{
    const char *load_path = "./linux/fw_payload.bin";

    // setup cemu {
    rv_systembus cemu_system_bus;
    mmio_mem cemu_mem(4096l * 1024l * 1024l, load_path);
    uartlite cemu_uart;
    rv_clint<2> cemu_clint;
    rv_plic<4, 4> cemu_plic;

    assert(cemu_system_bus.add_dev(0x2000000, 0x10000, &cemu_clint));
    assert(cemu_system_bus.add_dev(0xc000000, 0x4000000, &cemu_plic));
    assert(cemu_system_bus.add_dev(0x60100000, 1024 * 1024, &cemu_uart), "cemu uart");
    assert(cemu_system_bus.add_dev(0x80000000, 2048l * 1024l * 1024l, &cemu_mem), "cemu mem");

    rv_core cemu_rvcore(cemu_system_bus);
    cemu_rvcore.jump(0x80000000);
    // setup cemu }

    // setup rtl {
    axi4<32, 64, 4> mmio_sigs;
    axi4_ref<32, 64, 4> mmio_sigs_ref(mmio_sigs);
    axi4_xbar<32, 64, 4> mmio;
    rv_clint<2> clint;
    rv_plic<4, 4> plic;

    mmio_mem rtl_mem(4096l * 1024l * 1024l, load_path);

    // setup uart
    uartlite uart;
    std::thread *uart_input_thread = new std::thread(uart_input, std::ref(uart));
    assert(mmio.add_dev(0x2000000, 0x10000, &clint));
    assert(mmio.add_dev(0xc000000, 0x4000000, &plic));
    assert(mmio.add_dev(0x60100000, 1024 * 1024, &uart), "mimo uart");
    assert(mmio.add_dev(0x80000000, 2048l * 1024l * 1024l, &rtl_mem), "mimo mem");
    // setup rtl }

    // connect fst for trace
    top->trace(&fst, 0);
    if (trace_on)
        open_trace();

    uint64_t rst_ticks = 10;
    uint64_t ticks = 0;
    uint64_t last_commit = ticks;
    uint64_t pc_cnt = print_pc_cycle;
    while (!Verilated::gotFinish() && sim_time > 0 && running)
    {
        cemu_clint.tick();
        cemu_plic.update_ext(1, cemu_uart.irq());
        clint.tick();
        plic.update_ext(1, uart.irq());
        // void step(bool meip, bool msip, bool mtip, bool seip) {
        top->MEI = plic.get_int(0);
        top->MSI = clint.m_s_irq(0);
        top->MTI = clint.m_t_irq(0);
        // top->SEI = plic.get_int(1);
        if (rst_ticks > 0)
        {
            top->reset = 1;
            rst_ticks--;
        }
        else
            top->reset = 0;
        top->clock = !top->clock;
        if (top->clock && !top->reset)
            mmio_sigs.update_input(mmio_ref);
        top->eval();
        if (top->clock && !top->reset)
        {
            mmio.beat(mmio_sigs_ref);
            mmio_sigs.update_output(mmio_ref);
            top->eval();
            if (uart.exist_tx())
            {
                printf("%c", uart.getc());
                fflush(stdout);
            }
        }
        if (((top->clock && !dual_issue) || (top->debug_pc && dual_issue)) && top->debug_commit)
        { // instr retire
            cemu_rvcore.step(cemu_plic.get_int(0), cemu_clint.m_s_irq(0), cemu_clint.m_t_irq(0), 0);
            last_commit = ticks;
            if (pc_cnt++ >= print_pc_cycle && print_pc)
            {
                printf("PC = 0x%016lx\n", cemu_rvcore.debug_pc);
                pc_cnt = 0;
            }
            if (top->debug_pc != cemu_rvcore.debug_pc ||
                cemu_rvcore.debug_reg_num != 0 && (top->debug_reg_num != cemu_rvcore.debug_reg_num ||
                                                   top->debug_wdata != cemu_rvcore.debug_reg_wdata))
            {
                printf("\033[1;31mError!\033[0m\n");
                printf("ticks: %ld\n", ticks);
                printf("reference: PC = 0x%016lx, wb_rf_wnum = 0x%02x, wb_rf_wdata = 0x%016lx\n", cemu_rvcore.debug_pc, cemu_rvcore.debug_reg_num, cemu_rvcore.debug_reg_wdata);
                printf("mycpu    : PC = 0x%016lx, wb_rf_wnum = 0x%02x, wb_rf_wdata = 0x%016lx\n", top->debug_pc, top->debug_reg_num, top->debug_wdata);
                running = false;
                if (dump_pc_history)
                    cemu_rvcore.dump_pc_history();
            }
        }
        if (trace_on)
        {
            top->eval();
            fst.dump(ticks);
            sim_time--;
        }
        // conditinal trace
        if (trace_start_time != 0 && ticks == trace_start_time)
        {
            open_trace();
        }
        ticks++;
        if (ticks - last_commit >= commit_timeout)
        {
            printf("\033[1;31mError!\033[0m\n");
            printf("CPU stuck for %ld cycles!\n", commit_timeout / 2);
            running = false;
            if (dump_pc_history)
                cemu_rvcore.dump_pc_history();
        }
    }
    top->final();
    if (trace_on)
        fst.close();
    pthread_kill(uart_input_thread->native_handle(), SIGKILL);
    printf("total_ticks: %lu\n", ticks);
}

void riscv_test_run(Vtop_axi_wrapper *top, axi4_ref<32, 64, 4> &mmio_ref, const char *riscv_test_path)
{

    // setup cemu {
    rv_systembus cemu_system_bus;
    mmio_mem cemu_mem(128 * 1024 * 1024, riscv_test_path);

    assert(cemu_system_bus.add_dev(0x80000000, 128 * 1024 * 1024, &cemu_mem));

    rv_core cemu_rvcore(cemu_system_bus);
    cemu_rvcore.jump(0x80000000);
    // setup cemu }

    // setup rtl {
    axi4<32, 64, 4> mmio_sigs;
    axi4_ref<32, 64, 4> mmio_sigs_ref(mmio_sigs);
    axi4_xbar<32, 64, 4> mmio;

    mmio_mem rtl_mem(128 * 1024 * 1024, riscv_test_path);

    assert(mmio.add_dev(0x80000000, 128 * 1024 * 1024, &rtl_mem));
    // setup rtl }

    // connect Vcd for trace
    if (trace_on)
    {
        top->trace(&fst, 0);
        fst.open("trace.fst");
    }
    uint64_t rst_ticks = 10;
    uint64_t ticks = 0;
    uint64_t last_commit = ticks;
    int delay = 10;
    while (!Verilated::gotFinish() && sim_time > 0 && running)
    {
        if (rst_ticks > 0)
        {
            top->reset = 1;
            rst_ticks--;
        }
        else
            top->reset = 0;
        top->clock = !top->clock;
        if (top->clock && !top->reset)
            mmio_sigs.update_input(mmio_ref);
        top->eval();
        if (top->clock && !top->reset)
        {
            mmio.beat(mmio_sigs_ref);
            mmio_sigs.update_output(mmio_ref);
            top->eval();
        }
        if (((top->clock && !dual_issue) || (top->debug_pc && dual_issue)) && top->debug_commit)
        { // instr retire
            cemu_rvcore.step(0, 0, 0, 0);
            last_commit = ticks;
            if (!cemu_rvcore.debug_pc)
                cemu_rvcore.step(0, 0, 0, 0);
            if (top->debug_pc != cemu_rvcore.debug_pc ||
                cemu_rvcore.debug_reg_num != 0 && (top->debug_reg_num != cemu_rvcore.debug_reg_num ||
                                                   top->debug_wdata != cemu_rvcore.debug_reg_wdata))
            {
                printf("\033[1;31mError!\033[0m\n");
                printf("reference: PC = 0x%016lx, wb_rf_wnum = 0x%02x, wb_rf_wdata = 0x%016lx\n", cemu_rvcore.debug_pc, cemu_rvcore.debug_reg_num, cemu_rvcore.debug_reg_wdata);
                printf("mycpu    : PC = 0x%016lx, wb_rf_wnum = 0x%02x, wb_rf_wdata = 0x%016lx\n", top->debug_pc, top->debug_reg_num, top->debug_wdata);
                if (!should_delay)
                {
                    running = false;
                    if (dump_pc_history)
                        cemu_rvcore.dump_pc_history();
                }
                else if (dump_pc_history && delay-- == 10)
                    cemu_rvcore.dump_pc_history();
                else if (delay-- == 0)
                    running = false;
            }
        }
        if (trace_on)
        {
            fst.dump(ticks);
            sim_time--;
        }
        ticks++;
        if (ticks - last_commit >= commit_timeout)
        {
            printf("\033[1;31mError!\033[0m\n");
            printf("CPU stuck for %ld cycles!\n", commit_timeout / 2);
            running = false;
            if (dump_pc_history)
                cemu_rvcore.dump_pc_history();
        }
    }
    printf("total_ticks: %lu\n", ticks);
}

void make_golden_trace(Vtop_axi_wrapper *top, axi4_ref<32, 64, 4> &mmio_ref, const char *riscv_test_path)
{

    // setup cemu {
    rv_systembus cemu_system_bus;
    mmio_mem cemu_mem(128 * 1024 * 1024, riscv_test_path);

    assert(cemu_system_bus.add_dev(0x80000000, 128 * 1024 * 1024, &cemu_mem));

    rv_core cemu_rvcore(cemu_system_bus);
    cemu_rvcore.jump(0x80000000);
    // setup cemu }

    // setup rtl {
    axi4<32, 64, 4> mmio_sigs;
    axi4_ref<32, 64, 4> mmio_sigs_ref(mmio_sigs);
    axi4_xbar<32, 64, 4> mmio;

    mmio_mem rtl_mem(128 * 1024 * 1024, riscv_test_path);

    assert(mmio.add_dev(0x80000000, 128 * 1024 * 1024, &rtl_mem));
    // setup rtl }

    // connect Vcd for trace
    if (trace_on)
    {
        top->trace(&fst, 0);
        fst.open("trace.fst");
    }

    FILE *golden_trace_file;
    golden_trace_file = fopen("golden_trace.txt", "w");
    if (golden_trace_file == NULL)
    {
        printf("Error opening file!\n");
    }

    uint64_t rst_ticks = 10;
    uint64_t ticks = 0;
    uint64_t last_commit = ticks;
    int delay = 10;
    while (!Verilated::gotFinish() && sim_time > 0 && running)
    {
        if (rst_ticks > 0)
        {
            top->reset = 1;
            rst_ticks--;
        }
        else
            top->reset = 0;
        top->clock = !top->clock;
        if (top->clock && !top->reset)
            mmio_sigs.update_input(mmio_ref);
        top->eval();
        if (top->clock && !top->reset)
        {
            mmio.beat(mmio_sigs_ref);
            mmio_sigs.update_output(mmio_ref);
            top->eval();
        }
        if (((top->clock && !dual_issue) || (top->debug_pc && dual_issue)) && top->debug_commit)
        { // instr retire
            if (top->debug_commit != 0 && top->debug_reg_num != 0)
            {
                fprintf(golden_trace_file, "1 %016lx %02x %016lx\n", top->debug_pc, top->debug_reg_num, top->debug_wdata);
            }
            cemu_rvcore.step(0, 0, 0, 0);
            last_commit = ticks;
            if (!cemu_rvcore.debug_pc)
                cemu_rvcore.step(0, 0, 0, 0);
            if (top->debug_pc == 4 && cemu_rvcore.debug_pc == 0)
            {
                printf("Test passed!\n");
                running = false;
            }
            if ((top->debug_pc != cemu_rvcore.debug_pc ||
                 cemu_rvcore.debug_reg_num != 0 &&
                     (top->debug_reg_num != cemu_rvcore.debug_reg_num ||
                      top->debug_wdata != cemu_rvcore.debug_reg_wdata)) &&
                running)
            {
                printf("\033[1;31mError!\033[0m\n");
                printf("reference: PC = 0x%016lx, wb_rf_wnum = 0x%02x, wb_rf_wdata = 0x%016lx\n", cemu_rvcore.debug_pc, cemu_rvcore.debug_reg_num, cemu_rvcore.debug_reg_wdata);
                printf("mycpu    : PC = 0x%016lx, wb_rf_wnum = 0x%02x, wb_rf_wdata = 0x%016lx\n", top->debug_pc, top->debug_reg_num, top->debug_wdata);
                if (!should_delay)
                {
                    running = false;
                    if (dump_pc_history)
                        cemu_rvcore.dump_pc_history();
                }
                else if (dump_pc_history && delay-- == 10)
                    cemu_rvcore.dump_pc_history();
                else if (delay-- == 0)
                    running = false;
            }
        }
        if (trace_on)
        {
            fst.dump(ticks);
            sim_time--;
        }
        ticks++;
        if (ticks - last_commit >= commit_timeout)
        {
            printf("\033[1;31mError!\033[0m\n");
            printf("CPU stuck for %ld cycles!\n", commit_timeout / 2);
            running = false;
            if (dump_pc_history)
                cemu_rvcore.dump_pc_history();
        }
    }
    printf("total_ticks: %lu\n", ticks);
    fclose(golden_trace_file);
}

int main(int argc, char **argv, char **env)
{
    Verilated::commandArgs(argc, argv);

    std::signal(SIGINT, [](int)
                { running = false; });

    char *file_load_path;
    enum
    {
        NOP,
        WORKBENCH,
        RISCV_TEST,
        LINUX_RUN
    } run_mode = WORKBENCH;

    for (int i = 1; i < argc; i++)
    {
        if (strcmp(argv[i], "-trace") == 0)
        {
            trace_on = true;
            if (i + 1 < argc)
            {
                sscanf(argv[++i], "%lu", &sim_time);
            }
        }
        else if (strcmp(argv[i], "-starttrace") == 0)
        {
            if (i + 1 < argc)
            {
                sscanf(argv[++i], "%lu", &trace_start_time);
            }
            printf("trace start time: %lu\n", trace_start_time);
        }
        else if (strcmp(argv[i], "-rvtest") == 0)
        {
            run_riscv_test = true;
            run_mode = RISCV_TEST;
        }
        else if (strcmp(argv[i], "-linux") == 0)
        {
            run_mode = LINUX_RUN;
        }
        else if (strcmp(argv[i], "-pc") == 0)
        {
            dump_pc_history = true;
        }
        else if (strcmp(argv[i], "-printpc") == 0)
        {
            print_pc = true;
        }
        else if (strcmp(argv[i], "-delay") == 0)
        {
            should_delay = true;
        }
        else if (strcmp(argv[i], "-golden_trace") == 0)
        {
            golden_trace = true;
        }
        else
        {
            file_load_path = argv[i];
        }
    }

    Verilated::traceEverOn(true);

    // setup soc
    Vtop_axi_wrapper *top = new Vtop_axi_wrapper;
    axi4_ptr<32, 64, 4> mmio_ptr;

    connect_wire(mmio_ptr, top);
    assert(mmio_ptr.check());

    axi4_ref<32, 64, 4> mmio_ref(mmio_ptr);

    switch (run_mode)
    {
    case WORKBENCH:
        workbench_run(top, mmio_ref);
        break;
    case RISCV_TEST:
        if (golden_trace)
        {
            make_golden_trace(top, mmio_ref, file_load_path);
        }
        else
        {
            riscv_test_run(top, mmio_ref, file_load_path);
        }
        break;
    case LINUX_RUN:
        linux_run(top, mmio_ref);
        break;
    default:
        printf("Unknown running mode.\n");
        exit(-ENOENT);
    }

    return 0;
}
