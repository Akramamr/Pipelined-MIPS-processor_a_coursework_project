module fetch_stage (
    input clk ,
    input rst ,
    input StallF,

    
    input [31:0] PCBranchD,
    input PCSrcD,

    input JumpD,
input [31:0] PCJumpD,


    output [31:0] InstrF,
    output [31:0] PCPlus4F
);


wire [31:0] PC;
wire [31:0] PC1;
reg [31:0] PCF;


mux_2x1 m1_br (
    .d0(PCPlus4F),
    .d1(PCBranchD),
    .s(PCSrcD),
    .y(PC1)
);


mux_2x1 m2_ju (
     .d0(PC1),
    .d1(PCJumpD),
    .s(JumpD),
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

imem imem (
    .a(PCF),
    .rd(InstrF)
);



endmodule
