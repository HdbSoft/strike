//-----------------------------------
// The strike project, open source
// 4-bit processor written in
// Verilog and Cython
//
// ALU.vh - Arithmetic-logic unit
//-----------------------------------

module strike_ALU(
    input [7:0] A,B,
    input [3:0] selection,
    output [7:0] ALU_output,
    output CarryOut
);

reg  [7:0] ALU_result
wire [8:0] tmp;

assign ALU_output = ALU_result;
assign tmp = {1'b0,A} + {1'b0,B};
assign CarryOut = tmp[8];

always @(*) begin
    case(selection)
    4'b0000: // ADD => 0000
        ALU_result = A + B;
    4'b0001: // SUB => 0001
        ALU_result = A - B;
    4'b0010: // MUL => 0010
        ALU_result = A * B;
    4'b0011: // DIV => 0011
        ALU_result = A / B;
    4'b0100: // LSHIFT => 0100
        ALU_result = A << B;
    4'b0101: // RSHIFT => 0101
        ALU_result = A >> B;
    4'b0110: // ROTL => 0110
        ALU_result = {A[6:0],A[7]};
    4'b0111: // ROTR => 0111
        ALU_result = {A[0],A[7:1]};
    4'b1000: // AND => 1000
        ALU_result = A & B
    4'b1001: // OR => 1001
        ALU_result = A | B
    4'b1010: // XOR => 1010
        ALU_result = A ^ B
    4'b1011: // NAND => 1011
        ALU_result = ~(A & B)
    4'b1100: // NOR => 1100
        ALU_result = ~(A | B)
    4'b1101: // XNOR => 1101
        ALU_result = ~(A ^ B)
    4'b1110: // GRT => 1110
        ALU_result = (A > B) ? 8'd1 : 8'd0
    4'b1111: // EQ => 1111
        ALU_result = (A == B) ? 8'd1 : 8'd0
end