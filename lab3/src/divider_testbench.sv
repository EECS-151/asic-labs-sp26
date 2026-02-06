`default_nettype none

`timescale 1 ns / 100 ps

module divider_testbench;

  localparam int WIDTH = 4;

  logic clk = 0;
  always #(`CLOCK_PERIOD/2) clk = ~clk;

  logic start;
  logic [WIDTH-1:0] dividend, divisor;
  logic [WIDTH-1:0] quotient, remainder;
  logic done;

  divider #(.WIDTH(WIDTH)) div_dut (
    .clk(clk),
    .start(start),
    .done(done),
    .dividend(dividend),
    .divisor(divisor),
    .quotient(quotient),
    .remainder(remainder)
  );

  always_ff @(posedge clk) begin
    $display("At time %d: start %d, done %d, dividend %d, divisor %d, quotient %d, remainder %d",
      $time, start, done, dividend, divisor, quotient, remainder);
  end

  // TODO: Add more tests
  initial begin
    #0;
    start    = 0;
    dividend = 0;
    divisor  = 1;

    repeat (10) @(posedge clk);
    start    = 1;
    dividend = 7;
    divisor  = 2;

    @(posedge clk) start = 0; // 'start' is HIGH for one cycle
    @(posedge clk);

    // wait until 'done' is asserted
    while (done == 0) begin
      @(posedge clk);
    end

    $finish();
  end

endmodule
