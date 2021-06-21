`timescale 1ns / 1ps
module score(score_tens, score_ones, point, clk, rst);
    output reg [3:0] score_tens, score_ones;
    input point, clk, rst;

    reg [3:0] score_tens_next, score_ones_next;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            score_tens <= 4'd0;
            score_ones <= 4'd0; 
        end
        else begin
            score_tens <= score_tens_next;
            score_ones <= score_ones_next; 
        end
    end

     //debounce point
    reg debounced_delay, one_pulse_point;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            debounced_delay <= 1'b0;
        end
        else begin
            debounced_delay <= point;
        end
    end
    wire out_pulse_next;
    
    assign out_pulse_next = point & (~debounced_delay);
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            one_pulse_point <= 1'b0;
        end
        else begin
            one_pulse_point <= out_pulse_next;
        end
    end


    always @(*) begin
        if ((score_ones == 4'd9) && (score_tens == 4'd9)&& (one_pulse_point == 1'b1)) begin
            score_ones_next = 4'd9;
            score_tens_next = 4'd9; 
        end
        else if ((score_ones == 4'd9) && (one_pulse_point == 1'b1)) begin
            score_ones_next = 4'd0;
            score_tens_next = score_tens + 4'd1;
        end
        else if (one_pulse_point) begin
            score_ones_next = score_ones + 4'd1;
            score_tens_next = score_tens;
        end
        else begin
            score_ones_next = score_ones;
            score_tens_next = score_tens;
        end
    end
endmodule
