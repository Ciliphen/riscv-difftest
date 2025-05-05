module top(
    input         clock,
    input         reset,
    // Interrupts
    input         mei, // to PLIC
    input         msi, // to CLINT
    input         mti, // to CLINT
    input         sei, // to PLIC
    // inst sram interface
    output        inst_sram_en,
    output [ 3:0] inst_sram_wen,
    output [31:0] inst_sram_addr,
    output [31:0] inst_sram_wdata,
    input  [31:0] inst_sram_rdata,
    // data sram interface
    output        data_sram_en,
    output [ 7:0] data_sram_wen,
    output [31:0] data_sram_addr,
    output [63:0] data_sram_wdata,
    input  [63:0] data_sram_rdata,
    // trace debug interface
    output        debug_commit,
    output [63:0] debug_pc,
    output [4:0 ] debug_rf_wnum,
    output [63:0] debug_rf_wdata
);

PuaCpu core(
    .clock                    (clock),
    .reset                    (reset),
    // interrupts     
    .io_ext_int_mei           (mei),
    .io_ext_int_mti           (mti),
    .io_ext_int_msi           (msi),
    // inst sram interface 
    .io_inst_sram_en          (inst_sram_en),
    .io_inst_sram_wen         (inst_sram_wen),
    .io_inst_sram_addr        (inst_sram_addr),
    .io_inst_sram_wdata       (inst_sram_wdata),
    .io_inst_sram_rdata       (inst_sram_rdata),
    // data sram interface
    .io_data_sram_en          (data_sram_en),
    .io_data_sram_wen         (data_sram_wen),
    .io_data_sram_addr        (data_sram_addr),
    .io_data_sram_wdata       (data_sram_wdata),
    .io_data_sram_rdata       (data_sram_rdata),
    // debug
    .io_debug_pc              (debug_pc),
    .io_debug_commit          (debug_commit),
    .io_debug_rf_wnum         (debug_rf_wnum),
    .io_debug_rf_wdata        (debug_rf_wdata)
);

endmodule
