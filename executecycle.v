module execute(
    input wire clk,
    input wire rst,
    input wire RegWriteE,
    input wire ALUSrcE,
    input wire MemWriteE,
    input wire MemtoRegE,
    input wire [3:0] ALUControlE,
    input wire [31:0] RD1E,
    input wire [31:0] RD2E,
    input wire [31:0] SignImmE,
    input wire [4:0] WriteRegE,
    input wire [31:0] PCPlus4E,
    input wire [31:0] ResultW,
    input wire [1:0] ForwardAE,
    input wire [1:0] ForwardBE,

    output reg RegWriteM,
    output reg MemWriteM,
    output reg MemtoRegM,
    output reg [4:0] WriteRegM,
    output reg [31:0] PCPlus4M,
    output reg [31:0] WriteDataM,
    output reg [31:0] ALUOutM
);

    // Declaration of Interim Wires
    wire [31:0] SrcAE, WriteDataE, SrcBE;
    wire [31:0] ALUOutE;

    // Forwarding Mux for Source A
    assign SrcAE = (ForwardAE == 2'b00) ? RD1E :
                   (ForwardAE == 2'b01) ? ResultW :
                   (ForwardAE == 2'b10) ? ALUOutM : 32'b0;

    // Forwarding Mux for Source B / Store Data
    assign WriteDataE = (ForwardBE == 2'b00) ? RD2E :
                        (ForwardBE == 2'b01) ? ResultW :
                        (ForwardBE == 2'b10) ? ALUOutM : 32'b0;

    // ALU Src Mux
    mux2 alu_src_mux (
        .d0(WriteDataE),
        .d1(SignImmE),
        .s(ALUSrcE),
        .y(SrcBE)
    );

    // ALU Unit
    alu alu_unit (
        .a(SrcAE),
        .b(SrcBE),
        .shamt(SignImmE[10:6]),
        .alucontrol(ALUControlE),
        .result(ALUOutE),
        .zero(),
        .sign(),
        .overflow()
    );

    always @(posedge clk or negedge rst) begin
        if (rst == 1'b0) begin
            RegWriteM <= 1'b0;
            MemWriteM <= 1'b0;
            MemtoRegM <= 1'b0;
            WriteRegM <= 5'h00;
            PCPlus4M <= 32'h00000000;
            WriteDataM <= 32'h00000000;
            ALUOutM <= 32'h00000000;
        end
        else begin
            RegWriteM <= RegWriteE;
            MemWriteM <= MemWriteE;
            MemtoRegM <= MemtoRegE;
            WriteRegM <= WriteRegE;
            PCPlus4M <= PCPlus4E;
            WriteDataM <= WriteDataE;
            ALUOutM <= ALUOutE;
        end
    end

endmodule
