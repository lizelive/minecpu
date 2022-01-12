
module stack(
    input [WORD-1:0] din,
    output [WORD-1:0] peak,
    input push, pop);

  reg [WORD-1:0]stack[DEPTH-1:0];
  integer i;
  always @ (posedge push)
  begin
    for (i=0; i<DEPTH-1; i=i+1)
    begin
      stack[i+1] = stack[i];
    end
    stack[0] = din;
  end

  always @ (posedge pop)
  begin
    for (i=0; i<DEPTH-1; i=i+1)
    begin
      stack[i] = stack[i+1];
    end
    stack[DEPTH-1] = 0;
  end

  assign peak = stack[0];

endmodule
