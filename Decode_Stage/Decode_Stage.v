module decode_stage (
    input clk,
    input rst,
    //input zero,

    // From IF/ID
    input [31:0] InstrF,
    input [31:0] PCPlus4F,

    // From Writeback stage
    input RegWriteW,
    input [4:0] WriteRegW,
    input [31:0] ResultW,

    // From Hazard unit
    input ForwardAD,
    input ForwardBD,
    input StallD,


    // From ALU
    input [31:0] ALUOutM,


    // Data outputs
    output [31:0] RD1D,
    output [31:0] RD2D,
    output [31:0] SignImmD,
    output [31:0] PCJumpD,
    //output [31:0] PCPlus4_out,

    // Register addresses
    output [4:0] RsD,
    output [4:0] RtD,
    output [4:0] RdD,

    // Control outputs
    output RegWriteD,
    output MemtoRegD,
    output MemWriteD,
    output [2:0] ALUControlD,
    output ALUSrcD,
    output RegDstD,
    output JumpD,
    output PCSrcD,

    output [31:0] PCBranchD ,
    output BranchD

);

// Internal signals
    wire BranchD_d;
wire [31:0] InstrD;
wire [31:0] PCPlus4D;

wire [31:0] RD1DOUT;
wire [31:0] RD2DOUT;


wire EqualD;

wire [31:0] shfitedSignImmD ;

wire en ;
assign en = !StallD;

// 2. Extract register addresses
assign RsD = InstrD[25:21];
assign RtD = InstrD[20:16];
assign RdD = InstrD[15:11];

assign PCJumpD = {PCPlus4D[31:28], InstrD[25:0], 2'b00};
assign BranchD =BranchD_d;
// 3. Pass PC + 4 to the next stage
//assign PCPlus4_out = PCPlus4D;
// 1. The fitch decode flipflop

FetchDecode_Reg FetchDecode_R (
    .clk(clk),
    .rst(rst),
    .clr(PCSrcD| JumpD),
    .en(en),
    .InstrF(InstrF),
    .PCPlus4F(PCPlus4F),
    .InstrD(InstrD),
    .PCPlus4D(PCPlus4D)
);


// 4. Register File
reg_file RF (
    .clk(clk),
    .rst(rst),
    .en_reg_wr(RegWriteW),
    .rd_reg1(RsD),
    .rd_reg2(RtD),
    .wr_reg(WriteRegW),
    .wr_data(ResultW),
    .rd_data1(RD1D),
    .rd_data2(RD2D)
);

// 5. Sign Extend
sign_ext SEXT (
    .instruction(InstrD[15:0]),
    .ext_out(SignImmD)
);

// 6. Control Unit
control_unit CU (
    .opcode(InstrD[31:26]),
    .funct(InstrD[5:0]),
    // .zero(zero),

    .regwrite(RegWriteD),
    .memtoreg(MemtoRegD),
    .memwrite(MemWriteD),
    .branchD(BranchD_d),
    .alucontrol(ALUControlD),
    .alusrc(ALUSrcD),
    .regdst(RegDstD),
    .jump(JumpD)
    //.pcsrc(PCSrcD)
);


mux_2x1 r1 (
    .d0(RD1D),
    .d1(ALUOutM),
    .s(ForwardAD),
    .y(RD1DOUT)
);

mux_2x1 r2 (
    .d0(RD2D),
    .d1(ALUOutM),
    .s(ForwardBD),
    .y(RD2DOUT)
);

comparator comp (
    .in1(RD1DOUT),
    .in0(RD2DOUT),
    .EqualD(EqualD)
);

assign PCSrcD = EqualD && BranchD_d ;


assign shfitedSignImmD = SignImmD << 2 ;


adder add (
    .a(shfitedSignImmD),
    .b(PCPlus4D),
    .y(PCBranchD)
);


endmodule
