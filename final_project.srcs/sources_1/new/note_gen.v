`timescale 1ns / 1ps
module note_gen(audio_left, audio_right, note_div, clk, rst);
    output [15:0] audio_left, audio_right; 
    input clk, rst; 
    input [21:0] note_div; 
        
    reg [21:0]clk_cnt;
    reg b_clk; 
    always @(posedge clk) begin
        if (rst) begin
            clk_cnt = 0;
            b_clk = 0;
        end
        else if (clk_cnt == note_div) begin
            b_clk = ~b_clk;
            clk_cnt = 0;
        end
        else begin
            clk_cnt = clk_cnt + 1;
        end
    end
    
    // Assign the amplitude of the note
    assign audio_left = (b_clk == 1'b0) ? 16'b0100_0110_0101_0000 : 16'b1011_1001_1011_0000;
    assign audio_right = (b_clk == 1'b0) ? 16'b0100_0110_0101_0000 : 16'b1011_1001_1011_0000;
endmodule