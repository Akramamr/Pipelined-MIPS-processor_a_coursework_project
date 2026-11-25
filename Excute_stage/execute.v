// Execute stage: combinational datapath. Inputs are ID/EX outputs; outputs feed EX/MEM.
module excute (
    input  wire        ALUSrcE, RegDstE,
    input  wire [2:0]  ALUControlE,
    input  wire [31:0] RD1E, RD2E, SignImmE,
    input  wire [4:0]  RtE, RdE,
    input  wire [31:0] ResultW, ALUOutM,
    input  wire [1:0]  ForwardAE, ForwardBE,

    output wire [4:0]  WriteRegE,
    output wire [31:0] WriteDataE, ALUOutE
);
    wire [31:0] SrcAE, SrcBE;

    assign WriteRegE = RegDstE ? RdE : RtE;

    
    
    
    assign SrcAE      = ForwardAE[1] ? ALUOutM : (ForwardAE[0] ? ResultW : RD1E);
    assign WriteDataE = ForwardBE[1] ? ALUOutM : (ForwardBE[0] ? ResultW : RD2E);

    assign SrcBE = ALUSrcE ? SignImmE : WriteDataE;

    alu alu_unit (.a(SrcAE), .b(SrcBE), .shamt(SignImmE[10:6]),
                  .alucontrol({1'b0, ALUControlE}), .result(ALUOutE),
                  .zero(), .sign(), .overflow());
endmodule
