`timescale 1ns / 1ps

module Team21_TB;

    reg clk;
    reg reset;
    
    CPU dut (
        .clk(clk),
        .reset(reset)
    );
    
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    initial begin
        reset = 1;
        #10;
        reset = 0;
        
        forever begin
            @(posedge clk);
            
            if (dut.IMEM.instruction == 32'h00000000) begin
      
                
              
                if (dut.REGFILE.registers[0] == 0) 
                    $display("[PASS] x0  = %0d", dut.REGFILE.registers[0]);
                else 
                    $display("[FAIL] x0  = %0d (Expected: 0)", dut.REGFILE.registers[0]);

                if (dut.REGFILE.registers[2] == 3) 
                    $display("[PASS] x2  = %0d", dut.REGFILE.registers[2]);
                else 
                    $display("[FAIL] x2  = %0d (Expected: 3 - Check SRL logic)", dut.REGFILE.registers[2]);

                if (dut.REGFILE.registers[25] == 0) 
                    $display("[PASS] x25 = %0d", dut.REGFILE.registers[25]);
                else 
                    $display("[FAIL] x25 = %0d (Expected: 0)", dut.REGFILE.registers[25]);

                if (dut.REGFILE.registers[26] == 3) 
                    $display("[PASS] x26 = %0d", dut.REGFILE.registers[26]);
                else 
                    $display("[FAIL] x26 = %0d (Expected: 3 - Check Load logic)", dut.REGFILE.registers[26]);

                if (dut.REGFILE.registers[1] == 21) 
                    $display("[PASS] x1  = %0d", dut.REGFILE.registers[1]);
                else 
                    $display("[FAIL] x1  = %0d (Expected: 21 - Check Branch logic)", dut.REGFILE.registers[1]);
                
                if (dut.DMEM.memory[4] == 3)
                    $display("[PASS] mem[32] = %0d", dut.DMEM.memory[4]);
                else
                    $display("[FAIL] mem[32] = %0d (Expected: 3 - Check Store logic)", dut.DMEM.memory[4]);

                $finish;
            end
        end
    end

endmodule
