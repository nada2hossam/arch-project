
`timescale 1ns / 1ps

module data_memory_tb;
reg         clk_sig;
    reg         memWrite;
    reg         memRead;
    reg [63:0]  address;
    reg [63:0]  data_in;
    wire [63:0] data_out;
    reg [63:0]  expected;

    Data_Memory UUT (
        .clk(clk_sig),
        .MemWrite(memWrite),   
        .MemRead(memRead),     
        .addr(address),        
        .write_data(data_in),   
        .read_data(data_out)    
    );

    initial clk_sig = 0;
    always #5 clk_sig = ~clk_sig;

    initial begin
        $display("Time\tAddr\tWE\tRE\tWData\t\t\tRData\t\t\tExpected");

        memWrite = 1; 
        memRead = 0;

        address = 64'd0;
        data_in = 64'h1122_3344_5566_7788;  
        expected = data_in;
        #10;
        $display("%0t\t%0d\t%b\t%b\t%h\t%h\t%h", $time, address, memWrite, memRead, data_in, data_out, expected);

        address = 64'd8;
        data_in = 64'hFFFF_0000_AAAA_5555; 
        expected = data_in;
        #10;
        $display("%0t\t%0d\t%b\t%b\t%h\t%h\t%h", $time, address, memWrite, memRead, data_in, data_out, expected);

        address = 64'd16;
        data_in = 64'h9876_5432_10FE_DCBA;  
        expected = data_in;
        #10;
        $display("%0t\t%0d\t%b\t%b\t%h\t%h\t%h", $time, address, memWrite, memRead, data_in, data_out, expected);


        memWrite = 0; 
        memRead = 1;
        data_in = 64'd0; 


        address = 64'd0;
        expected = 64'h1122_3344_5566_7788; 
        #10;
        $display("%0t\t%0d\t%b\t%b\t%h\t%h\t%h", $time, address, memWrite, memRead, data_in, data_out, expected);

        address = 64'd8;
        expected = 64'hFFFF_0000_AAAA_5555; 
        $display("%0t\t%0d\t%b\t%b\t%h\t%h\t%h", $time, address, memWrite, memRead, data_in, data_out, expected);

        address = 64'd16;
        expected = 64'h9876_5432_10FE_DCBA;
        #10;
        $display("%0t\t%0d\t%b\t%b\t%h\t%h\t%h", $time, address, memWrite, memRead, data_in, data_out, expected);

        $finish;
    end

endmodule
