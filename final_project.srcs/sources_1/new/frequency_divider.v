`timescale 1ns / 1ps
`define FREQ_DIV_BIT 27
module frequency_divider(clk25M, clk1Hz, ssd_control_en, slower_clk, clk, rst);
    input clk, rst;
    output [1:0] ssd_control_en;
    output clk25M,  clk1Hz, slower_clk;
    
    reg [1:0] num;
    wire [1:0] next_num;
    reg [`FREQ_DIV_BIT-1:0] count;
    reg clk1Hz;

    assign slower_clk = count[23];
    assign ssd_control_en = count[20:19];

    always @(posedge clk) begin
      num <= next_num;
    end
    always@(posedge clk)
    begin
        if (rst) begin
            count=0;
            clk1Hz=0; end
        else if (count == 50000000) begin
            count = 0;
            clk1Hz = ~clk1Hz; end
        else begin
            count = count+1; end
    end
    assign next_num = num + 1'b1;
    assign clk25M = num[1];
endmodule