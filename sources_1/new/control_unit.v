`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/23/2025 01:59:43 AM
// Design Name: 
// Module Name: control_unit
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

module control_unit (
    input  wire [31:0] instr,  
    output reg         RegWrite,
    output reg         MemWrite,
    output reg         MemRead,
    output reg         ALUSrc,
    output reg         MemToReg,
    output reg         Branch,
    output reg  [3:0]  ALUctl    
);

    wire [6:0] opcode = instr[6:0];
    wire [2:0] funct3 = instr[14:12];
    wire [6:0] funct7 = instr[31:25];

    localparam [6:0] OP_RTYPE  = 7'b0110011;
    localparam [6:0] OP_ITYPE  = 7'b0010011;
    localparam [6:0] OP_LOAD   = 7'b0000011;
    localparam [6:0] OP_STORE  = 7'b0100011;
    localparam [6:0] OP_BRANCH = 7'b1100011;

    localparam [3:0] ALU_ADD = 4'b0000;
    localparam [3:0] ALU_SUB = 4'b0001;
    localparam [3:0] ALU_AND = 4'b0010;
    localparam [3:0] ALU_OR  = 4'b0011;
    localparam [3:0] ALU_XOR = 4'b0100;
    localparam [3:0] ALU_SLL = 4'b0101;
    localparam [3:0] ALU_SRL = 4'b0110;

    always @* begin
        RegWrite = 1'b0;
        MemWrite = 1'b0;
        MemRead  = 1'b0;
        ALUSrc   = 1'b0;
        MemToReg = 1'b0;
        Branch   = 1'b0;
        ALUctl   = ALU_ADD;

        case (opcode)

            OP_RTYPE: begin
                RegWrite = 1'b1;
                ALUSrc   = 1'b0;
                MemRead  = 1'b0;
                MemWrite = 1'b0;
                MemToReg = 1'b0;
                Branch   = 1'b0;

                case (funct3)
                    3'b000: ALUctl = (funct7 == 7'b0100000) ? ALU_SUB : ALU_ADD; 
                    3'b111: ALUctl = ALU_AND;
                    3'b110: ALUctl = ALU_OR;
                    3'b100: ALUctl = ALU_XOR;
                    3'b001: ALUctl = ALU_SLL;  
                    3'b101: ALUctl = ALU_SRL;  
                    default: ALUctl = ALU_ADD;
                endcase
            end

           
            OP_ITYPE: begin
                RegWrite = 1'b1;
                ALUSrc   = 1'b1; 
                MemRead  = 1'b0;
                MemWrite = 1'b0;
                MemToReg = 1'b0;
                Branch   = 1'b0;

                case (funct3)
                    3'b000: ALUctl = ALU_ADD; 
                    3'b111: ALUctl = ALU_AND; 
                    3'b110: ALUctl = ALU_OR;  
                    3'b100: ALUctl = ALU_XOR; 
                    3'b001: ALUctl = ALU_SLL; 
                    3'b101: ALUctl = ALU_SRL; 
                    default: ALUctl = ALU_ADD;
                endcase
            end

            
            OP_LOAD: begin
                RegWrite = 1'b1;
                MemRead  = 1'b1;
                MemWrite = 1'b0;
                ALUSrc   = 1'b1; 
                MemToReg = 1'b1; 
                Branch   = 1'b0;
                ALUctl   = ALU_ADD; 
            end

            
            OP_STORE: begin
                RegWrite = 1'b0;
                MemRead  = 1'b0;
                MemWrite = 1'b1;
                ALUSrc   = 1'b1; 
                MemToReg = 1'b0;
                Branch   = 1'b0;
                ALUctl   = ALU_ADD; 
            end

           
            OP_BRANCH: begin
                RegWrite = 1'b0;
                MemRead  = 1'b0;
                MemWrite = 1'b0;
                ALUSrc   = 1'b0; 
                MemToReg = 1'b0;
                Branch   = 1'b1;
                ALUctl   = ALU_SUB; 
            end

            default: begin
                RegWrite = 1'b0;
                MemWrite = 1'b0;
                MemRead  = 1'b0;
                ALUSrc   = 1'b0;
                MemToReg = 1'b0;
                Branch   = 1'b0;
                ALUctl   = ALU_ADD;
            end
        endcase
    end

endmodule
