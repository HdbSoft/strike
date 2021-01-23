//-----------------------------------
// The strike project, open source
// 4-bit processor written in
// Verilog and Cython
//
// strike.v - Main file
//-----------------------------------

`default_nettype none
`include "ALU.vh"


module strike_CPU(
	input wire clock,
	input wire reset,
	output wire [3:0] leds,
	output wire stop
);

parameter ROM_FILE = "boot.o";

localparam AW = 6;     //-- Directions bus width
localparam DW = 8;     //-- Data bus width

//-- Strike instructions set
`include "ISA.vh"


endmodule