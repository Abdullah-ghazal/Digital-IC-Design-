module DigCt(IN1,IN2,IN3,IN4,IN5,CLK,OUT1,OUT2,OUT3);
  input IN1;
  input IN2;
  input IN3;
  input IN4;
  input IN5;
  input CLK;
  output OUT1;
  output OUT2;
  output OUT3;
  
  
  reg D1,D2,D3;
  reg OUT1,OUT2,OUT3;
  reg c1, c2;
  
  always @(IN1,IN2)
  begin
    c1 = ~(IN1 | IN2);
  end
  
  always @(IN3,IN4)
  begin
    c2 =  IN3 | ~IN4;
  end
  
  always @(c1,IN3)
  begin
    D1 = ~(c1 & IN3);
  end
  
  always @(IN2,IN3)
  begin
    D2 = ~(IN2 & IN3);
  end
  
  always @(c2, IN5)
  begin
    D3 = c2 | IN5;
  end
  
  always @(posedge CLK)
  begin
    OUT1 <= D1;
  end
  
  always @(posedge CLK)
  begin
    OUT2 <= D2;
  end
  
  always @(posedge CLK)
  begin
    OUT3 <= D3;
  end
  
endmodule

