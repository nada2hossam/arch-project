module Instruction_Memory (
    input  [63:0] address,
    output [31:0] instruction
);

  reg [31:0] memory[0:255];

  assign instruction = memory[address[9:2]];

  integer i;
  initial begin
    for (i=0; i<256; i=i+1) memory[i] = 32'd0; 
    memory[0] = 32'h00000033; 
    memory[1] = 32'h00A50533; 
    memory[2] = 32'h40058533;
  end

endmodule
