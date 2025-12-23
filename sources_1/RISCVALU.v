`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Design Name: 
// Module Name: RISCVALU
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


module RISCVALU(
    input [3:0] ALUctl,
    input signed [63:0] A,
    input signed [63:0] B,
    output reg [63:0] ALUout,
    output Zero
);

always @(*) begin
    case (ALUctl)
        4'b0000: ALUout = A + B;                                         // ADD
        4'b0001: ALUout = A - B;                                         // SUB
        4'b0010: ALUout = A & B;                                         // AND
        4'b0011: ALUout = A | B;                                         // OR
        4'b0100: ALUout = A ^ B;                                         // XOR
        4'b0101: ALUout = A <<< B[5:0];                                  // SLL
        4'b0110: ALUout = A >>> B[5:0];                                  // SRL
        4'b0111: ALUout = $signed(A) >>> B[5:0];                         // SRA
        4'b1000: ALUout = ($signed(A) < $signed(B)) ? 64'd1 : 64'd0;     // SLT (signed)
        4'b1001: ALUout = ($unsigned(A) < $unsigned(B)) ? 64'd1 : 64'd0; // SLTU (unsigned)
        default: ALUout = 64'd0;
    endcase
end

assign Zero = (ALUout == 64'd0);

endmodule

