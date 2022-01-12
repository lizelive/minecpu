// parameter WIDTH = 4;
// parameter DEPTH = 2;
//`include "define.v"
`define WIDTH 32

`define ALU_RV0   3'b000
`define ALU_OR    3'b001
`define ALU_ADD   3'b010
`define ALU_SUB   3'b011
`define ALU_RV1   3'b100
`define ALU_XOR   3'b111
`define ALU_XNOR    3'b101
`define ALU_AND   3'b110

module serialalu
  (
    input wire a, b,
    input wire c,
    input wire [2:0] s,
    output reg out, cout
  );


  always @(a, b, c, s)
  begin
    case (s)
      `ALU_RV0 : // nop
        {cout, out} <= {c, a};
      `ALU_OR :
        {cout, out} <= {c | (a | b), a | b};
      `ALU_ADD : // carry set to overflow
        {cout, out} <= a + b + c;
      `ALU_SUB : // carry set to lt
        {cout, out} <= a - b - c;
      `ALU_XOR : // carry set to inequality
        {cout, out} <= {c & (a != b), a ^ b};
      `ALU_XNOR : // carry set to equality
        {cout, out} <= {c & ( a == b), ~(a ^ b)};
      `ALU_AND : // carry set to all bits are 1
        {cout, out} <= {c & ((a & b) ==-1), a & b};
      `ALU_RV1 : // reserved
        {cout, out} <= {c & ( a > b ), a & ~b};
    endcase
  end
endmodule

module alu
  #(parameter WIDTH = 4)
   (input wire [WIDTH-1:0] a, b,
    output [WIDTH-1:0] out,
    input wire [2:0] s,
    output cout
   );
  wire [WIDTH:0] c;
  assign c[0] = s[2];
  genvar i;
  generate
    for (i = 0; i < WIDTH; i=i+1)
    begin
      serialalu sa(a[i], b[i], c[i], s, out[i], c[i+1]);
    end
  endgenerate
  assign cout = c[WIDTH];

endmodule
