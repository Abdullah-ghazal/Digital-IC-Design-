module LOGIC_UNIT
  #(parameter WIDTH = 16) 
  (
  input wire signed [WIDTH - 1 : 0] A, B,
  input wire [1:0] ALU_FUN,
  input CLK,
  input RST,
  input Logic_Enable,
  output reg signed [WIDTH - 1 : 0] Logic_OUT,
  output reg  Logic_Flag
  );

reg signed [WIDTH - 1 : 0] Logic_OUT_comb;
reg Logic_Flag_comb;

always @(posedge CLK or negedge RST)
begin
  if (!RST)
    begin
      Logic_OUT <= 'b0;
      Logic_Flag <= 1'b0;
    end
  else
    begin
      Logic_OUT <= Logic_OUT_comb;
      Logic_Flag <= Logic_Flag_comb;
    end
end

always @(*)
begin
  
  Logic_Flag_comb = 1'b0;
  Logic_OUT_comb = 'b0;
  
  if(Logic_Enable)
    begin
      case(ALU_FUN)
        2'b00: 
            begin
                Logic_OUT_comb = A & B;
                Logic_Flag_comb = 1'b1;          
            end
        2'b01: 
            begin
                Logic_OUT_comb = A | B;
                Logic_Flag_comb = 1'b1; 
          
            end
        2'b10: 
            begin
                Logic_OUT_comb = ~(A & B);
                Logic_Flag_comb = 1'b1; 
          
            end
        2'b11: 
            begin
                Logic_OUT_comb = ~(A | B);
                Logic_Flag_comb = 1'b1;           
            end      
        default: 
                begin
                  Logic_Flag_comb = 1'b0;
                  Logic_OUT_comb = 'b0;
                end
      endcase
      
    end
    else
        begin
            Logic_Flag_comb = 1'b0;
            Logic_OUT_comb = 'b0;
        end
end

endmodule