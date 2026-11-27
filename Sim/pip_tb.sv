    `timescale 1ns / 1ps

module pip_tb;

    reg         clk;
    reg         reset;
    wire [31:0] WriteData;
    wire [31:0] ALUOut;
    wire        MemWriteM_out;
    wire [31:0] ReadData;

    // Instantiate DUT matching your exact signal hierarchy
    pip_top top (
        .clk           (clk),
        .rst         (reset),
        .WriteDataM_out     (WriteData),
        .ALUOutMout_tb        (ALUOut),
        .MemWriteM_out (MemWriteM_out),
        .ReadDataW_out      (ReadData)
    );

    // 10ns clock period
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    integer i;
    initial begin
        // 1. Explicitly zero-initialize Register File and Data Memory
        for (i = 0; i < 32; i = i + 1)
            top.decode_S.RF.registers[i] = 32'b0;

        for (i = 0; i < 64; i = i + 1)
            top.mem_S.dmem.D_mem[i] = 32'b0;

        // 2. Active-low reset pulse (flip to 1 then 0 if your design uses active-high reset)
        reset = 0;
        #12;
        reset = 1;

        // 3. Run 25 cycles to complete all 18 instructions
        repeat (25) @(posedge clk);
        #1;

        // 4. Full register and memory verification dump
        $display("=== Final Register & Memory Check ===");
        $display("$2 (registers[2]) = %0d (Expected: 7)",  top.decode_S.RF.registers[2]);
        $display("$3 (registers[3]) = %0d (Expected: 12)", top.decode_S.RF.registers[3]);
        $display("$4 (registers[4]) = %0d (Expected: 1)",  top.decode_S.RF.registers[4]);
        $display("$5 (registers[5]) = %0d (Expected: 11)", top.decode_S.RF.registers[5]);
        $display("$7 (registers[7]) = %0d (Expected: 7)",  top.decode_S.RF.registers[7]);
        $display("D_mem[20] (0x50)  = %0d (Expected: 7)",  top.mem_S.dmem.D_mem[20]);
        $display("D_mem[21] (0x54)  = %0d (Expected: 7)",  top.mem_S.dmem.D_mem[21]);

        if (top.decode_S.RF.registers[2] === 32'd7  &&
            top.decode_S.RF.registers[3] === 32'd12 &&
            top.decode_S.RF.registers[4] === 32'd1  &&
            top.decode_S.RF.registers[5] === 32'd11 &&
            top.decode_S.RF.registers[7] === 32'd7  &&
            top.mem_S.dmem.D_mem[20]     === 32'd7  &&
            top.mem_S.dmem.D_mem[21]     === 32'd7)
             begin
            $display("STATUS: PASS - All instructions, hazards, branches, and jumps succeeded.");
        end else begin
            $display("STATUS: FAIL - Compare waveform signals against the cycle-by-cycle table.");
        end

        $finish;
    end

    // Monitor final memory write on Cycle 23 (Harris & Harris completion condition)
    always @(negedge clk) begin
        if (MemWriteM_out) begin
            if (ALUOut === 32'd84 && WriteData === 32'd7) begin
                $display("[%0t ns] Final store verified: D_mem[21] (0x54) <= 7", $time);
            end else if (ALUOut !== 32'd80) begin
                $display("[%0t ns] ERROR: Unexpected store to Addr=%0d Data=%0d", $time, ALUOut, WriteData);
            end
        end
    end

endmodule







































/*
module pip_tb;

bit clk ,reset;
// bit MemWrite;
logic [31:0 ] ALUOut,ReadData,WriteData;
bit MemWriteM_out;

pip_top top(.clk(clk),.rst(reset),
            .ALUOutMout_tb(ALUOut),.ReadDataW_out(ReadData),.WriteDataM_out(WriteData),
            .MemWriteM_out(MemWriteM_out));


initial begin
    clk =0;
    forever begin
        #10ns clk =~clk;
    end
end

initial begin
    reset =0;
    #20ns;
    reset =1;

    #700ns;
    $stop;
end
always @ (negedge clk)
    begin
        if(MemWriteM_out)begin
            if(ALUOut== 84 & WriteData ==7)begin
            // if(1)begin
                $display("********************************");
                $display("the final data address is :: %0d ",ALUOut);
                $display("the final data value is :: %0d ",WriteData);
                $display("---------Simulation succeeded------------");
                $display("********************************");
                // $stop;
            end 
            else if(ALUOut != 80)begin
                $display("********************************");
                $display("the final data address is :: %0d ",ALUOut);
                $display("the final data value is :: %0d ",WriteData);
                $display("Simulation failed");
                $display("********************************");
                // $stop;
            end
        end
    end
    







endmodule
    */
    
