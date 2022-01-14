module decoder #(
    parameter size = 8
  ) (
    input [$clog2(size)-1:0] addr,
    output [size-1:0 ] out
  );
  assign out = 1<<addr;
endmodule

module mux #(parameter size = 8)
  (
    input [size-1:0] in,
    input [$clog2(size)-1:0] addr,
    output out
  );

endmodule
