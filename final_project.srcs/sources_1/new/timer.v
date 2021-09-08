`timescale 1ns / 1ps
module timer(en, timeout, clk, rst_btn, start_btn);
    output reg en;
    output timeout;
    input clk, rst_btn, start_btn;
    
    reg counter_start;
    reg [4:0] counter, counter_next;
    always @(posedge clk or posedge rst_btn) begin
        if (rst_btn) counter <= 5'd0;
        else counter <= counter_next;
    end
    
    //set the start system for timer
    always @(posedge start_btn or posedge rst_btn) begin
        if (rst_btn) begin
            counter_start = 1'b0;
        end
        else begin
            if (start_btn) begin
                counter_start = 1'b1;
            end
            else begin
                counter_start = 1'b0;
            end
        end
    end
    always @(*) begin
        if (rst_btn) begin
            counter_next = 5'd0;
        end
        else if (counter == 5'd21) begin
            counter_next = counter;
        end
        else if (counter_start)begin
            counter_next = counter + 5'd1;
        end
        else begin
            counter_next = counter;
        end
    end
    
    //set en value
    always@(*) begin
        if (rst_btn) begin
            en = 0;
        end
        else if (counter == 5'd21) begin
            en = 0;
        end
        else if (counter <5'd22 && counter>=5'd1) begin
            en = 1;
        end
        else begin
            en = en;
        end
    end
    assign timeout = (counter==5'd21)? 1'b1:1'b0;
endmodule