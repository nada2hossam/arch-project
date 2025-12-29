module Task4_PC_Updates(
    input clk,
    input reset,
    input [63:0] Imm,       
    input Branch,           
    input Zero,             
    output reg [63:0] PC    
);

    wire [63:0] PC_Plus_4;
    wire [63:0] Branch_Target;
    wire [63:0] Next_PC;
    wire PCSrc;

    assign PC_Plus_4 = PC + 64'd4;
    assign Branch_Target = PC + (Imm << 1);


    assign PCSrc = Branch & Zero; 

    assign Next_PC = (PCSrc) ? Branch_Target : PC_Plus_4;


    always @(posedge clk or posedge reset) begin
        if (reset)
            PC <= 64'd0;     
        else
            PC <= Next_PC;   
    end

endmodule

module Task4_TB;
    reg clk, reset, Branch, Zero;
    reg [63:0] Imm;
    wire [63:0] PC;

    Task4_PC_Updates dut (
        .clk(clk), .reset(reset), .Imm(Imm), 
        .Branch(Branch), .Zero(Zero), .PC(PC)
    );

    always #5 clk = ~clk;

    initial begin

        clk = 0; reset = 1; Branch = 0; Zero = 0; Imm = 0;
        #10 reset = 0; 
        
       
        #10; 
        $display("Test 1 (Seq): Time=%0t PC=%d", $time, PC);


        Branch = 1; Zero = 1; Imm = 64'd4; 
        #10;
        $display("Test 2 (Jump): Time=%0t PC=%d (Expected Jump)", $time, PC);

        Branch = 1; Zero = 0; Imm = 64'd100;
        #10;
        $display("Test 3 (No Jump): Time=%0t PC=%d", $time, PC);

        $finish;
    end
endmodule
