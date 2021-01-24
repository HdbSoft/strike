//-----------------------------------
// The strike project, open source
// 6-bit processor written in
// Verilog and Cython
//
// CU.vh - Control unit
//-----------------------------------

localparam INIT = 0;
localparam FETCH = 1;
localparam EXEC = 2;

reg [1:0] state;
reg [1:0] next_state;

wire clk_tic;
always @(posedge clk)
  if (!rstn)
    state <= INIT;
  else
    state <= next_state;

always @(*) begin
    next_state = state;

    PC_inc = 0;
    PC_load = 0;
    IR_load = 0;
    halt = 0;
    leds_load = 0;

    case (state)
        INIT:
            next_state = FETCH;

        FETCH: begin
            PC_inc = 1;
            IR_load = 1;
            next_state = EXEC;            
        end

        EXEC: begin
            next_state = FETCH;
            // TODO: execute instruction
        end
    endcase
end