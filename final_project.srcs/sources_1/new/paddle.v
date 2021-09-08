`timescale 1ns / 1ps
module paddle (paddle_posL, level, left, right, clk, rst, en);
    output reg [3:0] paddle_posL;
    input [1:0] level;
    input left, right;
    input rst, clk, en;

    reg [3:0] next_paddle_posL;
    always @(*) begin
        if (rst || ~en) begin
            next_paddle_posL = 4'd9;
        end
        else if ((paddle_posL == 4'd15) && ((level == 2'b10)||(level == 2'b01)) && (left == 1'b1)) begin
            next_paddle_posL = 4'd15;
        end
        else if ((paddle_posL == 4'd4) && (level == 2'b01) && (right == 1'b1)) begin
           next_paddle_posL = 4'd4; 
        end
        else if ((paddle_posL == 4'd2) && (level == 2'b10) && (right == 1'b1)) begin
           next_paddle_posL = 4'd2; 
        end
        else if (left) begin
            next_paddle_posL = paddle_posL + 4'd1;
        end
        else if (right) begin
            next_paddle_posL = paddle_posL - 4'd1;
        end
        else begin
            next_paddle_posL = paddle_posL;
        end
    end
    
    always @(posedge clk or posedge rst) begin
        if (rst || ~en) begin
            paddle_posL <= 4'd9;
        end
        else begin
            paddle_posL <= next_paddle_posL;
        end
    end
endmodule