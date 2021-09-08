`timescale 1ns / 1ps
module top(LED, display, ssd_control, mclk, lrclk, sclk, sdin, switch, PS2_DATA, PS2_CLK, clk, rst, start);
    output [15:0] LED;
    output [0:7] display;
    output [3:0] ssd_control;
    input [1:0] switch;
    output mclk, lrclk, sclk, sdin;
    inout wire PS2_DATA;
	inout wire PS2_CLK;
    input clk, rst, start;

    //clock divider
    wire clk_25MHz, clk1Hz, slower_clk;
    wire [1:0] ssd_control_en;
    frequency_divider FD0(.clk25M(clk_25MHz), .clk1Hz(clk1Hz), .slower_clk(slower_clk), .ssd_control_en(ssd_control_en), .clk(clk), .rst(rst));

    //level select
    wire [1:0] level;
    level L0 (.level(level), .switch(switch));

    //timer
    wire en, timeout;
    timer T0 (.en(en), .timeout(timeout), .clk(clk1Hz), .rst_btn(rst), .start_btn(start));

    //game
    wire [3:0] score_tens, score_ones;
    wire [3:0] ball_position;
    game GE0(.LED(LED), .ball_position(ball_position), .score_tens(score_tens), .score_ones(score_ones), .level(level), .en(en), .slower_clk(slower_clk), .PS2_DATA(PS2_DATA), .PS2_CLK(PS2_CLK), .clk(clk), .rst(rst));

    //speaker
    speaker SP0 (.mclk(mclk), .lrclk(lrclk), .sclk(sclk), .sdin(sdin), .timeout(timeout), .slower_clk(slower_clk), .clk(clk), .rst(rst));

    //ssd
    wire [0:7] display0, display1, display2, display3;
    ssd S0(.display0(display0), .display1(display1), .display2(display2), .display3(display3), .ball_position(ball_position), .score_tens(score_tens), .score_ones(score_ones));
    ssd_control SD0 (.display_control(ssd_control), .display(display), .ssd_control_en(ssd_control_en), .display0(display0), .display1(display1), .display2(display2), .display3(display3));
endmodule
