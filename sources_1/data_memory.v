
module data_memory(
    input         clk,        
    input         MemRead,    
    input         MemWrite,   
    input  [63:0] addr,       
    input  [63:0] write_data, 
    output reg [63:0] read_data 
);
    
    reg [63:0] mem [0:255];
    
    always @(*) begin
        if (MemRead) begin
            read_data = mem[addr[10:3]];
        end else begin
            read_data = 64'd0;
        end
    end
    
    always @(posedge clk) begin
        if (MemWrite) begin
            mem[addr[10:3]] <= write_data;
        end
    end
    
    integer i;
    initial begin
        for (i = 0; i < 256; i = i + 1) begin
            mem[i] = 64'd0;
        end
        mem[0] = 64'd5; 
        $display("Data Memory: Initialized with 256 words");
    end

endmodule


