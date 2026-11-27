module imem 
(input [31:0] a,
output [31:0] rd);

reg [31:0] ROM[63:0];


initial
begin
$readmemh ("instr.dat",ROM);
end
assign rd = ROM[a[7:2]]; 
endmodule
