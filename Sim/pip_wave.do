add wave -position insertpoint  \
sim:/pip_tb/ALUOut \
sim:/pip_tb/clk \
sim:/pip_tb/MemWriteM_out \
sim:/pip_tb/ReadData \
sim:/pip_tb/reset \
sim:/pip_tb/WriteData
add wave -position insertpoint  \
sim:/pip_tb/top/fetch_S/InstrF \
sim:/pip_tb/top/fetch_S/JumpD \
sim:/pip_tb/top/fetch_S/PC \
sim:/pip_tb/top/fetch_S/PC1 \
sim:/pip_tb/top/fetch_S/PCBranchD \
sim:/pip_tb/top/fetch_S/PCF \
sim:/pip_tb/top/fetch_S/PCJumpD \
sim:/pip_tb/top/fetch_S/PCPlus4F \
sim:/pip_tb/top/fetch_S/PCSrcD \
sim:/pip_tb/top/fetch_S/rst \
sim:/pip_tb/top/fetch_S/StallF
add wave -position insertpoint  \
sim:/pip_tb/top/decode_S/FetchDecode_R/en \
sim:/pip_tb/top/decode_S/FetchDecode_R/InstrD \
sim:/pip_tb/top/decode_S/FetchDecode_R/PCPlus4D
add wave -position insertpoint  \
sim:/pip_tb/top/fetch_S/imem/ROM
add wave -position insertpoint  \
sim:/pip_tb/top/decode_S/StallD
add wave -position insertpoint  \
sim:/pip_tb/top/hazard_U/BranchD \
sim:/pip_tb/top/hazard_U/branchstall \
sim:/pip_tb/top/hazard_U/FlushE \
sim:/pip_tb/top/hazard_U/ForwardAD \
sim:/pip_tb/top/hazard_U/ForwardAE \
sim:/pip_tb/top/hazard_U/ForwardBD \
sim:/pip_tb/top/hazard_U/ForwardBE \
sim:/pip_tb/top/hazard_U/lwstall
add wave -position insertpoint  \
sim:/pip_tb/top/decode_S/CU/branchD
add wave -position insertpoint  \
sim:/pip_tb/top/excute_S/ALUControlD \
sim:/pip_tb/top/excute_S/ALUControlE \
sim:/pip_tb/top/excute_S/ALUOutE \
sim:/pip_tb/top/excute_S/ALUOutM \
sim:/pip_tb/top/excute_S/ALUSrcD \
sim:/pip_tb/top/excute_S/ALUSrcE \
sim:/pip_tb/top/excute_S/MemtoRegD \
sim:/pip_tb/top/excute_S/MemtoRegE \
sim:/pip_tb/top/excute_S/MemWriteD \
sim:/pip_tb/top/excute_S/MemWriteE \
sim:/pip_tb/top/excute_S/RD1D \
sim:/pip_tb/top/excute_S/RD1E \
sim:/pip_tb/top/excute_S/RD2D \
sim:/pip_tb/top/excute_S/RD2E \
sim:/pip_tb/top/excute_S/RdD \
sim:/pip_tb/top/excute_S/RdE \
sim:/pip_tb/top/excute_S/RegDstD \
sim:/pip_tb/top/excute_S/RegDstE \
sim:/pip_tb/top/excute_S/RegWriteD \
sim:/pip_tb/top/excute_S/RegWriteE \
sim:/pip_tb/top/excute_S/ResultW \
sim:/pip_tb/top/excute_S/RsD \
sim:/pip_tb/top/excute_S/RsE \
sim:/pip_tb/top/excute_S/RtD \
sim:/pip_tb/top/excute_S/RtE \
sim:/pip_tb/top/excute_S/SignImmD \
sim:/pip_tb/top/excute_S/SignImmE \
sim:/pip_tb/top/excute_S/WriteDataE \
sim:/pip_tb/top/excute_S/WriteRegE
add wave -position insertpoint  \
sim:/pip_tb/top/mem_S/ALUOutMout \
sim:/pip_tb/top/mem_S/MemtoRegM \
sim:/pip_tb/top/mem_S/MemWriteM \
sim:/pip_tb/top/mem_S/ReadDataM \
sim:/pip_tb/top/mem_S/RegWriteM \
sim:/pip_tb/top/mem_S/WIDTH \
sim:/pip_tb/top/mem_S/WriteDataM \
sim:/pip_tb/top/mem_S/WriteDataM_out \
sim:/pip_tb/top/mem_S/WriteRegM
add wave -position insertpoint  \
sim:/pip_tb/top/mem_S/dmem/D_mem
add wave -position insertpoint  \
sim:/pip_tb/top/excute_S/ex_stage/SrcAE \
sim:/pip_tb/top/excute_S/ex_stage/SrcBE
add wave -position insertpoint  \
sim:/pip_tb/top/decode_S/RF/rd_reg1 \
sim:/pip_tb/top/decode_S/RF/rd_reg2
add wave -position insertpoint  \
sim:/pip_tb/top/decode_S/RF/registers \
sim:/pip_tb/top/decode_S/RF/en_reg_wr
add wave -position insertpoint  \
sim:/pip_tb/top/writeBack_S/MemtoRegW \
sim:/pip_tb/top/WriteRegW