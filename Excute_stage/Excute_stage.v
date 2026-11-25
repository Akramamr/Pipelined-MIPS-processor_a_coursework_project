

module Execute_stage (
    input  wire        clk, rst, flushE,

    // From Decode stage
    input  wire [31:0] RD1D, RD2D, SignImmD,
    input  wire [4:0]  RsD, RtD, RdD,
    input  wire        RegWriteD, MemtoRegD, MemWriteD,
    input  wire [2:0]  ALUControlD,
    input  wire        ALUSrcD, RegDstD,

    // Forwarding sources
    input  wire [31:0] ResultW, ALUOutM,
    input  wire [1:0]  ForwardAE, ForwardBE,

    // E-stage outputs (hazard unit and EX/MEM register both use these)
    output wire [4:0]  RsE, RtE, WriteRegE,
    output wire        RegWriteE, MemtoRegE, MemWriteE,
    output wire [31:0] ALUOutE, WriteDataE
);
    wire [31:0] RD1E, RD2E, SignImmE;
    wire [4:0]  RdE;
    wire [2:0]  ALUControlE;
    wire        ALUSrcE, RegDstE;

    decode_excute_Reg id_ex_reg (
        .clk(clk), .rst(rst), .clr(FlushE),
        .RD1D(RD1D), .RD2D(RD2D), .SignImmD(SignImmD),
        .RsD(RsD), .RtD(RtD), .RdD(RdD),
        .RegWriteD(RegWriteD), .MemtoRegD(MemtoRegD), .MemWriteD(MemWriteD),
        .ALUControlD(ALUControlD), .ALUSrcD(ALUSrcD), .RegDstD(RegDstD),
        .RD1E(RD1E), .RD2E(RD2E), .SignImmE(SignImmE),
        .RsE(RsE), .RtE(RtE), .RdE(RdE),
        .RegWriteE(RegWriteE), .MemtoRegE(MemtoRegE), .MemWriteE(MemWriteE),
        .ALUControlE(ALUControlE), .ALUSrcE(ALUSrcE), .RegDstE(RegDstE)
    );

    // execute ex_stage (
    //     .RegWriteE(RegWriteE), .ALUSrcE(ALUSrcE), .MemWriteE(MemWriteE),
    //     .MemtoRegE(MemtoRegE), .ALUControlE(ALUControlE),
    //     .RD1E(RD1E), .RD2E(RD2E), .SignImmE(SignImmE), .RtE(RtE), .RdE(RdE),
    //     .RegDstE(RegDstE), .ResultW(ResultW), .ALUOutM(ALUOutM),
    //     .ForwardAE(ForwardAE), .ForwardBE(ForwardBE),
    //     .RegWriteE_out(), .MemWriteE_out(), .MemtoRegE_out(),   // pass-through, unused
    //     .WriteRegE(WriteRegE), .WriteDataE(WriteDataE), .ALUOutE(ALUOutE)
    // );

    execute ex_stage (
        .ALUSrcE(ALUSrcE), .RegDstE(RegDstE), .ALUControlE(ALUControlE),
        .RD1E(RD1E), .RD2E(RD2E), .SignImmE(SignImmE), .RtE(RtE), .RdE(RdE),
        .ResultW(ResultW), .ALUOutM(ALUOutM),
        .ForwardAE(ForwardAE), .ForwardBE(ForwardBE),
        .WriteRegE(WriteRegE), .WriteDataE(WriteDataE), .ALUOutE(ALUOutE)
    );
endmodule
