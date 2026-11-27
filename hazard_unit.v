module hazard_unit#(parameter WIDTH = 32)(
                    input [$clog2(WIDTH)-1:0] rsD,rtD,rtE,rsE,
                   input [$clog2(WIDTH)-1:0] WriteRegM,WriteRegW,WriteRegE,
                   input RegWriteM,RegWriteE,RegWriteW,
                   input BranchD,MemtoRegM,MemtoRegE,


                   output ForwardAD,ForwardBD,
                   output reg [1:0] ForwardAE,ForwardBE,
                   output StallF,StallD,FlushE);



wire lwstall,branchstall;



//SOLVING DATA HAZARDS WITH FORWARDING
always @(*) begin
    
    if ((rsE !=0 ) && (rsE == WriteRegM ) && RegWriteM)
        ForwardAE = 2'b10;
    else if (((rsE !=0 ) && (rsE == WriteRegW ) && RegWriteW)) begin
        ForwardAE = 2'b01;
        
    end
    else ForwardAE =2'b00;
end

always @(*) begin
    
    if ((rtE !=0 ) && (rtE == WriteRegM ) && RegWriteM)
        ForwardBE = 2'b10;
    else if (((rtE !=0 ) && (rtE == WriteRegW ) && RegWriteW)) begin
        ForwardBE = 2'b01;
        
    end
    else ForwardBE = 2'b00;

end



//LOAD USE HAZARD HANDLING

assign lwstall =(( rsD == rtE) || (rtD == rtE)) && MemtoRegE;



//BRANCH HAZARD HANDLING

assign ForwardAD = (rsD != 0) && (rsD == WriteRegM) && RegWriteM;
assign ForwardBD = (rtD != 0) && (rtD == WriteRegM) && RegWriteM;

assign branchstall = BranchD && RegWriteE &&(WriteRegE != 0) && (WriteRegE == rsD || WriteRegE ==rtD ) || 
              BranchD && MemtoRegM && (WriteRegM != 0) && (WriteRegM == rsD || WriteRegM == rtD );


assign StallF = lwstall || branchstall;
assign FlushE = lwstall || branchstall;
assign StallD = lwstall || branchstall;





endmodule
