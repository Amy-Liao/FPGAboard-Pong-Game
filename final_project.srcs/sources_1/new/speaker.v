`timescale 1ns / 1ps
module speaker (mclk, lrclk, sclk, sdin, timeout, clk, slower_clk, rst);
    output mclk, lrclk, sclk, sdin;
    input clk, slower_clk, rst, timeout;

    reg music_start;
    reg [2:0] counter, counter_next;
    reg [21:0] tone_freq;
    wire [21:0] note_div;

    //set music start system
    always @(posedge timeout or posedge rst) begin
        if (rst) begin
            music_start = 1'b0;
        end
        else begin
            if (timeout) begin
                music_start = 1'b1;
            end
            else if (counter == 3'd5) begin
                music_start = 1'b0;
            end
            else begin
                music_start = 1'b0;
            end
        end
    end

    //counter for tone
    always @(*) begin
        if (rst) begin
            counter_next = 3'd0;
        end
        else if (counter == 3'd5) begin
            counter_next = 3'd0;
        end
        else if (music_start)begin
            counter_next = counter + 3'd1;
        end
        else begin
            counter_next = counter;
        end
    end
    always @(posedge slower_clk or posedge rst) 
    begin
        if (rst)   counter <= 3'd0;
        else counter <= counter_next;
    end

    //assign tone
    always @* begin
        case (counter)
            4'd0:  begin//default
                tone_freq = 22'd0;
            end
            4'd1: //Fa
                tone_freq = 22'd143266; //note_div value
            4'd2: //La
                tone_freq = 22'd113636;
            4'd3: //So
                tone_freq = 22'd127551;
            4'd4: //Si
                tone_freq = 22'd101214;
            4'd5: //high_Do
                tone_freq = 22'd95419;
            default:
                tone_freq = 22'd0;
        endcase     
    end
    assign note_div = tone_freq;
    wire [15:0] audio_in_left, audio_in_right;

    note_gen NG0(.audio_left(audio_in_left), .audio_right(audio_in_right), .note_div(note_div), .clk(clk), .rst(rst));
    speaker_control SP0(.sdin(sdin), .master_clk(mclk), .lr_clk(lrclk), .sampling_clk(sclk), .audio_in_left(audio_in_left), .audio_in_right(audio_in_right), .clk(clk), .rst(rst));
endmodule