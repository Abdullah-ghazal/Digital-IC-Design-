module SHIFT_UNIT 
#(parameter WIDTH = 16)
(
  input wire signed [WIDTH - 1 : 0] A, B,
  input wire [1:0] ALU_FUN,
  input CLK,
  input RST,
  input Shift_Enable,
  output reg signed [WIDTH - 1 : 0] SHIFT_OUT,
  output reg  SHIFT_Flag
);

reg signed [WIDTH - 1 : 0] SHIFT_OUT_comb;
reg SHIFT_Flag_comb;

always @(posedge CLK or negedge RST)
begin
  if (!RST)
    begin
      SHIFT_OUT <= 'b0;
      SHIFT_Flag <= 1'b0;
    end
  else
    begin
      SHIFT_OUT <= SHIFT_OUT_comb;
      SHIFT_Flag <= SHIFT_Flag_comb;
    end
end

always @(*)
begin
      SHIFT_OUT_comb = 'b0;
      SHIFT_Flag_comb = 1'b0;
  if(Shift_Enable)
    begin
      case(ALU_FUN)      
        2'b00:
             begin
                SHIFT_OUT_comb = A >> 1;
                SHIFT_Flag_comb = 1'b1;
             end
        2'b01:
             begin
                SHIFT_OUT_comb = A << 1;
                SHIFT_Flag_comb = 1'b1;            
             end
        2'b10:
             begin
                SHIFT_OUT_comb = B >> 1;
                SHIFT_Flag_comb = 1'b1;             
             end                    
        2'b11:
              begin
                SHIFT_OUT_comb = B << 1;
                SHIFT_Flag_comb = 1'b1;
              end   
        default:
              begin
                SHIFT_OUT_comb = 'b0;
                SHIFT_Flag_comb = 1'b0;
              end        
      endcase
    end
else
  begin
          SHIFT_OUT_comb = 'b0;
          SHIFT_Flag_comb = 1'b0;
  end

end


endmodule
