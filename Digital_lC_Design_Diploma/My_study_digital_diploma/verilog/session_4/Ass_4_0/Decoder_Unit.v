module Decoder_Unit (
  input wire [1:0]ALU_FUN,
  output reg Arith_Enable,
  output reg Logic_Enable,
  output reg CMP_Enable,
  output reg Shift_Enable
  );
  
  always @(*)
    begin
      case(ALU_FUN)
        2'b00: {Arith_Enable, Logic_Enable, CMP_Enable, Shift_Enable} = 4'b1000;
        2'b01: {Arith_Enable, Logic_Enable, CMP_Enable, Shift_Enable} = 4'b0100;
        2'b10: {Arith_Enable, Logic_Enable, CMP_Enable, Shift_Enable} = 4'b0010;
        2'b11: {Arith_Enable, Logic_Enable, CMP_Enable, Shift_Enable} = 4'b0001;
        default: {Arith_Enable, Logic_Enable, CMP_Enable, Shift_Enable} = 4'b0000;
      endcase
    end
    
  endmodule
    
  
  
  
