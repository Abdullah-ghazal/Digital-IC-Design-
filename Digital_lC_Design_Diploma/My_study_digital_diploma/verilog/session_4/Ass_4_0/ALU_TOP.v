module ALU_TOP 
#(parameter WIDTH = 16) 
(
  input wire [WIDTH - 1 : 0]A, B,
  input wire [3 : 0]ALU_FUN,
  input wire CLK, RST,
  
  output wire [2*WIDTH - 1 : 0]Arith_OUT,
  output wire Carry_OUT,
  output wire Arith_Flag,
  output wire [WIDTH - 1 : 0]Logic_OUT,
  output wire Logic_Flag,
  output wire [1:0]CMP_OUT,
  output wire CMP_Flag,
  output wire [WIDTH - 1 : 0]SHIFT_OUT,
  output wire SHIFT_Flag
);

wire Arth_enable, Logic_enable, CMP_enable, shft_enable;
Decoder_Unit decoder (
  .ALU_FUN(ALU_FUN[3:2]),
  .Arith_Enable(Arth_enable),
  .Logic_Enable(Logic_enable),
  .CMP_Enable(CMP_enable),
  .Shift_Enable(shft_enable)
  );
  
ARITHMETIC_UNIT #(.WIDTH(WIDTH)) arth_unit (
        .A(A),
        .B(B),
        .ALU_FUN(ALU_FUN[1:0]),
        .CLK(CLK),
        .RST(RST),
        .Arith_Enable(Arth_enable),
        .Arith_OUT(Arith_OUT),
        .Carry_OUT(Carry_OUT),
        .Arith_flag(Arith_Flag)
);
  
  
 LOGIC_UNIT #(.WIDTH(WIDTH)) logic_unit (
  .A(A), 
  .B(B),
  .ALU_FUN(ALU_FUN[1:0]),
  .CLK(CLK),
  .RST(RST),
  .Logic_Enable(Logic_enable),
  .Logic_OUT(Logic_OUT),
  .Logic_Flag(Logic_Flag)
);  

  CMP_UNIT #(.WIDTH(WIDTH)) cmp_unit(
  .A(A),
  .B(B),
  .ALU_FUN(ALU_FUN[1 : 0]),
  .CLK(CLK), 
  .RST(RST),
  .CMP_Enable(CMP_enable),
  .CMP_OUT(CMP_OUT),
  .CMP_Flag(CMP_Flag)
);

SHIFT_UNIT #(.WIDTH(WIDTH)) shft_unit (
  .A(A), 
  .B(B),
  .ALU_FUN(ALU_FUN[1:0]),
  .CLK(CLK),
  .RST(RST),
  .Shift_Enable(shft_enable),
  .SHIFT_OUT(SHIFT_OUT),
  .SHIFT_Flag(SHIFT_Flag)
);

endmodule
