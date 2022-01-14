
`timescale 50ms/50ms

// parameter WIDTH = 4;
// parameter DEPTH = 2;
//`include "define.v"
`define WIDTH   12

`define ALU_ADD 2'b00
`define ALU_SUB 2'b01
`define ALU_MAX 2'b10
`define ALU_DIF 2'b11



`define REDSTONE [3:0]

module comparator_sub (
  input `REDSTONE back, lside, rside,
  output `REDSTONE front
);
  wire `REDSTONE side;
  max max_sides(lside, rside, side);
  wire `REDSTONE side_db;
  wire `REDSTONE back_db;
  
  debounce db_back(back, back_db);
  debounce db_side(side, side_db);

  assign front = back_db - side_db;
endmodule

module max (input `REDSTONE a, 
            input `REDSTONE b, 
            output `REDSTONE out);
  assign out = (a>b)? a : b;
endmodule

module min (input `REDSTONE a, 
            input `REDSTONE b, 
            output `REDSTONE out);
  assign out = (a<b)? a : b;
endmodule

module debounce ( input `REDSTONE in, output `REDSTONE out
);
  reg `REDSTONE old;
  set_dont_touch old
  buf #2 delay(old, in);
  min m(in, old, out); 
endmodule



// module full_oct_adder (
//     input clk,
//     input [2:0] a, b,
// );
    
// endmodule

// module serialalu
//   (
//     input wire reset,
//     input wire [2:0] a, b,
//     input wire [2:0] s,
//     output reg out, carry
//   );


//   always @(reset, a, b, s)
//   begin
//       if (reset) begin
//           carry = 0;
//       end
//     case (s)
//       `ALU_ADD : // nop
//         begin
            
//         end
//         {cout, out} <= {c, a};
      
//     endcase
//   end
// endmodule

// module alu
//   #(parameter WIDTH = 4)
//    (input wire [WIDTH-1:0] a, b,
//     output [WIDTH-1:0] out,
//     input wire [2:0] s,
//     output cout
//    );
//   wire [WIDTH:0] c;
//   assign c[0] = s[2];
//   genvar i;
//   generate
//     for (i = 0; i < WIDTH; i=i+3)
//     begin
//       serialalu sa(a[i+WIDTH-1:i], b[i+WIDTH-1:i], out[i+WIDTH-1:i], c[i+WIDTH-1:i], s);
//     end
//   endgenerate
//   assign cout = c[WIDTH];

// endmodule

// module fancy_torch (
//     input clk, in,
//     output out
//   );
//   reg [59:0] changes = 0;
  
//   reg [5:0] numchanges = 0;


//   // shouldent be a reg
//   wire oldest_change;
//   wire[59:0] new_changes;
//   wire burnout;
//   wire changed;
//   reg old_in = 0;
  
//   assign changed = old_in != in;
//   assign {oldest_change, new_changes} = {changes, changed};
//   assign burnout = numchanges >= 8;
//   assign out = ~old_in & ~burnout;

//   always @(posedge clk )
//   begin
//     changes <= new_changes;
//     numchanges <= numchanges - oldest_change + changed;
//     old_in <= in;
//     //out <= ~in & ~burnout;
//   end
// endmodule


module torch (
    input in,
    output out
  );
  assign #1 out = in != 0;
endmodule

module repeater #(
  parameter delay = 4
) (
  input in, latch,
  output out
);
  logic state = latch? state: in; 
  buf #(1,delay,delay) b(out, state);
  
endmodule

module torch_tb(input clk, input in, output out, o2);
  wire state;
  
  torch t1(.clk(clk),.in(in), .out(state));
  repeater #(2) r1  (state, o2);
  torch t2(.clk(clk),.in(state), .out(out));
endmodule
