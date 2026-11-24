module DEREG (
    input clk,
    input rst,
    input clr,

    // Data inputs
    input [31:0] RD1D,
    input [31:0] RD2D,
    input [31:0] SignImmD,
    

    // Register addresses
    input [4:0] RsD,
    input [4:0] RtD,
    input [4:0] RdD,

    // Control inputs
    input RegWriteD,
    input MemtoRegD,
    input MemWriteD,
    
    input [2:0] ALUControlD,
    input ALUSrcD,
    input RegDstD,

    // Data outputs
    output reg [31:0] RD1E,
    output reg [31:0] RD2E,
    output reg [31:0] SignImmE,
    

    // Register address outputs
    output reg [4:0] RsE,
    output reg [4:0] RtE,
    output reg [4:0] RdE,

    // Control outputs
    output reg RegWriteE,
    output reg MemtoRegE,
    output reg MemWriteE,
    
    output reg [2:0] ALUControlE,
    output reg ALUSrcE,
    output reg RegDstE
);

always @(posedge clk or negedge rst )
begin
    if (!rst) 
    begin
       RD1E <= 0;
        RD2E <= 0;
        SignImmE <= 0;
        

        RsE <= 0;
        RtE <= 0;
        RdE <= 0;

        RegWriteE <= 0;
        MemtoRegE <= 0;
        MemWriteE <= 0;
        
        ALUControlE <= 0;
        ALUSrcE <= 0;
        RegDstE <= 0;
    end
    else if (clr)
    begin
        RD1E <= 0;
        RD2E <= 0;
        SignImmE <= 0;
       

        RsE <= 0;
        RtE <= 0;
        RdE <= 0;

        RegWriteE <= 0;
        MemtoRegE <= 0;
        MemWriteE <= 0;
        
        ALUControlE <= 0;
        ALUSrcE <= 0;
        RegDstE <= 0;
    end

    else
    begin
        RD1E <= RD1D;
        RD2E <= RD2D;
        SignImmE <= SignImmD;
        

        RsE <= RsD;
        RtE <= RtD;
        RdE <= RdD;

        RegWriteE <= RegWriteD;
        MemtoRegE <= MemtoRegD;
        MemWriteE <= MemWriteD;
        
        ALUControlE <= ALUControlD;
        ALUSrcE <= ALUSrcD;
        RegDstE <= RegDstD;
    end
end

endmodule
