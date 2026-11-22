module decode_stage (
    input clk,
    input rst,
    input zero,

    // From IF/ID
    input [31:0] Instr,
    input [31:0] PCPlus4,

    // From Writeback stage
    input RegWriteW,
    input [4:0] WriteRegW,
    input [31:0] ResultW,

    // Data outputs
    output [31:0] RD1D,
    output [31:0] RD2D,
    output [31:0] SignImmD,
    output [31:0] PCPlus4_out,

    // Register addresses
    output [4:0] RsD,
    output [4:0] RtD,
    output [4:0] RdD,

    // Control outputs
    output RegWriteD,
    output MemtoRegD,
    output MemWriteD,
    output BranchD,
    output [2:0] ALUControlD,
    output ALUSrcD,
    output RegDstD,
    output jumpd,
    output pcsrcd

);

// Internal signals
wire [31:0] Instrd,
wire [31:0] PCPlus4d,


// 1. The fitch decode flipflop
fdreg fd (
    .clk(clk),
    .rst(rst),
    .InstrF(Instr),
    .PCPlus4F(PCPlus4),
    .InstrD(Instrd),
    .PCPlus4D(PCPlus4d)
)

// 2. Extract register addresses
assign RsD = InstrD[25:21];
assign RtD = InstrD[20:16];
assign RdD = InstrD[15:11];

// 3. Pass PC + 4 to the next stage
assign PCPlus4_out = PCPlus4D;

// 4. Register File
reg_file RF (
    .clk(clk),
    .rst(rst),
    .en_reg_wr(RegWriteW),
    .rd_reg1(RsD),
    .rd_reg2(RtD),
    .wr_data(WriteRegW),
    .wr_data(ResultW),
    .rd_data1(RD1D),
    .rd_data2(RD2D)
);

// 5. Sign Extend
sign_ext SE (
    .instruction(InstrD[15:0]),
    .ext_out(SignImmD)
);

// 6. Control Unit
Control_unit CU (
    .opcode(InstrD[31:26]),
    .funct(InstrD[5:0]),
    .zero(zero),

    .regwrite(RegWriteD),
    .memtoreg(MemtoRegD),
    .memwrite(MemWriteD),
    .branch(BranchD),
    .alucontrol(ALUControlD),
    .alusrc(ALUSrcD),
    .regdst(RegDstD),
    .jump(jumpd),
    .pcsrc(pcsrcd)
);

endmodule