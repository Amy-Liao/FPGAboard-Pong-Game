`timescale 1ns / 1ps
module game (LED, score_tens, score_ones, ball_position, level, en,  PS2_DATA, PS2_CLK, slower_clk, clk1Hz, clk, rst);
    output reg [15:0] LED;
    output [3:0] ball_position;
    output [3:0] score_tens, score_ones;
    input [1:0] level;
    inout wire PS2_DATA;
    inout wire PS2_CLK;
    input en, slower_clk, clk1Hz, clk, rst;

//keyboard
    reg left, right;
    wire[511:0] key_down;
    wire [8:0] last_change;
    wire key_valid;
    //specify left or right
    always @(posedge slower_clk) begin
        if (rst) begin
            left = 1'b0;
            right = 1'b0;
        end
        else if ((key_down[{1'b0, 8'h1C}] == 1'b1) && (key_down[{1'b0, 8'h23}] == 1'b0)) begin
            left = 1'b1;
            right = 1'b0;
        end
        else if ((key_down[{1'b0, 8'h23}] == 1'b1) && (key_down[{1'b0, 8'h1C}] == 1'b0) ) begin
            left = 1'b0;
            right = 1'b1;
        end
        else begin
            left = 1'b0;
            right = 1'b0;
        end
    end
    assign left_wire = left;
    assign right_wire  = right;
    KeyboardDecoder KD0(.key_down(key_down), .last_change(last_change), .key_valid(key_valid), 
        .PS2_DATA(PS2_DATA), .PS2_CLK(PS2_CLK), .rst(rst), .clk(clk));

//paddle
    wire [3:0] paddle_posL;
    paddle PD0 (.paddle_posL(paddle_posL), .level(level), .left(left_wire), .right(right_wire), .clk(slower_clk), .rst(rst));

//random number generator
    // wire out_new;
    // assign out_new = 1;
    wire next;
    random_num RN0 (.ball_position(ball_position), .out_new(next), .clk(slower_clk), .rst(rst));
    
//determine if we get one point
    get_point GP0 (.next(next), .paddle_posL(paddle_posL), .ball_position(ball_position), .level(level), .clk(slower_clk), .rst(rst));

//record score
    // wire [6:0] score;
    score S0 (.score_tens(score_tens), .score_ones(score_ones), .point(next), .clk(slower_clk), .rst(rst));

//LED  
    always@ (*) begin
        case (level)
            2'b01: begin
                case (paddle_posL)
                    4'd15: LED = {{5{1'b1}}, {11{1'b0}}}; 
                    4'd14: LED = {{1{1'b0}}, {5{1'b1}}, {10{1'b0}}}; 
                    4'd13: LED = {{2{1'b0}}, {5{1'b1}}, {9{1'b0}}}; 
                    4'd12: LED = {{3{1'b0}}, {5{1'b1}}, {8{1'b0}}}; 
                    4'd11: LED = {{4{1'b0}}, {5{1'b1}}, {7{1'b0}}}; 
                    4'd10: LED = {{5{1'b0}}, {5{1'b1}}, {6{1'b0}}}; 
                    4'd9: LED = {{6{1'b0}}, {5{1'b1}}, {5{1'b0}}}; 
                    4'd8: LED = {{7{1'b0}}, {5{1'b1}}, {4{1'b0}}}; 
                    4'd7: LED = {{8{1'b0}}, {5{1'b1}}, {3{1'b0}}}; 
                    4'd6: LED = {{9{1'b0}}, {5{1'b1}}, {2{1'b0}}}; 
                    4'd5: LED = {{10{1'b0}},{5{1'b1}}, {1{1'b0}}}; 
                    4'd4: LED = {{11{1'b0}},{5{1'b1}}}; 
                    default: LED = {{6{1'b0}}, {5{1'b1}}, {5{1'b0}}}; 
                endcase
            end
            2'b10: begin
                case (paddle_posL)
                    4'd15: LED = {{3{1'b1}}, {11{1'b0}}}; 
                    4'd14: LED = {{1{1'b0}}, {3{1'b1}}, {12{1'b0}}}; 
                    4'd13: LED = {{2{1'b0}}, {3{1'b1}}, {11{1'b0}}}; 
                    4'd12: LED = {{3{1'b0}}, {3{1'b1}}, {10{1'b0}}}; 
                    4'd11: LED = {{4{1'b0}}, {3{1'b1}}, {9{1'b0}}}; 
                    4'd10: LED = {{5{1'b0}}, {3{1'b1}}, {8{1'b0}}}; 
                    4'd9: LED = {{6{1'b0}}, {3{1'b1}}, {7{1'b0}}}; 
                    4'd8: LED = {{7{1'b0}}, {3{1'b1}}, {6{1'b0}}}; 
                    4'd7: LED = {{8{1'b0}}, {3{1'b1}}, {5{1'b0}}}; 
                    4'd6: LED = {{9{1'b0}}, {3{1'b1}}, {4{1'b0}}}; 
                    4'd5: LED = {{10{1'b0}},{ 3{1'b1}}, {3{1'b0}}}; 
                    4'd4: LED = {{11{1'b0}},{ 3{1'b1}}, {2{1'b0}}}; 
                    4'd3: LED = {{12{1'b0}},{ 3{1'b1}}, {1{1'b0}}}; 
                    4'd2: LED = {{13{1'b0}},{ 3{1'b1}}};  
                    default: LED = {{8{1'b0}}, {3{1'b1}}, {5{1'b0}}};
                endcase
            end
            default: LED = {16{1'b1}}; 
        endcase  
    end
    
//    assign ball_position = 4'd3;
//    assign next = 1;
    
endmodule