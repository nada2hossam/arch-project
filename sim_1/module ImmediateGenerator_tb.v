module ImmediateGenerator_tb;

    reg [31:0] instruction;
    wire [63:0] immediate;

    // Instantiate Immediate Generator
    ImmediateGenerator uut (
        .instruction(instruction),
        .immediate(immediate)
    );

    initial begin
        $display("=== Immediate Generator Testbench ===");
        $display("Instruction Type\tInstruction (hex)\tImmediate (hex)\t\tImmediate (dec)");
        $display("---------------------------------------------------------------------------------");
        
        // Test 1: I-Type - addi x1, x0, 5
        // Opcode: 0010011, imm[11:0] = 5
        instruction = 32'b000000000101_00000_000_00001_0010011;
        #1;
        $display("I-Type (addi)\t\t%h\t%h\t%0d", instruction, immediate, $signed(immediate));
        
        // Test 2: I-Type - addi x2, x0, -1
        // Opcode: 0010011, imm[11:0] = -1 (0xFFF)
        instruction = 32'b111111111111_00000_000_00010_0010011;
        #1;
        $display("I-Type (addi -1)\t%h\t%h\t%0d", instruction, immediate, $signed(immediate));
        
        // Test 3: I-Type - ld x3, 8(x0)
        // Opcode: 0000011, imm[11:0] = 8
        instruction = 32'b000000001000_00000_011_00011_0000011;
        #1;
        $display("I-Type (ld)\t\t%h\t%h\t%0d", instruction, immediate, $signed(immediate));
        
        // Test 4: S-Type - sd x1, 0(x2)
        // Opcode: 0100011, imm[11:5] = 0, imm[4:0] = 0
        instruction = 32'b0000000_00001_00010_011_00000_0100011;
        #1;
        $display("S-Type (sd)\t\t%h\t%h\t%0d", instruction, immediate, $signed(immediate));
        
        // Test 5: S-Type - sd x3, 16(x4)
        // Opcode: 0100011, imm = 16 (split as [11:5]=0, [4:0]=16)
        instruction = 32'b0000000_00011_00100_011_10000_0100011;
        #1;
        $display("S-Type (sd 16)\t\t%h\t%h\t%0d", instruction, immediate, $signed(immediate));
        
        // Test 6: B-Type - beq x1, x2, 8
        // Opcode: 1100011, offset = 8
        // imm[12|10:5|4:1|11] = 8 >> 1 = 4
        instruction = 32'b0_000000_00010_00001_000_0100_0_1100011;
        #1;
        $display("B-Type (beq)\t\t%h\t%h\t%0d", instruction, immediate, $signed(immediate));
        
        // Test 7: I-Type - andi x5, x6, 0xFF
        // Opcode: 0010011, funct3: 111, imm = 255
        instruction = 32'b000011111111_00110_111_00101_0010011;
        #1;
        $display("I-Type (andi)\t\t%h\t%h\t%0d", instruction, immediate, $signed(immediate));
        
        // Test 8: I-Type - slli x7, x8, 3
        // Opcode: 0010011, funct3: 001, shamt = 3
        instruction = 32'b0000000_00011_01000_001_00111_0010011;
        #1;
        $display("I-Type (slli)\t\t%h\t%h\t%0d", instruction, immediate, $signed(immediate));
        
        // Test 9: Negative I-Type immediate
        // addi x9, x0, -100
        instruction = 32'b111110011100_00000_000_01001_0010011;
        #1;
        $display("I-Type (addi -100)\t%h\t%h\t%0d", instruction, immediate, $signed(immediate));
        
        // Test 10: Large S-Type offset
        // sd x10, 2047(x11) (max 12-bit positive)
        instruction = 32'b0111111_01010_01011_011_11111_0100011;
        #1;
        $display("S-Type (sd 2047)\t%h\t%h\t%0d", instruction, immediate, $signed(immediate));
        
        $display("=== Immediate Generator Tests Complete ===");
        $finish;
    end

endmodule