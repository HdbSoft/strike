//-----------------------------------
// The strike project, open source
// 6-bit processor written in
// Verilog and Cython
//
// strike.v - Main file
//-----------------------------------

`default_nettype none
`include "ALU.vh"


module strike_CPU(
	input wire clock,
	input wire reset_ini,
	output wire [3:0] leds,
	output wire stop
);

parameter ROM_FILE = "boot.o";

localparam AW = 6;     //-- Directions bus width
localparam DW = 8;     //-- Data bus width

//-- Strike instructions set
`include "ISA.vh"

wire [DW-1: 0] data;
wire [AW-1: 0] addr;
genrom
  #( .ROMFILE(ROM_FILE),
     .AW(AW),
     .DW(DW))
  ROM (
        .clk(clock),
        .addr(addr),
        .data(data)
      );

reg rstn = 0;

always @(posedge clk)
  rstn <= rstn_ini;

reg PC_inc = 0;
reg PC_load = 0;
reg IR_load = 0;
reg halt = 0;
reg leds_load = 0;

reg [AW-1: 0] PC; //-- Program counter

always @(posedge clk)
  if (!rstn)
    PC <= 0;
  else if (PC_load)
    PC <= DAT;
  else if (PC_inc)
    PC <= PC + 1;

assign addr = cp;
reg [DW-1: 0] IR;

wire [1:0] CO = IR[7:6];
wire [5:0] DAT = IR[5:0];

always @(posedge clk)
  if (!rstn)
    IR <= 0;
  else if (IR_load)
    IR <= data;

//-- 1 when HALT is executed
reg reg_stop;

always @(posedge clk)
  if (!rstn)
    reg_stop <= 0;
  else if (halt)
    reg_stop <= 1;

//-- LEDs register
reg [3:0] leds_r;

always @(posedge clk)
  if (!rstn)
    leds_r <= 0;
  else if (leds_load)
    leds_r <= DAT[3:0];


assign leds = leds_r;
assign stop = reg_stop;


endmodule