`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/21/2025 08:20:00 PM
// Design Name: 
// Module Name: RISCVALU_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module RISCVALU_tb;

    reg [3:0] ALUctl;
    reg signed [63:0] A, B;
    wire [63:0] ALUout;
    wire Zero;

    RISCVALU DUT (
        .ALUctl(ALUctl),
        .A(A),
        .B(B),
        .ALUout(ALUout),
        .Zero(Zero)
    );

    initial begin
        $display("===== Starting Full ALU Test =====");

        // TEST 1: ADD
        ALUctl = 4'b0000; A = 64'd12; B = 64'd8; #10;
        $display("ADD 12 + 8 = %0d, Zero=%b", ALUout, Zero);

        // TEST 2: SUB
        ALUctl = 4'b0001; A = 64'd20; B = 64'd5; #10;
        $display("SUB 20 - 5 = %0d, Zero=%b", ALUout, Zero);

        // TEST 3: AND
        ALUctl = 4'b0010; A = 64'hF0F0_F0F0_F0F0_F0F0; B = 64'h0FF0_0FF0_0FF0_0FF0; #10;
        $display("AND = 0x%h, Zero=%b", ALUout, Zero);

        // TEST 4: OR
        ALUctl = 4'b0011; A = 64'hAAAA_AAAA_AAAA_AAAA; B = 64'h5555_5555_5555_5555; #10;
        $display("OR = 0x%h, Zero=%b", ALUout, Zero);

        // TEST 5: XOR
        ALUctl = 4'b0100; A = 64'hFFFF_0000_FFFF_0000; B = 64'h0000_FFFF_0000_FFFF; #10;
        $display("XOR = 0x%h, Zero=%b", ALUout, Zero);

        // TEST 6: SLL
        ALUctl = 4'b0101; A = 64'd3; B = 64'd2; #10;
        $display("SLL 3 <<< 2 = %0d, Zero=%b", ALUout, Zero);

        // TEST 7: SRL
        ALUctl = 4'b0110; A = 64'd16; B = 64'd3; #10;
        $display("SRL 16 >>> 3 = %0d, Zero=%b", ALUout, Zero);

        // TEST 8: SRA
        ALUctl = 4'b0111; A = -64'd16; B = 64'd2; #10;
        $display("SRA -16 >>> 2 = %0d, Zero=%b", ALUout, Zero);

        // TEST 9: SLT signed
        ALUctl = 4'b1000; A = -64'd5; B = 64'd10; #10;
        $display("SLT signed -5 < 10 = %0d, Zero=%b", ALUout, Zero);

        // TEST 10: SLTU unsigned
        ALUctl = 4'b1001; A = 64'd5; B = 64'd10; #10;
        $display("SLTU unsigned 5 < 10 = %0d, Zero=%b", ALUout, Zero);

        $display("===== Full ALU Test Completed =====");
        $stop;
    end

endmodule
