
module writeback(
    input  wire        clk,
    input  wire        rst,
    input  wire        RegWriteM,
    input  wire        MemtoRegM,
    input  wire [4:0]  WriteRegM,
    input  wire [31:0] ALUOutM,
    input  wire [31:0] ReadDataM,
    output reg        RegWriteW,
    output reg [4:0]  WriteRegW,
    output reg [31:0] ResultW
);

    reg  MemtoRegW;
    // reg [4:0] WriteRegW;
    reg [31:0] ALUOutW, ReadDataW;

    always @(posedge clk or posedge rst) begin
       if (rst) begin
            RegWriteW <= 1'b0;
            MemtoRegW <= 1'b0;
            WriteRegW <= 5'h00;
            ALUOutW <= 32'd0;
            ReadDataW <= 32'd0;
        end
        else begin
            RegWriteW <= RegWriteM;
            MemtoRegW <= MemtoRegM;
            WriteRegW <= WriteRegM;
            ALUOutW <= ALUOutM;
            ReadDataW <= ReadDataM;
        end
    end

    mux2 result_mux (
            .d0(ALUOutW),
            .d1(ReadDataW),
            .s(MemtoRegW),
            .y(ResultW)
            );

    // assign RegWriteW = RegWriteW;
    // assign WriteRegW = WriteRegW;

endmodule
