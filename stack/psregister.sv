module serial_register #(
    parameter SIZE = 4
  ) (
    output dout,
    input clk, din, read, write
  );

  reg [SIZE-1: 0] data;
  reg [SIZE-1: 0] reading;

  always @(posedge clk )
  begin
    if (write)
    begin
      data <= { din, data[SIZE-2: 0]};
    end
    reading <= read | reading << 1;
  end

  always dout <= (reading & data) != 0;


endmodule

module test #(
    parameter SIZE = 4
  )();
  reg read, write
endmodule
