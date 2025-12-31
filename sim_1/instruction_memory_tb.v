
module test_imem;
    reg [63:0] address;
    wire [31:0] instruction;
    
    instruction_memory imem(.address(address), .instruction(instruction));
    
    initial begin
        $display("Testing Instruction Memory");

        address = 0;
        #10;
        $display("PC=0: %h (addi x0,x0,7)", instruction);
        
        address = 4;
        #10;
        $display("PC=4: %h (addi x13,x0,220)", instruction);
        
        address = 32; 
        #10;
        $display("PC=32: %h (ld x26,32(x0))", instruction);
        
        address = 44;
        #10;
        $display("PC=44: %h (addi x1,x0,21)", instruction);
        
        $finish;
    end
endmodule
