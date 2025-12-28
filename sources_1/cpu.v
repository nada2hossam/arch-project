`timescale 1ns / 1ps

module CPU (
    input wire clk,
    input wire reset
);

    wire [63:0] PC;

    wire [31:0] instruction;

    wire RegWrite;
    wire MemWrite;
    wire MemRead;
    wire ALUSrc;
    wire MemToReg;
    wire Branch;
    wire [3:0] ALUctl;

    wire [63:0] ReadData1;
    wire [63:0] ReadData2;
    wire [63:0] WriteData;

    wire [63:0] Immediate;

    wire [63:0] ALU_Input_B;
    wire [63:0] ALUout;
    wire Zero;

    wire [63:0] MemReadData;

    Task4_PC_Updates PC_Unit (
        .clk(clk),
        .reset(reset),
        .Imm(Immediate),
        .Branch(Branch),
        .Zero(Zero),
        .PC(PC)
    );

    Instruction_Memory IMEM (
        .address(PC),
        .instruction(instruction)
    );

    control_unit CTRL (
        .instr(instruction),
        .RegWrite(RegWrite),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .ALUSrc(ALUSrc),
        .MemToReg(MemToReg),
        .Branch(Branch),
        .ALUctl(ALUctl)
    );

    RegisterFile REGFILE (
        .clk(clk),
        .RegWrite(RegWrite),
        .ReadReg1(instruction[19:15]), // rs1
        .ReadReg2(instruction[24:20]), // rs2
        .WriteReg(instruction[11:7]),  // rd
        .WriteData(WriteData),
        .ReadData1(ReadData1),
        .ReadData2(ReadData2)
    );

    ImmediateGenerator IMMGEN (
        .instruction(instruction),
        .immediate(Immediate)
    );

    assign ALU_Input_B = ALUSrc ? Immediate : ReadData2;

    RISCVALU ALU (
        .ALUctl(ALUctl),
        .A(ReadData1),
        .B(ALU_Input_B),
        .ALUout(ALUout),
        .Zero(Zero)
    );

    Data_Memory DMEM (
        .clk(clk),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .addr(ALUout),
        .write_data(ReadData2),
        .read_data(MemReadData)
    );

    assign WriteData = MemToReg ? MemReadData : ALUout;

endmodule
