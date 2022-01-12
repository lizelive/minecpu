// parameter WORD = 4;
// parameter DEPTH = 2;

module alu
  (
    input a, b, c,
    input [3-1:0] s,
    output out, cout
  );
  wire [1:0] r;
  
  assign out = r[0];
  assign cout = r[1];

  always @(a, b, c, s)
  begin
    case (s)
      0 :
      begin
        r <= {c & a != b, a != b};
      end
      // 1 :
      //   out <= a | b;
      // 2 :
      //   out <= a & b;
      // 3 :
      // begin
      //   out <= a > b;
      //   cout <= c & a > b;
      // end
      // 4 :
      //   {out, cout} <= a + b + c;
      // 5 :
      //   out <= a - b - c;

      // 6 :
      // begin
      //   out <= b;
      //   cout <= c | b;
      // end

      // 7 :
      // begin
      //   out <= a == b;

      // end
    endcase
  end
endmodule

