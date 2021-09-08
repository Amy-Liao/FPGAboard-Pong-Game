`timescale 1ns / 1ps
module random_num(ball_position, out_new, paddle_posL, level, clk, rst);
    output reg [3:0] ball_position;
    input [3:0] paddle_posL;
    input [1:0] level;
    input out_new, clk, rst;

    reg feedback;
    reg [5:0] random, random_next;
    reg [3:0] ball_position_next;
    reg [3:0] width;
    
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

    //ball_oposition value assignment
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            ball_position <= 4'd0;
        end
        else begin
            ball_position <= ball_position_next;
        end
    end
    always @(*) begin
        case(level)
            2'b01: width = 4'd5;
            2'b10: width = 4'd3;
            default: width = 4'd5;
        endcase
    end
    always @(*) begin
        if (one_pulse_new) begin
            if ((random[3:0] <= paddle_posL) && (random[3:0] >= paddle_posL-width)) begin
                if (paddle_posL - 4'd5 >= 4'd0) ball_position_next = paddle_posL - 4'd5;
                else ball_position_next = paddle_posL + 4'd5;
            end
            else begin
                ball_position_next = random[3:0];
            end
        end
        else begin
            ball_position_next = ball_position;
        end
    end
endmodule