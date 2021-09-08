`timescale 1ns / 1ps
`define BOUND 50000000
`define FREQ_DIV_BIT 27
module speaker_control(sdin, master_clk, lr_clk, sampling_clk, audio_in_left, audio_in_right, clk, rst);
    output reg  master_clk, lr_clk, sampling_clk;
    output sdin;
    input clk, rst;
    input [15:0] audio_in_left, audio_in_right;
    
    reg [`FREQ_DIV_BIT-1:0] count_master, count_lr, count_sampling;
    reg [5:0] count_output;
    reg [31:0] audio_temp;

    always @(posedge clk) begin
        if (rst) begin
            count_master <= 0;
            master_clk <= 0; 
        end
        else if (count_master == 1) begin
            count_master <= 0;
            master_clk <= ~master_clk; 
        end
        else begin
            count_master <= count_master + 1; 
        end
    end   
    always @(posedge clk) begin
        if (rst) begin
            count_lr <= 0;
            lr_clk <= 0; 
        end
        else if (count_lr == 255) begin
            count_lr <= 0;
            lr_clk <= ~lr_clk; 
        end
        else begin
            count_lr <= count_lr + 1; 
        end
    end    
    always @(posedge clk) begin
        if (rst) begin
            count_sampling <= 0;
            sampling_clk <= 0; 
        end
        else if (count_sampling == 7) begin
            count_sampling <= 0;
            sampling_clk <= ~sampling_clk; 
        end
        else begin
            count_sampling <= count_sampling + 1; 
        end
    end   

    always @(negedge lr_clk) begin
        audio_temp={audio_in_left,audio_in_right};
    end
    assign sdin=audio_temp [count_output];
    always @(negedge sampling_clk) begin
        if (rst) count_output = 31;
        else if (count_output == 0) begin
            count_output = 31;
        end
        else begin
            count_output = count_output - 1;
        end
    end
endmodule