`default_nettype none

module divider #(
  parameter int WIDTH = 4
) (
  input  logic               clk,
  input  logic               start,
  output logic               done,
  input  logic [WIDTH-1:0]   dividend,
  input  logic [WIDTH-1:0]   divisor,
  output logic [WIDTH-1:0]   quotient,
  output logic [WIDTH-1:0]   remainder
);

  // Feel free to change the code as long as your final code implements a divider
  // Check the algorithm described in the slides (URL in the spec)
  // Pay attention to the block diagram(s)

  assign quotient  = '0;
  assign remainder = '0;
  assign done      = 1'b0;

endmodule
