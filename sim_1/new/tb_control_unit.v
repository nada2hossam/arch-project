`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/23/2025 02:00:44 AM
// Design Name: 
// Module Name: tb_control_unit
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

module tb_control_unit;

    reg  [31:0] instr;
    wire        RegWrite, MemWrite, MemRead, ALUSrc, MemToReg, Branch;
    wire [3:0]  ALUctl;

    control_unit DUT (
        .instr    (instr),
        .RegWrite (RegWrite),
        .MemWrite (MemWrite),
        .MemRead  (MemRead),
        .ALUSrc   (ALUSrc),
        .MemToReg (MemToReg),
        .Branch   (Branch),
        .ALUctl   (ALUctl)
    );

    localparam [3:0] ALU_ADD = 4'b0000;
    localparam [3:0] ALU_SUB = 4'b0001;
    localparam [3:0] ALU_AND = 4'b0010;
    localparam [3:0] ALU_OR  = 4'b0011;
    localparam [3:0] ALU_XOR = 4'b0100;
    localparam [3:0] ALU_SLL = 4'b0101;
    localparam [3:0] ALU_SRL = 4'b0110;

    function [31:0] make_rtype;
        input [6:0] funct7;
        input [4:0] rs2;
        input [4:0] rs1;
        input [2:0] funct3;
        input [4:0] rd;
        begin
            make_rtype = {funct7, rs2, rs1, funct3, rd, 7'b0110011};
        end
    endfunction

    function [31:0] make_itype;
        input [11:0] imm;
        input [4:0]  rs1;
        input [2:0]  funct3;
        input [4:0]  rd;
        begin
            make_itype = {{20{imm[11]}}, imm, rs1, funct3, rd, 7'b0010011};
        end
    endfunction

    function [31:0] make_load;
        input [11:0] imm;
        input [4:0]  rs1;
        input [2:0]  funct3;
        input [4:0]  rd;
        begin
            make_load = {{20{imm[11]}}, imm, rs1, funct3, rd, 7'b0000011};
        end
    endfunction

    function [31:0] make_store;
        input [11:0] imm;
        input [4:0]  rs2;
        input [4:0]  rs1;
        input [2:0]  funct3;
        begin
            
            make_store = {imm[11:5], rs2, rs1, funct3, imm[4:0], 7'b0100011};
        end
    endfunction

    function [31:0] make_branch_beq;
        input [12:0] imm; 
        input [4:0]  rs2;
        input [4:0]  rs1;
        begin
            make_branch_beq = {imm[12], imm[10:5], rs2, rs1, 3'b000, imm[4:1], imm[11], 7'b1100011};
        end
    endfunction

    task expect;
        input [127:0] name;
        input exp_RegWrite;
        input exp_MemWrite;
        input exp_MemRead;
        input exp_ALUSrc;
        input exp_MemToReg;
        input exp_Branch;
        input [3:0] exp_ALU;
        begin
            #1; 
            if (RegWrite !== exp_RegWrite || MemWrite !== exp_MemWrite || MemRead !== exp_MemRead ||
                ALUSrc   !== exp_ALUSrc   || MemToReg !== exp_MemToReg || Branch   !== exp_Branch   ||
                ALUctl   !== exp_ALU) begin
                $display("FAIL: %s", name);
                $display("Got: RegWrite=%0b MemWrite=%0b MemRead=%0b ALUSrc=%0b MemToReg=%0b Branch=%0b ALUctl=%b",
                         RegWrite, MemWrite, MemRead, ALUSrc, MemToReg, Branch, ALUctl);
                $fatal;
            end else begin
                $display("PASS: %s", name);
            end
        end
    endtask

    initial begin
        $display("===== Control Unit Test Start =====");

        // R-type
        instr = make_rtype(7'b0000000, 5'd2, 5'd1, 3'b000, 5'd3); expect("R-ADD", 1'b1,1'b0,1'b0,1'b0,1'b0,1'b0, ALU_ADD);
        instr = make_rtype(7'b0100000, 5'd2, 5'd1, 3'b000, 5'd3); expect("R-SUB", 1'b1,1'b0,1'b0,1'b0,1'b0,1'b0, ALU_SUB);
        instr = make_rtype(7'b0000000, 5'd2, 5'd1, 3'b111, 5'd3); expect("R-AND", 1'b1,1'b0,1'b0,1'b0,1'b0,1'b0, ALU_AND);
        instr = make_rtype(7'b0000000, 5'd2, 5'd1, 3'b110, 5'd3); expect("R-OR",  1'b1,1'b0,1'b0,1'b0,1'b0,1'b0, ALU_OR);
        instr = make_rtype(7'b0000000, 5'd2, 5'd1, 3'b100, 5'd3); expect("R-XOR", 1'b1,1'b0,1'b0,1'b0,1'b0,1'b0, ALU_XOR);
        instr = make_rtype(7'b0000000, 5'd2, 5'd1, 3'b001, 5'd3); expect("R-SLL", 1'b1,1'b0,1'b0,1'b0,1'b0,1'b0, ALU_SLL);
        instr = make_rtype(7'b0000000, 5'd2, 5'd1, 3'b101, 5'd3); expect("R-SRL", 1'b1,1'b0,1'b0,1'b0,1'b0,1'b0, ALU_SRL);

        instr = make_itype(12'd5,   5'd1, 3'b000, 5'd3); expect("I-ADDI", 1'b1,1'b0,1'b0,1'b1,1'b0,1'b0, ALU_ADD);
        instr = make_itype(12'h0F0, 5'd1, 3'b111, 5'd3); expect("I-ANDI", 1'b1,1'b0,1'b0,1'b1,1'b0,1'b0, ALU_AND);
        instr = make_itype(12'h0F0, 5'd1, 3'b110, 5'd3); expect("I-ORI",  1'b1,1'b0,1'b0,1'b1,1'b0,1'b0, ALU_OR);
        instr = make_itype(12'h0F0, 5'd1, 3'b100, 5'd3); expect("I-XORI", 1'b1,1'b0,1'b0,1'b1,1'b0,1'b0, ALU_XOR);

        instr = {7'b0000000, 5'd2, 5'd1, 3'b001, 5'd3, 7'b0010011}; expect("I-SLLI", 1'b1,1'b0,1'b0,1'b1,1'b0,1'b0, ALU_SLL);
        instr = {7'b0000000, 5'd2, 5'd1, 3'b101, 5'd3, 7'b0010011}; expect("I-SRLI", 1'b1,1'b0,1'b0,1'b1,1'b0,1'b0, ALU_SRL);

        instr = make_load(12'd16, 5'd1, 3'b011, 5'd3);              expect("LD",    1'b1,1'b0,1'b1,1'b1,1'b1,1'b0, ALU_ADD);
        instr = make_store(12'd20, 5'd2, 5'd1, 3'b011);             expect("SD",    1'b0,1'b1,1'b0,1'b1,1'b0,1'b0, ALU_ADD);

        instr = make_branch_beq(13'd8, 5'd2, 5'd1);                 expect("BEQ",   1'b0,1'b0,1'b0,1'b0,1'b0,1'b1, ALU_SUB);

        $display("===== CU Done=====");
        $finish;
    end

endmodule

