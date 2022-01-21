module torch ( input in, output out);
  assign #1 out = in != 0
endmodule

module repeater #(
  parameter delay = 1
) (
  input in, latch,
  output out
);
    state = latch ? state: in; 
    buf #(1,delay,delay) delay_buf(out, state);
endmodule