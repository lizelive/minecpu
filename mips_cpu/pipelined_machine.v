module pipelined_machine(clk, reset);
   input        clk, reset;

   wire [31:0]  PC;
   wire [31:2]  next_PC, PC_plus4, PC_target, pc_de;
   wire [31:0]  inst;
   
   wire [31:0]  imm = {{ 16{inst[15]} }, inst[15:0] };  // sign-extended immediate
   wire [4:0]   rs = inst[25:21];
   wire [4:0]   rt = inst[20:16];
   wire [4:0]   rd = inst[15:11];
   wire [5:0]   opcode = inst[31:26];
   wire [5:0]   funct = inst[5:0];

   wire [4:0]   wr_regnum, wr_regnum_MW;
   wire [2:0]   ALUOp;

   wire         RegWrite, RegWrite_MW, BEQ, ALUSrc, MemRead, MemWrite, MemToReg, MemToReg_MW, RegDst;
   wire         PCSrc, zero;
   wire [31:0]  rd1_data, rd2_data, rd2_data_mw, B_data, alu_out_data, alu_out_data_mw, load_data, wr_data;


   register #(30, 30'h100000) PC_reg(PC[31:2], next_PC[31:2], clk, /* enable */!stall, reset);
   assign PC[1:0] = 2'b0;  // bottom bits hard coded to 00
   adder30 next_PC_adder(PC_plus4, PC[31:2], 30'h1);
   
   adder30 target_PC_adder(PC_target, pc_de, imm[29:0]);
   
   mux2v #(30) branch_mux(next_PC, PC_plus4, PC_target, PCSrc);
   wire flush = reset || PCSrc;
   
   assign PCSrc = BEQ & zero;
   
   //stalling
   wire stall = MemRead_MW && ( (wr_regnum_MW == rt && RegDst) || wr_regnum_MW == rs);//Maybe?
   //WTF is the deal about don't stall when I am ignoring the data I got?
   //Also, stall on use? We don't stall on use!
   
   instruction_memory imem (inst_if, PC[31:2]);
   wire [31:0]  inst_if;
   
   //IF/DE
   register ifde_inst(inst, inst_if, clk, !stall, flush);
   register #(30) ifde_PC (pc_de, PC_plus4, clk, !stall, flush);
   
   //DE/MW
   register dwmw_alu_out_data(alu_out_data_mw, alu_out_data, clk, 1'b1, reset);
   
   mips_decode decode(ALUOp, RegWrite, BEQ, ALUSrc, MemRead, MemWrite, MemToReg, RegDst, opcode, funct);
   register #(4) control_demw({MemRead_MW, MemWrite_MW, RegWrite_MW, MemToReg_MW}, {MemRead, MemWrite, RegWrite, MemToReg}, clk, 1'b1, stall||reset);
   register #(5) wr_regnum_demw(wr_regnum_MW, wr_regnum, clk, 1'b1, stall||reset);
   register r2_data_demw(rd2_data_mw, rd2_data_fwd, clk, 1'b1, stall||reset);
   
   wire  MemRead_MW, MemWrite_MW;
   
   
   
   regfile rf (rd1_data, rd2_data,
               rs, rt, wr_regnum_MW, wr_data, 
               RegWrite_MW, clk, reset);

   mux2v #(32) imm_mux(B_data, rd2_data_fwd, imm, ALUSrc);
   alu32 alu(alu_out_data, zero, ALUOp, rd1_data_fwd, B_data);
   
   //forwarding
   mux2v #(32) ForwardA(rd1_data_fwd, rd1_data, wr_data, RegWrite_MW && (rs == wr_regnum_MW) && ( wr_regnum_MW != 0));
   mux2v #(32) ForwardB(rd2_data_fwd, rd2_data, wr_data, RegWrite_MW && (rt == wr_regnum_MW) && ( wr_regnum_MW != 0));
   wire [31:0] rd1_data_fwd, rd2_data_fwd;   
   
   
   data_mem data_memory(load_data, alu_out_data_mw, rd2_data_mw, MemRead_MW, MemWrite_MW, clk, reset);
   
   mux2v #(32) wb_mux(wr_data, alu_out_data_mw, load_data, MemToReg_MW);
   mux2v #(5) rd_mux(wr_regnum, rt, rd, RegDst);
   
endmodule // pipelined_machine
