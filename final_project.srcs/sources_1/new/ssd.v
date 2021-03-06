`timescale 1ns / 1ps
`define SSD_BIT_WIDTH 8 // SSD display control bit width
`define SSD_ZERO `SSD_BIT_WIDTH'b0000001_1 // 0
`define SSD_ONE `SSD_BIT_WIDTH'b1001111_1 // 1
`define SSD_TWO `SSD_BIT_WIDTH'b0010010_1 // 2
`define SSD_THREE `SSD_BIT_WIDTH'b000110_1 // 3
`define SSD_FOUR `SSD_BIT_WIDTH'b1001100_1 // 4
`define SSD_FIVE `SSD_BIT_WIDTH'b0100100_1 // 5
`define SSD_SIX `SSD_BIT_WIDTH'b0100000_1 // 6
`define SSD_SEVEN `SSD_BIT_WIDTH'b0001111_1 // 7
`define SSD_EIGHT `SSD_BIT_WIDTH'b0000000_1 // 8
`define SSD_NINE `SSD_BIT_WIDTH'b0001100_1 // 9
`define SSD_DEF `SSD_BIT_WIDTH'b0000000_0 // default

module ssd (display3, display2, display1, display0, ball_position, score_tens, score_ones);
    output reg [0:7] display3, display2, display1, display0;
    input [3:0] score_tens, score_ones;
    input [3:0] ball_position;

    always @(*) begin
        case (score_tens)
            4'd0: display3 = `SSD_ZERO;
            4'd1: display3 = `SSD_ONE;
            4'd2: display3 = `SSD_TWO;
            4'd3: display3 = `SSD_THREE;
            4'd4: display3 = `SSD_FOUR;
            4'd5: display3 = `SSD_FIVE;
            4'd6: display3 = `SSD_SIX;
            4'd7: display3 = `SSD_SEVEN;
            4'd8: display3 = `SSD_EIGHT;
            4'd9: display3 = `SSD_NINE;
            default: display3 = `SSD_DEF;
        endcase
    end

    always @(*) begin
        case (score_ones)
            4'd0: display2 = `SSD_ZERO;
            4'd1: display2 = `SSD_ONE;
            4'd2: display2 = `SSD_TWO;
            4'd3: display2 = `SSD_THREE;
            4'd4: display2 = `SSD_FOUR;
            4'd5: display2 = `SSD_FIVE;
            4'd6: display2 = `SSD_SIX;
            4'd7: display2 = `SSD_SEVEN;
            4'd8: display2 = `SSD_EIGHT;
            4'd9: display2 = `SSD_NINE;
            default: display2 = `SSD_DEF;
        endcase
    end

    always @(*) begin
        case (ball_position)
            4'd15: begin
                display1 = `SSD_ONE;
                display0 = `SSD_FIVE;
            end  
            4'd14: begin
                display1 = `SSD_ONE;
                display0 = `SSD_FOUR;
            end  
            4'd13: begin
                display1 = `SSD_ONE;
                display0 = `SSD_THREE;
            end  
            4'd12: begin
                display1 = `SSD_ONE;
                display0 = `SSD_TWO;
            end  
            4'd11: begin
                display1 = `SSD_ONE;
                display0 = `SSD_ONE;
            end  
            4'd10: begin
                display1 = `SSD_ONE;
                display0 = `SSD_ZERO;
            end  
            4'd9: begin
                display1 = `SSD_ZERO;
                display0 = `SSD_NINE;
            end  
            4'd8: begin
                display1 = `SSD_ZERO;
                display0 = `SSD_EIGHT;
            end  
            4'd7: begin
                display1 = `SSD_ZERO;
                display0 = `SSD_SEVEN;
            end  
            4'd6: begin
                display1 = `SSD_ZERO;
                display0 = `SSD_SIX;
            end  
            4'd5: begin
                display1 = `SSD_ZERO;
                display0 = `SSD_FIVE;
            end  
            4'd4: begin
                display1 = `SSD_ZERO;
                display0 = `SSD_FOUR;
            end  
            4'd3: begin
                display1 = `SSD_ZERO;
                display0 = `SSD_THREE;
            end  
            4'd2: begin
                display1 = `SSD_ZERO;
                display0 = `SSD_TWO;
            end  
            4'd1: begin
                display1 = `SSD_ZERO;
                display0 = `SSD_ONE;
            end  
            4'd0: begin
                display1 = `SSD_ZERO;
                display0 = `SSD_ZERO;
            end  
            default: begin 
                display1 = `SSD_DEF;
                display0 = `SSD_DEF;
            end
        endcase
    end
endmodule