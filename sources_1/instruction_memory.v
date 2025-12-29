`timescale 1ns / 1ps

module Instruction_Memory (
    input  [63:0] address,
    output [31:0] instruction
);

    reg [31:0] memory [0:255];

    assign instruction = memory[address[9:2]];

    integer i;
    initial begin
        for (i = 0; i < 256; i = i + 1) begin
            memory[i] = 32'd0;
        end
        
        memory[0] = 32'h00A00093;

        memory[1] = 32'h01400113;

        memory[2] = 32'h002081B3;

        memory[3] = 32'h00302023;

        memory[4] = 32'h00002203;

        memory[5] = 32'hFE418E63;
        
    end

endmodule
