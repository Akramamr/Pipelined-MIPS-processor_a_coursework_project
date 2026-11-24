module execute (
    input wire clk,
    input wire rst,

    input wire RegWriteE,
    input wire ALUSrcE,
    input wire MemWriteE,
    input wire MemtoRegE,
    input wire [2:0] ALUControlE,

    input wire [31:0] RD1E,
    input wire [31:0] RD2E,
    input wire [31:0] SignImmE,


    input wire [4:0] RtE,
    input wire [4:0] RdE,
    input wire RegDstE,

    input wire [31:0] ResultW,
    input wire [1:0] ForwardAE,
    input wire [1:0] ForwardBE,

  
    output wire [4:0] WriteRegE,
    output wire RegWriteM,
    output wire MemWriteM,
    output wire MemtoRegM,
    output wire [4:0] WriteRegM,

    output wire [31:0] WriteDataM,
    output wire [31:0] ALUOutM
);


    wire [31:0] SrcAE;      
    wire [31:0] WriteDataE;  
    wire [31:0] SrcBE;       
    wire [31:0] ALUOutE;    

    assign WriteRegE = RegDstE ? RdE : RtE;

    assign SrcAE = (ForwardAE == 2'b00) ? RD1E :
                   (ForwardAE == 2'b01) ? ResultW :
                   (ForwardAE == 2'b10) ? ALUOutM :
                                          32'b0;


    assign WriteDataE = (ForwardBE == 2'b00) ? RD2E :
                        (ForwardBE == 2'b01) ? ResultW :
                        (ForwardBE == 2'b10) ? ALUOutM :
                                               32'b0;


    assign SrcBE = ALUSrcE ? SignImmE : WriteDataE;

    alu alu_unit (
        .a          (SrcAE),
        .b          (SrcBE),
        .shamt      (SignImmE[10:6]),
        .alucontrol ({1'b0, ALUControlE}),
        .result     (ALUOutE),
        .zero       (),
        .sign       (),
        .overflow   ()
    );

    EXMEM exmem_reg (
        .clk        (clk),
        .rst        (rst),
        .RegWriteE  (RegWriteE),
        .MemWriteE  (MemWriteE),
        .MemtoRegE  (MemtoRegE),
        .WriteRegE  (WriteRegE),

        .WriteDataE (WriteDataE),
        .ALUOutE    (ALUOutE),
        .RegWriteM  (RegWriteM),
        .MemWriteM  (MemWriteM),
        .MemtoRegM  (MemtoRegM),
        .WriteRegM  (WriteRegM),

        .WriteDataM (WriteDataM),
        .ALUOutM    (ALUOutM)
    );

endmodule
