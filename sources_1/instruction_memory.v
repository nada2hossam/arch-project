`timescale 1ns / 1ps

module instruction_memory(
    input  [63:0] address,    
    output [31:0] instruction 
);
    
    reg [31:0] mem [0:255];
    
    assign instruction = mem[address[63:2]];
    
    integer i;
    initial begin
        for (i = 0; i < 256; i = i + 1) begin
            mem[i] = 32'd0;
        end
        
        mem[0]  = 32'h00700013; 
        mem[1]  = 32'h0DC00693; 
        mem[2]  = 32'h00400B13; 
        mem[3]  = 32'h01668833; 
        mem[4]  = 32'h00D84EB3;
        mem[5]  = 32'h016ED133;
        mem[6]  = 32'h40210CB3; 
        mem[7]  = 32'h02203023; 
        mem[8]  = 32'h02003D03; 
        mem[9]  = 32'h002D0463; 
        mem[11] = 32'h01500093;
        mem[12] = 32'h00000013; 
        mem[13] = 32'h00000063;
        
        $display("Instruction Memory: Test program loaded successfully");
    end

endmodule
