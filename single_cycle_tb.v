/*
* FILE   : single_cycle_tb.v
* AUTHOR : Tony Anwar
* TB for Top Module single cycle
*/
module single_cycle_tb();

  reg        clk;
  reg        reset;

  wire [31:0] writedata, dataadr, pc_out;
  wire        memwrite;

  // instantiate device to be tested
  top_single_cycle dut(
        clk,
        reset, 
        pc_out, 
        dataadr, 
        writedata,
        memwrite
    );

  // initialize test
  initial
    begin
      reset <= 1; # 22; reset <= 0;
    end

  // generate clock to sequence tests
  always
    begin
      clk <= 1; # 5; clk <= 0; # 5;
    end

  // check results
  always @ (negedge clk)
    begin
      if (memwrite) begin
        if (dataadr === 84 & writedata === 7) begin
          $display("Simulation succeeded");
          $stop;
        end else if (dataadr !== 80) begin
          $display("Simulation failed");
          $stop;
        end
      end
    end

endmodule
