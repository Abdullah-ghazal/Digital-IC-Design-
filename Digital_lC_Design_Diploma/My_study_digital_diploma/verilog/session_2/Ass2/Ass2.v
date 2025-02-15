module Ass2(
  input [4:0] IN,
  input Load,
  input wire Up,
  input wire Down,
  input wire CLK,
  output reg High,
  output reg [4:0] Counter,
  output reg Low  
);

reg [4:0] Counter_reg;

always @(posedge CLK)
begin
  Counter <= Counter_reg;
end

always @(*)
begin
  if(Load)
    Counter_reg = IN;
  else if (Down && Counter != 5'd0)
    Counter_reg = Counter - 1 ;
  else if(Up && !Down && Counter != 5'd31) //corner case !!
    Counter_reg = Counter + 1 ;
  else
    Counter_reg = Counter;    
end

always @(*) //optimized synthises
begin
  if (Counter == 5'd0)
    begin
      High = 1'b0;
      Low = 1'b1;
    end
  else if(Counter == 5'd31)
    begin
      High = 1'b1;
      Low = 1'b0;  
    end
  else
    begin
      High = 1'b0;
      Low = 1'b0;      
    end
end

endmodule