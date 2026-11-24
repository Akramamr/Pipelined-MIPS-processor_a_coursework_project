module EXMEM (
    input wire clk,
    input wire rst,

    input wire RegWriteE,
    input wire MemWriteE,
    input wire MemtoRegE,
    input wire [4:0] WriteRegE,
    //input wire [31:0] PCPlus4E,
    input wire [31:0] WriteDataE,
    input wire [31:0] ALUOutE,


    output reg RegWriteM,
    output reg MemWriteM,
    output reg MemtoRegM,
    output reg [4:0] WriteRegM,
    //output reg [31:0] PCPlus4M,
    output reg [31:0] WriteDataM,
    output reg [31:0] ALUOutM
);

    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            RegWriteM <= 1'b0;
            MemWriteM <= 1'b0;
            MemtoRegM <= 1'b0;
            WriteRegM <= 5'b0;
            //PCPlus4M  <= 32'b0;
            WriteDataM <= 32'b0;
            ALUOutM   <= 32'b0;
        end
        else begin

            RegWriteM <= RegWriteE;
            MemWriteM <= MemWriteE;
            MemtoRegM <= MemtoRegE;
            WriteRegM <= WriteRegE;
            //PCPlus4M  <= PCPlus4E;
            WriteDataM <= WriteDataE;
            ALUOutM   <= ALUOutE;
        end
    end
endmodule
