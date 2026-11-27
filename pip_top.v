
module pip_top #(parameter WIDTH = 32)(
    input clk,rst,
    
    output [WIDTH-1:0] ALUOutW_out, ReadDataW_out,
    output [WIDTH-1:0] WriteDataM_out,
    output MemWriteM_out,
    output [WIDTH-1:0] ALUOutMout_tb

);

    
    wire PCSrcD;
    
    wire [WIDTH-1:0] InstrF;
    wire [WIDTH-1:0] PCPlus4F;

    wire JumpD;

    wire [WIDTH-1:0] PCBranchD ;
    wire [WIDTH-1:0] PCJumpD;
    wire [WIDTH-1:0] ALUOutMout;
    
    wire RegWrite;
    
    wire [WIDTH-1:0] ReadDataM;
    
    wire [$clog2(WIDTH)-1:0] WriteRegM,WriteRegW;
    wire RegWriteM,RegWriteW;
    wire BranchD,MemtoRegM;
    wire ForwardAD,ForwardBD;
    wire StallF,StallD,FlushE;

    wire [WIDTH-1:0] RD1D, RD2D, SignImmD;
    wire [$clog2(WIDTH)-1:0]  RsD, RtD, RdD;
    wire        RegWriteD, MemtoRegD, MemWriteD;
    wire [2:0]  ALUControlD;
    wire        ALUSrcD, RegDstD;

    // Forwarding sources
    wire [WIDTH-1:0] ResultW, ALUOutM;
    wire [1:0]  ForwardAE, ForwardBE;

    // E-stage outputs (hazard unit and EX/MEM register both use these)
    wire [$clog2(WIDTH)-1:0]  RsE, RtE, WriteRegE;
    wire        RegWriteE, MemtoRegE, MemWriteE;
    wire [WIDTH-1:0] ALUOutE, WriteDataE;

    assign ALUOutMout_tb =ALUOutMout;


fetch_stage fetch_S (.clk(clk),.rst(rst),
                    .StallF(StallF),.PCBranchD(PCBranchD),.PCSrcD(PCSrcD),.JumpD(JumpD),
                    .PCJumpD(PCJumpD),
                    .InstrF(InstrF),.PCPlus4F(PCPlus4F));

decode_stage decode_S (.clk(clk),.rst(rst),
                        .InstrF(InstrF),.PCPlus4F(PCPlus4F),
                        .RegWriteW(RegWriteW),.WriteRegW(WriteRegW),.ResultW(ResultW),
                        .ForwardAD(ForwardAD),.ForwardBD(ForwardBD),.StallD(StallD),
                        .ALUOutM(ALUOutMout),
                        
                        .RD1D(RD1D),.RD2D(RD2D),.SignImmD(SignImmD),.PCJumpD(PCJumpD),
                        .RsD(RsD),.RtD(RtD),.RdD(RdD),
                        .RegWriteD(RegWriteD),.MemtoRegD(MemtoRegD),.MemWriteD(MemWriteD),.BranchD(BranchD),
                        .ALUControlD(ALUControlD),.ALUSrcD(ALUSrcD),.RegDstD(RegDstD),.JumpD(JumpD),.PCSrcD(PCSrcD),
                        .PCBranchD(PCBranchD));


Execute_stage excute_S (.clk(clk),.rst(rst),
                        .FlushE(FlushE),.RD1D(RD1D),.RD2D(RD2D),.SignImmD(SignImmD),
                        .RsD(RsD),.RtD(RtD),.RdD(RdD),
                        .RegWriteD(RegWriteD),.MemtoRegD(MemtoRegD),.MemWriteD(MemWriteD),
                        .ALUControlD(ALUControlD),.ALUSrcD(ALUSrcD),.RegDstD(RegDstD),
                        .ResultW(ResultW),.ALUOutM(ALUOutMout),
                        .ForwardAE(ForwardAE),.ForwardBE(ForwardBE),
                        
                        .RsE(RsE),.RtE(RtE),.WriteRegE(WriteRegE),
                        .RegWriteE(RegWriteE),.MemtoRegE(MemtoRegE),.MemWriteE(MemWriteE),
                        .ALUOutE(ALUOutE),.WriteDataE(WriteDataE));

mem_stage mem_S (.clk(clk),.rst(rst),
                .RegWriteE(RegWriteE),.MemtoRegE(MemtoRegE),.MemWriteE(MemWriteE),
                .ALUOutE(ALUOutE),.WriteDataE(WriteDataE),.WriteRegE(WriteRegE),
                
                .RegWriteM(RegWriteM),.MemtoRegM(MemtoRegM),.ReadDataM(ReadDataM),
                .ALUOutMout(ALUOutMout),.WriteRegM(WriteRegM),
                .WriteDataM_out(WriteDataM_out),.MemWriteM_out(MemWriteM_out));


writeback_stage writeBack_S (.clk(clk),.rst(rst),
                            .RegWriteM(RegWriteM),.MemtoRegM(MemtoRegM),.WriteRegM(WriteRegM),
                            .ALUOutM(ALUOutMout),.ReadDataM(ReadDataM),
                            
                            .RegWriteW(RegWriteW),.WriteRegW(WriteRegW),.ResultW(ResultW),
                            .ALUOutW_out(ALUOutW_out),.ReadDataW_out(ReadDataW_out));


hazard_unit hazard_U (.rsD(RsD),.rtD(RtD),.rtE(RtE),.rsE(RsE),
                    .WriteRegM(WriteRegM),.WriteRegW(WriteRegW),.WriteRegE(WriteRegE),
                    .RegWriteM(RegWriteM),.RegWriteE(RegWriteE),.RegWriteW(RegWriteW),
                    .BranchD(BranchD),.MemtoRegM(MemtoRegM),.MemtoRegE(MemtoRegE),
                    
                    .ForwardAD(ForwardAD),.ForwardBD(ForwardBD),
                    .ForwardAE(ForwardAE),.ForwardBE(ForwardBE),
                    .StallF(StallF),.StallD(StallD),.FlushE(FlushE));


endmodule
