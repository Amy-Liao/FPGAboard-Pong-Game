`timescale 1ns / 1ps
module random_num(ball_position, out_new, clk, rst);
    output reg [3:0] ball_position;
    input out_new, clk, rst;

    reg feedback;
    reg [5:0] random, random_next;
    
    always @(*) begin
        feedback = random_next[1] ^ random_next[0];
    end
    
    always @(posedge clk) begin
        if (rst) begin
            random <= 6'b111111;
        end
        else begin
            random <= random_next;
        end
    end

    //LFSR
    always @(* ) begin
        if (rst) begin
            random_next = 6'b111111;
        end
        else begin
            random_next = {{feedback}, {random[5:1]}};
        end
    end
    
    //debounce out_new
    reg debounced_delay, one_pulse_new;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            debounced_delay <= 1'b0;
        end
        else begin
            debounced_delay <= out_new;
        end
    end
    wire out_pulse_next;
    
    assign out_pulse_next = out_new & (~debounced_delay);
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            one_pulse_new <= 1'b0;
        end
        else begin
            one_pulse_new <= out_pulse_next;
        end
    end
       
    //send new ball_position for every one out_new signal
    always @(*) begin
        if (rst) begin
            ball_position = 4'd0;
        end
        else if (one_pulse_new) begin
            ball_position = random[3:0];
        end
        else begin
            ball_position = ball_position;
        end
    end
endmodule
