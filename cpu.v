// Generated from iroha-0.0.1.

// Module 1;
module cpu_main(
  input clk,
  input rst);

  // State decls
  // state names
  localparam S_1_1 = 1;
  localparam S_1_4 = 4;
  localparam S_1_37 = 37;
  localparam S_1_39 = 39;
  localparam S_1_43 = 43;
  localparam S_1_46 = 46;
  localparam S_1_50 = 50;
  localparam S_1_53 = 53;
  localparam S_1_57 = 57;
  reg [6:0] st_1;

  // Shared wires
  // Shared insn wires
  // Shared insn assigns

  // Registers for table 1
  reg  [15:0] main_op_4_26; // main_op_4_26
  reg  [15:0] main_3_25; // main_3_25
  reg  [3:0] m_pc_1_23; // m_pc_1_23
  reg  [3:0] main_pc_2_24; // main_pc_2_24
  reg  [2:0] main_5_27; // main_5_27
  reg  [2:0] main_source_6_28; // main_source_6_28
  reg  [2:0] main_7_29; // main_7_29
  reg  [2:0] main_operation_8_30; // main_operation_8_30
  reg  [2:0] main_9_31; // main_9_31
  reg  [2:0] main_output_dest_10_32; // main_output_dest_10_32
  reg  [0:0] main_11_33; // main_11_33
  reg  [0:0] main_flow_12_34; // main_flow_12_34
  reg  [3:0] main_13_35; // main_13_35
  reg  [3:0] main_jump_14_36; // main_jump_14_36
  reg  [7:0] main_src_value_15_37; // main_src_value_15_37
  reg  main_16_38; // main_16_38
  reg  main_17_39; // main_17_39
  reg  [7:0] m_acc_18_40; // m_acc_18_40
  reg  [7:0] main_acc_19_41; // main_acc_19_41
  reg  main_20_42; // main_20_42
  reg  [7:0] m_bak_21_43; // m_bak_21_43
  reg  [7:0] main_bak_22_44; // main_bak_22_44
  wire  [3:0] main_pc_2_24_w0i4; // main_pc_2_24_w0i4
  wire  [15:0] main_3_25_w0i10; // main_3_25_w0i10
  wire  [15:0] main_op_4_26_w0i12; // main_op_4_26_w0i12
  wire  [2:0] main_5_27_w0i16; // main_5_27_w0i16
  wire  [2:0] main_source_6_28_w0i18; // main_source_6_28_w0i18
  wire  [2:0] main_7_29_w0i22; // main_7_29_w0i22
  wire  [2:0] main_9_31_w0i28; // main_9_31_w0i28
  wire  [0:0] main_11_33_w0i34; // main_11_33_w0i34
  wire  [3:0] main_13_35_w0i40; // main_13_35_w0i40
  wire  main_16_38_w0i48; // main_16_38_w0i48
  wire  main_17_39_w0i56; // main_17_39_w0i56
  wire  [7:0] main_acc_19_41_w0i61; // main_acc_19_41_w0i61
  wire  main_20_42_w0i66; // main_20_42_w0i66
  wire  [7:0] main_bak_22_44_w0i71; // main_bak_22_44_w0i71

  // Insn wires for table 1
  wire  [3:0] insn_o_1_4_0;
  wire  [7:0] insn_o_1_45_0;
  wire  [3:0] insn_o_1_2_0;
  wire  [15:0] insn_o_1_10_0;
  wire  [15:0] insn_o_1_12_0;
  wire  [2:0] insn_o_1_16_0;
  wire  [2:0] insn_o_1_18_0;
  wire  [2:0] insn_o_1_22_0;
  wire  [2:0] insn_o_1_24_0;
  wire  [2:0] insn_o_1_28_0;
  wire  [2:0] insn_o_1_30_0;
  wire  [0:0] insn_o_1_34_0;
  wire  [0:0] insn_o_1_36_0;
  wire  [3:0] insn_o_1_40_0;
  wire  [3:0] insn_o_1_42_0;
  wire  insn_o_1_48_0;
  wire  [15:0] insn_o_1_3_0;
  wire  [15:0] insn_o_1_5_0;
  wire  [2:0] insn_o_1_6_0;
  wire  [2:0] insn_o_1_7_0;
  wire  [2:0] insn_o_1_9_0;
  wire  [2:0] insn_o_1_11_0;
  wire  [0:0] insn_o_1_13_0;
  wire  [3:0] insn_o_1_14_0;
  wire  insn_o_1_15_0;
  wire  [7:0] insn_o_1_53_0;
  wire  insn_o_1_56_0;
  wire  insn_o_1_17_0;
  wire  [7:0] insn_o_1_61_0;
  wire  [7:0] insn_o_1_63_0;
  wire  [7:0] insn_o_1_19_0;
  wire  insn_o_1_66_0;
  wire  insn_o_1_20_0;
  wire  [7:0] insn_o_1_71_0;
  wire  [7:0] insn_o_1_73_0;
  wire  [7:0] insn_o_1_21_0;

  // Insn values for table 1
  assign main_pc_2_24_w0i4 = m_pc_1_23;
  assign insn_o_1_10_0 = sram4_rdata;
  assign main_3_25_w0i10 = insn_o_1_10_0;
  assign main_op_4_26_w0i12 = main_3_25_w0i10;
  assign insn_o_1_16_0 = main_op_4_26_w0i12[0:2];
  assign main_5_27_w0i16 = insn_o_1_16_0;
  assign main_source_6_28_w0i18 = main_5_27_w0i16;
  assign insn_o_1_22_0 = main_op_4_26_w0i12[3:5];
  assign main_7_29_w0i22 = insn_o_1_22_0;
  assign insn_o_1_28_0 = main_op_4_26_w0i12[6:8];
  assign main_9_31_w0i28 = insn_o_1_28_0;
  assign insn_o_1_34_0 = main_op_4_26_w0i12[9:9];
  assign main_11_33_w0i34 = insn_o_1_34_0;
  assign insn_o_1_40_0 = main_op_4_26_w0i12[10:13];
  assign main_13_35_w0i40 = insn_o_1_40_0;
  assign insn_o_1_48_0 = eq_1_6_d0;
  assign main_16_38_w0i48 = insn_o_1_48_0;
  assign insn_o_1_56_0 = eq_1_6_d0;
  assign main_17_39_w0i56 = insn_o_1_56_0;
  assign main_acc_19_41_w0i61 = m_acc_18_40;
  assign insn_o_1_66_0 = eq_1_6_d0;
  assign main_20_42_w0i66 = insn_o_1_66_0;
  assign main_bak_22_44_w0i71 = m_bak_21_43;

  // Resources for table 1
  reg [3:0] sram4_addr;
  wire [15:0] sram4_rdata;
  reg [15:0] sram4_wdata;
  reg sram4_wdata_en;
  // eq:6
  wire [2:0] eq_1_6_s0;
  assign eq_1_6_s0 = (st_1 == S_1_46) ? main_source_6_28 : ((st_1 == S_1_39) ? main_source_6_28 : (main_source_6_28_w0i18));
  wire [2:0] eq_1_6_s1;
  assign eq_1_6_s1 = (st_1 == S_1_46) ? 32'd3 : ((st_1 == S_1_39) ? 32'd2 : (32'd1));
  wire eq_1_6_d0;
  assign eq_1_6_d0 = eq_1_6_s0 == eq_1_6_s1;

  // Table 1
  always @(posedge clk) begin
    if (rst) begin
      st_1 <= S_1_1;
      m_pc_1_23 <= 0;
      m_acc_18_40 <= 0;
      m_bak_21_43 <= 0;
    end else begin
      sram4_wdata_en <= 0;
      case (st_1)
        S_1_1: begin
          sram4_addr <= main_pc_2_24_w0i4;
          main_src_value_15_37 <= 8'd0;
          main_pc_2_24 <= main_pc_2_24_w0i4;
          st_1 <= S_1_4;
        end
        S_1_4: begin
          main_operation_8_30 <= main_7_29_w0i22;
          main_output_dest_10_32 <= main_9_31_w0i28;
          main_flow_12_34 <= main_11_33_w0i34;
          main_jump_14_36 <= main_13_35_w0i40;
          main_3_25 <= main_3_25_w0i10;
          main_op_4_26 <= main_op_4_26_w0i12;
          main_5_27 <= main_5_27_w0i16;
          main_source_6_28 <= main_source_6_28_w0i18;
          main_7_29 <= main_7_29_w0i22;
          main_9_31 <= main_9_31_w0i28;
          main_11_33 <= main_11_33_w0i34;
          main_13_35 <= main_13_35_w0i40;
          main_16_38 <= main_16_38_w0i48;
          if (main_16_38_w0i48) begin
            st_1 <= S_1_37;
          end else begin
            st_1 <= S_1_39;
          end
        end
        S_1_37: begin
          main_src_value_15_37 <= 8'd1;
          st_1 <= S_1_39;
        end
        S_1_39: begin
          main_17_39 <= main_17_39_w0i56;
          if (main_17_39_w0i56) begin
            st_1 <= S_1_43;
          end else begin
            st_1 <= S_1_46;
          end
        end
        S_1_43: begin
          main_src_value_15_37 <= main_acc_19_41_w0i61;
          main_acc_19_41 <= main_acc_19_41_w0i61;
          st_1 <= S_1_46;
        end
        S_1_46: begin
          main_20_42 <= main_20_42_w0i66;
          if (main_20_42_w0i66) begin
            st_1 <= S_1_50;
          end else begin
            st_1 <= S_1_53;
          end
        end
        S_1_50: begin
          main_src_value_15_37 <= main_bak_22_44_w0i71;
          main_bak_22_44 <= main_bak_22_44_w0i71;
          st_1 <= S_1_53;
        end
        S_1_53: begin
          $display("%m:1:76 %d", main_op_4_26);
          st_1 <= S_1_57;
        end
        S_1_57: begin
        end
      endcase
    end
  end
  SRAM_4_16 SRAM_4_16_inst_4(.clk(clk), .rst(rst), .addr_i(sram4_addr), .rdata_o(sram4_rdata), .wdata_i(sram4_wdata), .write_en_i(sram4_wdata_en));

endmodule // cpu_main
`ifndef STRIP_SHELL
module cpu(
  input clk,
  input rst);
  cpu_main cpu_main_inst(.clk(clk), .rst(rst));

endmodule  // cpu
`endif  // STRIP_SHELL

// NOTE: Please copy the follwoing line to your design.
// cpu cpu_inst(.clk(), .rst());
//
// NOTE: This can be used by your script to auto generate the instantiation and connections.
// :connection: cpu:cpu_inst input:0::clk,input:0::rst

// SRAM(1 port(s))
`ifndef SRAM_4_16_defined
`define SRAM_4_16_defined
module SRAM_4_16(
  input clk,
  input rst,
  input [3:0] addr_i,
  output reg [15:0] rdata_o,
  input [15:0] wdata_i,
  input write_en_i);

  reg [15:0] data [0:15];

  always @(posedge clk) begin
    if (rst) begin
      data[0] <= 0;
      data[1] <= 0;
      data[2] <= 0;
      data[3] <= 0;
      data[4] <= 0;
      data[5] <= 0;
      data[6] <= 0;
      data[7] <= 0;
      data[8] <= 0;
      data[9] <= 0;
      data[10] <= 0;
      data[11] <= 0;
      data[12] <= 0;
      data[13] <= 0;
      data[14] <= 0;
      data[15] <= 0;
    end else begin
      if (write_en_i) begin
        data[addr_i] <= wdata_i;
      end
    end
  end
  // Read
  always @(addr_i or clk) begin
    rdata_o = data[addr_i];
  end
endmodule
`endif  // SRAM_4_16_defined

