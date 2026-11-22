 
module FDREG (
    input clk,
    input rst,

    input [31:0] InstrF,
    input [31:0] PCPlus4F,

    output reg [31:0] InstrD,
    output reg [31:0] PCPlus4D
);

always @(posedge clk or negedge rst)
begin
    if (!rstt)
    begin
        InstrD <= 32'b0;
        PCPlus4D <= 32'b0;
    end
    else
    begin
        InstrD <= InstrF;
        PCPlus4D <= PCPlus4F;
    end
end

endmodule