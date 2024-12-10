module ARITHMETIC_UNIT 
#(parameter WIDTH = 16) 
(
input wire signed [WIDTH - 1 : 0]A,
input wire signed [WIDTH - 1 : 0]B,
input wire [1:0]ALU_FUN,
input wire CLK,
input wire RST,
input wire Arith_Enable,

output reg signed [2*WIDTH - 1 : 0]Arith_OUT,
output reg Carry_OUT,
output reg Arith_flag
);

reg signed [2*WIDTH - 1 : 0] Arith_OUT_comb;
reg Arith_flag_comb;
reg Carry_OUT_comb;


always @(posedge CLK or negedge RST)
begin
  if(!RST)
    begin 
      Arith_OUT <= 'b0;
      Arith_flag <= 1'b0;
      Carry_OUT <= 1'b0;
    end
  else
    begin
      Arith_OUT <= Arith_OUT_comb;
      Arith_flag <= Arith_flag_comb;
      Carry_OUT <= Carry_OUT_comb;
    end
end

always @(*)
begin
  Arith_flag_comb = 1'b0;
  Arith_OUT_comb = 'b0;
  Carry_OUT_comb = 1'b0;
  if(Arith_Enable)
    begin
      case(ALU_FUN)
        2'b00: begin
                {Carry_OUT_comb,Arith_OUT_comb} = A + B;
                Arith_flag_comb = 1'b1;
              end
        2'b01: begin
                {Carry_OUT_comb,Arith_OUT_comb} = A - B;
                Arith_flag_comb = 1'b1;
              end
        2'b10: begin
                {Carry_OUT_comb,Arith_OUT_comb} = A * B;
                Arith_flag_comb = 1'b1;
              end
        2'b11: begin
                {Carry_OUT_comb,Arith_OUT_comb} = A / B;
                Arith_flag_comb = 1'b1;
              end                  
        default: begin
                Arith_flag_comb = 1'b0;
                Arith_OUT_comb = 'b0;
                Carry_OUT_comb = 1'b0;
               end  
          endcase      
    end
    else
      begin
        Arith_flag_comb = 1'b0;
        Arith_OUT_comb = 'b0;
        Carry_OUT_comb = 1'b0;
        end
end
endmodule


