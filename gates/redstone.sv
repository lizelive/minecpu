
`timescale 50ms/50ms

// parameter WIDTH = 4;
// parameter DEPTH = 2;
//`include "define.v"
typedef bit [3:0] redstone;


module repeater #(
  parameter delay = 1
) (
  input redstone in,
  input latch,
  output redstone out
);
  byte time_sense_on = 0;

  buf #(1,delay,delay) b(out, state);

  initial begin
    time_sense_on = in? 0 : delay;
    should_output = in;
  end
  
  assign out = should_output ? -1: 0;

  reg should_output;

  always @($global_clock) begin
    should_output = time_sense_on < delay
    if (in != 0)
      time_sense_on = 0;
    else if (should_output)
      time_sense_on = time_sense_on + 1;
    
  end
endmodule

module torch (
    input redstone in,
    output redstone out
  );

  reg old_in = 0;
  reg [59:0] changes = 0;
  reg byte numchanges = 0;

  wire not_in = in == 0;

  always @($global_clock)
  begin
    out = old_in & (numchanges < 8) ? -1 : 0;
    changed = old_in != not_in;
    {oldest_change, changes} = {changes, changed};
    numchanges = numchanges - oldest_change + changed;
    old_in = not_in;
  end
endmodule


/*

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

*/

module redstone_tb(input clk, input in, output out, o2);
  wire state;
  
  torch t1(.clk(clk),.in(in), .out(state));
  repeater #(2) r1  (state, o2);
  torch t2(.clk(clk),.in(state), .out(out));
endmodule
