module top(
    input       clock,
    input       reset,
    // Interrupts
    input       mei, // to PLIC
    input       msi, // to CLINT
    input       mti, // to CLINT
    input       sei, // to PLIC
    // aw
    output [3:0]axi_awid,
    output[31:0]axi_awaddr,
    output [7:0]axi_awlen,
    output [2:0]axi_awsize,
    output [1:0]axi_awburst,
    output      axi_awvalid,
    input       axi_awready,
    // w
    output[63:0]axi_wdata,
    output [7:0]axi_wstrb,
    output      axi_wlast,
    output      axi_wvalid,
    input       axi_wready,
    // b
    input  [3:0]axi_bid,
    input  [1:0]axi_bresp,
    input       axi_bvalid,
    output      axi_bready,
    // ar
    output [3:0]axi_arid,
    output[31:0]axi_araddr,
    output [7:0]axi_arlen,
    output [2:0]axi_arsize,
    output [1:0]axi_arburst,
    output      axi_arvalid,
    input       axi_arready,
    // r
    input  [3:0]axi_rid,
    input [63:0]axi_rdata,
    input  [1:0]axi_rresp,
    input       axi_rlast,
    input       axi_rvalid,
    output      axi_rready,
    // debug
    output      debug_commit,
    output[63:0]debug_pc,
    output[4:0] debug_rf_wnum,
    output[63:0]debug_rf_wdata
);

PuaCpu core(
    .clock                    (clock),
    .reset                    (reset),
    // Interrupts     
    .io_ext_int_mei           (mei), // to PLIC
    .io_ext_int_msi           (msi), // to CLINT
    .io_ext_int_mti           (mti), // to CLINT
    .io_ext_int_sei           (sei), // to PLIC
    // aw 
    .io_axi_aw_bits_id        (axi_awid),
    .io_axi_aw_bits_addr      (axi_awaddr),
    .io_axi_aw_bits_len       (axi_awlen),
    .io_axi_aw_bits_size      (axi_awsize),
    .io_axi_aw_bits_burst     (axi_awburst),
    .io_axi_aw_valid          (axi_awvalid),
    .io_axi_aw_ready          (axi_awready),
    // w 
    .io_axi_w_bits_data       (axi_wdata),
    .io_axi_w_bits_strb       (axi_wstrb),
    .io_axi_w_bits_last       (axi_wlast),
    .io_axi_w_valid           (axi_wvalid),
    .io_axi_w_ready           (axi_wready),
    // b 
    .io_axi_b_bits_id         (axi_bid),
    .io_axi_b_bits_resp       (axi_bresp),
    .io_axi_b_valid           (axi_bvalid),
    .io_axi_b_ready           (axi_bready),
    // ar 
    .io_axi_ar_bits_id        (axi_arid),
    .io_axi_ar_bits_addr      (axi_araddr),
    .io_axi_ar_bits_len       (axi_arlen),
    .io_axi_ar_bits_size      (axi_arsize),
    .io_axi_ar_bits_burst     (axi_arburst),
    .io_axi_ar_valid          (axi_arvalid),
    .io_axi_ar_ready          (axi_arready),
    // r 
    .io_axi_r_bits_id         (axi_rid),
    .io_axi_r_bits_data       (axi_rdata),
    .io_axi_r_bits_resp       (axi_rresp),
    .io_axi_r_bits_last       (axi_rlast),
    .io_axi_r_valid           (axi_rvalid),
    .io_axi_r_ready           (axi_rready),
    // debug
    .io_debug_pc              (debug_pc),
    .io_debug_commit          (debug_commit),
    .io_debug_rf_wnum         (debug_rf_wnum),
    .io_debug_rf_wdata        (debug_rf_wdata)
);

endmodule