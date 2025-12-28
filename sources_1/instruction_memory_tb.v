`timescale 1ns / 1ps

module tb_instruction_memory_custom;

    reg  [63:0] pc_addr;
    wire [31:0] instr_out;
    reg  [31:0] expected;

    Instruction_Memory UUT (
        .address(pc_addr),
        .instruction(instr_out)
    );

    initial begin
        $display("Time\tAddress\t\tInstruction (Hex)\tExpected");

        pc_addr = 64'd0;
        expected = 32'h0000_0033; 
        #10;
        $display("%0t\t%0d\t\t%h\t\t%h", $time, pc_addr, instr_out, expected);

        pc_addr = 64'd4;
        expected = 32'h00A5_0533; 
        #10;
        $display("%0t\t%0d\t\t%h\t\t%h", $time, pc_addr, instr_out, expected);

        pc_addr = 64'd8;
        expected = 32'h4005_8533; 
        #10;
        $display("%0t\t%0d\t\t%h\t\t%h", $time, pc_addr, instr_out, expected);

        pc_addr = 64'd12;
        expected = 32'h0000_0000;
        #10;
        $display("%0t\t%0d\t\t%h\t\t%h", $time, pc_addr, instr_out, expected);

        $finish;
    end

endmodule
