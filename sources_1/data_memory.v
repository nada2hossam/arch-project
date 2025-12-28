module Data_Memory (
    input clk,
    input MemRead,      
    input MemWrite,     
    input [63:0] addr,
    input [63:0] write_data,
    output reg [63:0] read_data
);
    reg [63:0] memory [0:255];
    always @(*) begin
        if (MemRead)
            read_data = memory[addr[10:3]];
        else
            read_data = 64'd0;
    end

    always @(posedge clk) begin
        if (MemWrite) begin
            memory[addr[10:3]] <= write_data;
        end
    end

    integer i;
    initial begin
        for (i = 0; i < 256; i = i + 1) memory[i] = 64'd0;
        memory[0] = 64'd5;
    end

endmodule
