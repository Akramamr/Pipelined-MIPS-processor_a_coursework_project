module mem_stage #(parameter WIDTH = 32)(

    input clk,reset,

    input RegWriteE,
    input MemtoRegE,
    input MemWriteE,
    input [WIDTH-1:0] AluOutE,
    input [WIDTH-1:0] WriteDataE,
    input [$clog2(WIDTH)-1:0] WriteRegE,

    output RegWriteM,
    output MemtoRegM,
    output [WIDTH-1:0] ReadDataM,
    output [WIDTH-1:0] AluOutMout,
    output [$clog2(WIDTH)-1:0] WriteRegM,

    output [WIDTH-1:0] WriteDataM_out
    

);
    wire [WIDTH-1:0] AluOutM;
    wire MemWriteM;
    wire [WIDTH-1:0] WriteDataM;

assign AluOutMout = AluOutM;
assign WriteDataM_out =WriteDataM;

data_mem dmem (.clk(clk),.we(MemWriteM),.a(AluOutM),.wd(WriteDataM));


Execute_mem_Reg EM_R (.clk(clk),.rst(reset),.MemtoRegE(MemtoRegE),.WriteRegE(WriteRegE),.WriteDataE(WriteDataE),.ALUOutE(ALUOutE),
                        .RegWriteM(RegWriteM),.MemWriteM(MemWriteM),.MemtoRegM(MemtoRegM),.WriteRegM(WriteRegM),
                        .WriteDataM(WriteDataM),.ALUOutM(ALUOutM));
















endmodule
