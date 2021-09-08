`timescale 1ns / 1ps
module get_point (next, paddle_posL, ball_position, level, clk, rst, en);
    output reg next;
    input [3:0] paddle_posL, ball_position;
    input [1:0] level;
    input clk, rst, en;

    always @(posedge clk) begin
        if (rst || ~en) begin
            next = 1'b0;
        end
        else if (level == 2'b01) begin
            if ((ball_position <= paddle_posL) && (ball_position >= paddle_posL-4'd4)) begin
                next = 1'b1;
            end
            else begin
                next = 1'b0;
            end
        end
        else if (level == 2'b10) begin
            if ((ball_position <= paddle_posL) && (ball_position >= paddle_posL-4'd2)) begin
                next = 1'b1;
            end
            else begin
                next = 1'b0;
            end
        end
        else begin
            next = 1'b0;
        end
    end
endmodule