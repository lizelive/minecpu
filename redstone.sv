
`timescale 50ms/50ms

// parameter WIDTH = 4;
// parameter DEPTH = 2;
//`include "define.v"
typedef bit [3:0] redstone;


module comparator_sub (
  input clk,
  input redstone back, lside, rside,
  output redstone front
);
  wire redstone side;
  max max_sides(lside, rside, side);
  wire redstone side_db;
  wire redstone back_db;
  
  debounce db_back(back, back_db);
  debounce db_side(side, side_db);

  assign front = back_db - side_db;
endmodule

module max (input redstone a, 
            input redstone b, 
            output redstone out);
  assign out = (a>b)? a : b;
endmodule

module min (input redstone a, 
            input redstone b, 
            output redstone out);
  assign out = (a<b)? a : b;
endmodule

module debounce ( input redstone in, output redstone out
);
  reg redstone old;
  set_dont_touch old
  buf #2 delay(old, in);
  min m(in, old, out); 
endmodule

module torch (
    input clk, in,
    output out
  );
  reg [59:0] changes = 0;
  
  reg [5:0] numchanges = 0;


  // shouldent be a reg
  wire oldest_change;
  wire[59:0] new_changes;
  wire burnout;
  wire changed;
  reg old_in = 0;
  
  assign changed = old_in != in;
  assign {oldest_change, new_changes} = {changes, changed};
  assign burnout = numchanges >= 8;
  assign out = ~old_in & ~burnout;

  always @(posedge clk )
  begin
    changes <= new_changes;
    numchanges <= numchanges - oldest_change + changed;
    old_in <= in;
    //out <= ~in & ~burnout;
  end
endmodule


module repeater #(
  parameter delay = 4
) (
  input in, latch,
  output out
);
  redstone state = latch? state: in; 
  buf #(1,delay,delay) b(out, state);
  
endmodule

module torch_tb(input clk, input in, output out, o2);
  wire state;
  
  torch t1(.clk(clk),.in(in), .out(state));
  repeater #(2) r1  (state, o2);
  torch t2(.clk(clk),.in(state), .out(out));
endmodule
