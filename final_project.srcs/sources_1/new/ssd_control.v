`timescale 1ns / 1ps
module ssd_control(display_control, display, ssd_control_en, display0, display1, display2, display3);
    output [3:0] display_control;
    output [0:7] display;
    input [1:0] ssd_control_en;
    input [0:7] display0, display1, display2, display3;
    
    reg [0:7] display;
    reg [3:0] display_control;
    
    always @(ssd_control_en or display0 or display1 or display2 or display3) begin
        case(ssd_control_en)
            2'b00: display = display0;
            2'b01: display = display1;
            2'b10: display = display2;
            2'b11: display = display3;
            default : display = 8'd0;
        endcase
      end        
    always @(ssd_control_en) begin
        case(ssd_control_en)
            2'b00: display_control = 4'b1110;
            2'b01: display_control = 4'b1101;
            2'b10: display_control = 4'b1011;
            2'b11: display_control = 4'b0111;
            default : display_control= 4'b1111;
        endcase
     end    
endmodule