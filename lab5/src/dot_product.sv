`default_nettype none

// Implement a vector dot product of a and b
// using a single-port SRAM of 5-bit address width, 16-bit data width

module dot_product #(
  localparam int ADDR_WIDTH = 5,
  localparam int WIDTH      = 32
) (
  input  logic                 clk,
  input  logic                 rst,

  input  logic [ADDR_WIDTH:0]  len,

  // input vector a
  input  logic [WIDTH-1:0]     a_data,
  input  logic                 a_valid,
  output logic                 a_ready,

  // input vector b
  input  logic [WIDTH-1:0]     b_data,
  input  logic                 b_valid,
  output logic                 b_ready,

  // dot product result c
  output logic [WIDTH-1:0]     c_data,
  output logic                 c_valid,
  input  logic                 c_ready
);

  typedef enum logic [2:0] {
    S_LOAD        = 3'd0,
    S_SET_A_ADDR  = 3'd1,
    S_GET_A       = 3'd2,
    S_SET_B_ADDR  = 3'd3,
    S_GET_B       = 3'd4,
    S_DONE        = 3'd5
  } state_t;

  // Handshakes
  logic a_fire, b_fire, c_fire;
  assign a_fire = a_valid && a_ready;
  assign b_fire = b_valid && b_ready;
  assign c_fire = c_valid && c_ready;

  // SRAM interface
  logic                 ce;
  logic                 rstb;
  logic                 we;
  logic [3:0]           wmask;
  logic [ADDR_WIDTH:0]  addr;
  logic [WIDTH-1:0]     din;
  logic [WIDTH-1:0]     dout;

  assign ce    = 1'b1;
  assign rstb  = ~rst;
  assign wmask = 4'b1111;

  sram22_64x32m4w8 sram (
    .clk  (clk),
    .rstb (rstb),
    .ce   (ce),
    .we   (we),
    .wmask(wmask),
    .addr (addr),
    .din  (din),
    .dout (dout)
  );

  // TODO: fill in the rest of this module.

endmodule
