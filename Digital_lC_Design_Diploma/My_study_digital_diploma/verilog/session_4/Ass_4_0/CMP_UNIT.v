module CMP_UNIT
#(parameter WIDTH = 16)
(
  input wire signed [WIDTH - 1 : 0] A, B,
  input wire [1:0] ALU_FUN,
  input wire CLK, RST,
  input wire CMP_Enable,
  output reg [1:0]CMP_OUT,
  output reg CMP_Flag
);

reg [1:0]CMP_OUT_comb;
reg CMP_Flag_comb;

always @(posedge CLK or negedge RST)
  begin
    if(!RST)
      begin
        CMP_OUT <= 1'b0;
        CMP_Flag <= 1'b0;
      end
    else
      begin
        CMP_OUT <= CMP_OUT_comb;
        CMP_Flag <= CMP_Flag_comb;
      end
  end
  
  always @(*)
    begin
      CMP_OUT_comb = 1'b0;
      CMP_Flag_comb = 1'b0;
      if (CMP_Enable)
        begin
          case(ALU_FUN)
            2'b00:
                begin
                  CMP_OUT_comb = 1'b0;
                  CMP_Flag_comb = 1'b1;            
                end
            2'b01:
                begin
                  CMP_OUT_comb = (A == B)? 1: 0 ;
                  CMP_Flag_comb = 1'b1;
                end
            2'b10:
                begin
                  CMP_OUT_comb = (A > B)? 2: 0 ;
                  CMP_Flag_comb = 1'b1;
                end
            2'b11:
                begin
                  CMP_OUT_comb = (A < B)? 3 : 0 ;
                  CMP_Flag_comb = 1'b1;                  
                end
            default: 
                begin
                  CMP_OUT_comb = 1'b0;
                  CMP_Flag_comb = 1'b0;                    
                end                              
          endcase
        end
      else
        begin
          CMP_OUT_comb = 1'b0;
          CMP_Flag_comb = 1'b0;
        end
    end
  endmodule
