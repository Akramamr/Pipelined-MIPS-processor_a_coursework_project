module fetch (
    input clk ,
    input rst ,
    input StallF,

    
    input [31:0] PCBranchD,
    input PCSrcD,

    input Jump,


    output [31:0] InstrF,
    output [31:0] PCPlus4F
);


wire [31:0] PC;
wire [31:0] PC1;
wire [31:0] PCJump;
reg [31:0] PCF;


mux2 m1 (
    .d0(PCPlus4F),
    .d1(PCBranchD),
    .s(PCSrcD),
    .y(PC1)
);


mux m2 (
     .d0(PC1),
    .d1(PCJump),
    .s(Jump),
    .y(PC)
);


always @(posedge clk or negedge rst) begin
    if(!rst)
    begin
      PCF<=0;
    end
    else if (!StallF)
    begin
      PCF<=PC;
    end
end



assign PCPlus4F = PCF + 4 ;

imem a (
    .a(PCF),
    .rd(InstrF)
);


wire [27:0] Instr ;
assign Instr = {InstrF[25:0],2'b00};


assign PCJump = { PCPlus4F[31:28] , Instr};





endmodule