`timescale 1ns / 1ps
module level (level, switch);
    output reg [1:0] level;
    input [1:0] switch;

    always @(*) begin
        case (switch)
            2'b01: level = 2'b01;
            2'b10: level = 2'b10;
            default: level = 2'b11;
        endcase
    end
endmodule