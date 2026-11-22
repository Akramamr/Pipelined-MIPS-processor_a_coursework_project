module writeback(
    input  wire        clk,
    input  wire        rst,
    input  wire        RegWriteM,
    input  wire        MemtoRegM,
    input  wire [4:0]  WriteRegM,
    input  wire [31:0] ALUOutM,
    input  wire [31:0] ReadDataM,
    output wire        RegWriteW,
    output wire [4:0]  WriteRegW,
    output wire [31:0] ResultW
);

    reg RegWriteW_r, MemtoRegW_r;
    reg [4:0] WriteRegW_r;
    reg [31:0] ALUOutW_r, ReadDataW_r;

    always @(posedge clk or posedge rst) begin
        if (rst == 1'b0) begin
            RegWriteW_r <= 1'b0;
            MemtoRegW_r <= 1'b0;
            WriteRegW_r <= 5'h00;
            ALUOutW_r <= 32'd0;
            ReadDataW_r <= 32'd0;
        end
        else begin
            RegWriteW_r <= RegWriteM;
            MemtoRegW_r <= MemtoRegM;
            WriteRegW_r <= WriteRegM;
            ALUOutW_r <= ALUOutM;
            ReadDataW_r <= ReadDataM;
        end
    end

    mux2 result_mux (
            .d0(ALUOutW_r),
            .d1(ReadDataW_r),
            .s(MemtoRegW_r),
            .y(ResultW)
            );

    assign RegWriteW = RegWriteW_r;
    assign WriteRegW = WriteRegW_r;

endmodule
