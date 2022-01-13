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


module torch_tb(input clk, input in, output out);
  wire state;
  torch t1(.clk(clk),.in(in), .out(state));
  torch t2(.clk(clk),.in(state), .out(out));
endmodule
