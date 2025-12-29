`timescale 1ns / 1ps

module CPU_TB;

    reg clk;
    reg reset;
    
    CPU dut (
        .clk(clk),
        .reset(reset)
    );
    
    always #5 clk = ~clk;
    
    initial begin
        clk = 0;
        reset = 1;
        
        #20 reset = 0;
        
        #200;
        
        $display("\nFinal Register Values ");
        $display("x1  = %0d", dut.REGFILE.registers[1]);
        $display("x2  = %0d", dut.REGFILE.registers[2]);
        $display("x3  = %0d", dut.REGFILE.registers[3]);
        $display("x4  = %0d", dut.REGFILE.registers[4]);
        $display("x5  = %0d", dut.REGFILE.registers[5]);
        $display("x6  = %0d", dut.REGFILE.registers[6]);
        $display("x7  = %0d", dut.REGFILE.registers[7]);
        $display("x10 = %0d", dut.REGFILE.registers[10]);
        $display("\nFinal PC = %0d\n", dut.PC);
        
        $finish;
    end

endmodule
