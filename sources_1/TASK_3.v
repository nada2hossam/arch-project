

`timescale 1ns / 1ps

// ============================================================
// MODULE 1: Register File
// ============================================================
module RegisterFile (
    input wire clk,
    input wire RegWrite,
    input wire [4:0] ReadReg1,
    input wire [4:0] ReadReg2,
    input wire [4:0] WriteReg,
    input wire [63:0] WriteData,
    output wire [63:0] ReadData1,
    output wire [63:0] ReadData2
);
    reg [63:0] registers [0:31];
    
    integer i;
    initial begin
        for (i = 0; i < 32; i = i + 1) begin
            registers[i] = 64'b0;
        end
    end

    assign ReadData1 = (ReadReg1 == 5'b00000) ? 64'b0 : registers[ReadReg1];
    assign ReadData2 = (ReadReg2 == 5'b00000) ? 64'b0 : registers[ReadReg2];

    always @(posedge clk) begin
        if (RegWrite && (WriteReg != 5'b00000)) begin
            registers[WriteReg] <= WriteData;
        end
    end
endmodule

// ============================================================
// MODULE 2: Immediate Generator
// ============================================================
module ImmediateGenerator (
    input wire [31:0] instruction,
    output reg [63:0] immediate
);
    wire [6:0] opcode;
    assign opcode = instruction[6:0];
    
    always @(*) begin
        case (opcode)
            7'b0010011,
            7'b0000011: begin
                immediate = {{52{instruction[31]}}, instruction[31:20]};
            end
            
            7'b0100011: begin
                immediate = {{52{instruction[31]}}, instruction[31:25], instruction[11:7]};
            end
            
            7'b1100011: begin
                immediate = {{51{instruction[31]}},
                             instruction[31],
                             instruction[7],
                             instruction[30:25],
                             instruction[11:8],
                             1'b0};
            end
            
            default: begin
                immediate = 64'b0;
            end
        endcase
    end
endmodule

