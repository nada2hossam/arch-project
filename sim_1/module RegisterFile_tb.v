module RegisterFile_tb;

    // Testbench signals
    reg clk;
    reg RegWrite;
    reg [4:0] ReadReg1;
    reg [4:0] ReadReg2;
    reg [4:0] WriteReg;
    reg [63:0] WriteData;
    wire [63:0] ReadData1;
    wire [63:0] ReadData2;

    // Instantiate Register File
    RegisterFile uut (
        .clk(clk),
        .RegWrite(RegWrite),
        .ReadReg1(ReadReg1),
        .ReadReg2(ReadReg2),
        .WriteReg(WriteReg),
        .WriteData(WriteData),
        .ReadData1(ReadData1),
        .ReadData2(ReadData2)
    );

    // Clock generation 
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 10 time units period
    end

    // Test sequence
    initial begin
        $display("=== Register File Testbench ===");
        $display("Time\tWrite\tWriteReg\tWriteData\t\tReadReg1\tReadData1\t\tReadReg2\tReadData2");
        $display("----------------------------------------------------------------------------------------------------");
        
        // Initialize
        RegWrite = 0;
        ReadReg1 = 0;
        ReadReg2 = 0;
        WriteReg = 0;
        WriteData = 0;
        
        // Test 1: Read from x0 (should always be 0)
        #10;
        ReadReg1 = 5'd0;  // x0
        ReadReg2 = 5'd0;
        #1;
        $display("%0t\t%b\tx%0d\t\t%h\tx%0d\t\t%h\tx%0d\t\t%h", 
                 $time, RegWrite, WriteReg, WriteData, ReadReg1, ReadData1, ReadReg2, ReadData2);
        
        // Test 2: Write to x1
        #10;
        RegWrite = 1;
        WriteReg = 5'd1;   // x1
        WriteData = 64'hAAAA_AAAA_AAAA_AAAA;
        #10;  // Wait for clock edge
        RegWrite = 0;
        ReadReg1 = 5'd1;
        #1;
        $display("%0t\t%b\tx%0d\t\t%h\tx%0d\t\t%h\tx%0d\t\t%h", 
                 $time, RegWrite, WriteReg, WriteData, ReadReg1, ReadData1, ReadReg2, ReadData2);
        
        // Test 3: Write to x2
        #10;
        RegWrite = 1;
        WriteReg = 5'd2;   // x2
        WriteData = 64'h5555_5555_5555_5555;
        #10;
        RegWrite = 0;
        ReadReg2 = 5'd2;
        #1;
        $display("%0t\t%b\tx%0d\t\t%h\tx%0d\t\t%h\tx%0d\t\t%h", 
                 $time, RegWrite, WriteReg, WriteData, ReadReg1, ReadData1, ReadReg2, ReadData2);
        
        // Test 4: Read from both x1 and x2 simultaneously
        #10;
        ReadReg1 = 5'd1;
        ReadReg2 = 5'd2;
        #1;
        $display("%0t\t%b\tx%0d\t\t%h\tx%0d\t\t%h\tx%0d\t\t%h", 
                 $time, RegWrite, WriteReg, WriteData, ReadReg1, ReadData1, ReadReg2, ReadData2);
        
        // Test 5: Try to write to x0 (should not change)
        #10;
        RegWrite = 1;
        WriteReg = 5'd0;   // x0
        WriteData = 64'hFFFF_FFFF_FFFF_FFFF;
        #10;
        RegWrite = 0;
        ReadReg1 = 5'd0;
        #1;
        $display("%0t\t%b\tx%0d\t\t%h\tx%0d\t\t%h\tx%0d\t\t%h (x0 should still be 0)", 
                 $time, RegWrite, WriteReg, WriteData, ReadReg1, ReadData1, ReadReg2, ReadData2);
        
        // Test 6: Write to x31 (last register)
        #10;
        RegWrite = 1;
        WriteReg = 5'd31;  // x31
        WriteData = 64'h1234_5678_9ABC_DEF0;
        #10;
        RegWrite = 0;
        ReadReg1 = 5'd31;
        #1;
        $display("%0t\t%b\tx%0d\t\t%h\tx%0d\t\t%h\tx%0d\t\t%h", 
                 $time, RegWrite, WriteReg, WriteData, ReadReg1, ReadData1, ReadReg2, ReadData2);
        
        $display("=== Register File Tests Complete ===");
        $finish;
    end

endmodule

