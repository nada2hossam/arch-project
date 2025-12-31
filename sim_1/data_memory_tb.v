
module test_dmem;
    reg clk = 0;
    reg MemRead, MemWrite;
    reg [63:0] addr, write_data;
    wire [63:0] read_data;
    
    always #5 clk = ~clk;
    
    data_memory dmem(
        .clk(clk),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .addr(addr),
        .write_data(write_data),
        .read_data(read_data)
    );
    
    initial begin
        $display("Testing Data Memory");

        MemRead = 0;
        MemWrite = 0;
        addr = 0;
        write_data = 0;
        
        #10;
        
        $display("\nTest 1: Write 99 to address 32");
        MemWrite = 1;
        addr = 32;
        write_data = 99;
        #10;
        
        $display("Test 2: Read from address 32");
        MemWrite = 0;
        MemRead = 1;
        #10;
        $display("Read: %d (should be 99)", read_data);
        
        $display("\nTest 3: Write 255 to address 64");
        MemWrite = 1;
        MemRead = 0;
        addr = 64;
        write_data = 255;
        #10;
        
        $display("Test 4: Read from address 64");
        MemWrite = 0;
        MemRead = 1;
        #10;
        $display("Read: %d (should be 255)", read_data);
        
        $display("\nTest 5: Check initial value at address 0");
        addr = 0;
        #10;
        $display("Read: %d (should be 5)", read_data);
        
        $finish;
    end
endmodule
