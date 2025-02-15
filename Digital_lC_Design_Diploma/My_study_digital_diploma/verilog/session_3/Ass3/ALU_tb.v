module ALU_tb();
  
  reg [15:0]A_tb;
  reg [15:0]B_tb;
  reg [3:0]ALU_FUN_tb;
  reg CLK_tb;
  wire [15:0] ALU_OUT_tb;
  wire Arith_Flag_tb;
  wire Logic_Flag_tb;
  wire CMP_Flag_tb;
  wire Shift_Flag_tb;
  
  wire [3:0]flags;
  assign flags = {Arith_Flag_tb,Logic_Flag_tb,CMP_Flag_tb,Shift_Flag_tb};
  
  //instance
  ALU uut (
      .A(A_tb),
      .B(B_tb),
      .ALU_FUN(ALU_FUN_tb),
      .CLK(CLK_tb),
      .ALU_OUT(ALU_OUT_tb),
      .Arith_Flag(Arith_Flag_tb),
      .Logic_Flag(Logic_Flag_tb),
      .CMP_Flag(CMP_Flag_tb),
      .Shift_Flag(Shift_Flag_tb)
      );
      
      
  // generate clk
  parameter T = 10;
  
  always  #(T/2) CLK_tb = ~CLK_tb;
  
  initial 
  begin
    $dumpfile("ALU.vcd");
    $dumpvars;
    //initial valus
    A_tb = 16'b0;
    B_tb = 16'b0;
    ALU_FUN_tb = 4'b0;
    CLK_tb = 1'b0;
    
    $display("******** TEST CASE 1 ************\n");
    A_tb = 16'd10;
    B_tb = 16'd10;
    ALU_FUN_tb = 4'b0000;
    
    #T
    
    if(ALU_OUT_tb == 16'd20 && flags == 4'b1000)
        $display(" + IS PASSED");
    else
        $display(" + IS FILLED");
        
    $display("******** TEST CASE 2 ************\n");
    A_tb = 16'd20;
    B_tb = 16'd10;
    ALU_FUN_tb = 4'b0001;
    
    #T
    
    if(ALU_OUT_tb == 16'd10 && flags == 4'b1000)
        $display(" - IS PASSED");
    else
        $display(" - IS FILLED");
    
    $display("******** TEST CASE 3 ************\n");
    A_tb = 16'd10;
    B_tb = 16'd10;
    ALU_FUN_tb = 4'b0010;
    
    #T
    
    if(ALU_OUT_tb == 16'd100 && flags == 4'b1000)
        $display(" * IS PASSED");
    else
        $display(" * IS FILLED");
    
    $display("******** TEST CASE 4 ************\n");
    A_tb = 16'd100;
    B_tb = 16'd5;
    ALU_FUN_tb = 4'b0011;
    
    #T
    
    if(ALU_OUT_tb == 16'd20 && flags == 4'b1000)
        $display(" / IS PASSED");
    else
        $display(" / IS FILLED");
    
    $display("******** TEST CASE 5 ************\n");
    A_tb = 16'd18;
    B_tb = 16'd10;
    ALU_FUN_tb = 4'b0100;
    
    #T
    
    if(ALU_OUT_tb == (18 & 10) && flags == 4'b0100)
        $display(" & IS PASSED");
    else
        $display(" & IS FILLED");
        
      $display("******** TEST CASE 6 ************\n");
    A_tb = 16'd23;
    B_tb = 16'd14;
    ALU_FUN_tb = 4'b0101;
    
    #T
    
    if(ALU_OUT_tb == (23 | 14) && flags == 4'b0100)
        $display(" | IS PASSED");
    else
        $display(" | IS FILLED");
        
      $display("******** TEST CASE 7 ************\n");
    A_tb = 16'b1001;
    B_tb = 16'b0011;
    ALU_FUN_tb = 4'b0110; 
    
    #T
    
    if (ALU_OUT_tb == 16'hfffe && flags == 4'b0100)
        $display(" ~& IS PASSED");
    else
        $display(" ~& IS FILLED");
        
      $display("******** TEST CASE 8 ************\n");
    A_tb = 16'b1001;
    B_tb = 16'b0011;
    ALU_FUN_tb = 4'b0111;  
    
    #T
    
    if (ALU_OUT_tb == 16'hfff4 && flags == 4'd4) 
        $display(" ~| IS PASSED");
    else
        $display(" ~| IS FILLED");
        
      $display("******** TEST CASE 9 ************\n");
    A_tb = 16'd73;
    B_tb = 16'd23;
    ALU_FUN_tb = 4'b1000;
    
    #T
    
    if(ALU_OUT_tb == (73 ^ 23) && flags == 4'b0100)
        $display(" ^ IS PASSED");
    else
        $display(" ^ IS FILLED");
    
    $display("******** TEST CASE 10 ************\n");
   A_tb = 16'b1001;
   B_tb = 16'b0011;
   ALU_FUN_tb = 4'b1001; 
    
    #T
    
    if (ALU_OUT_tb == 16'hfff5 && flags == 4'd4) 
        $display(" ~^ IS PASSED");
    else
        $display(" ~^ IS FILLED");
  
    $display("******** TEST CASE 11 ************\n");
    A_tb = 16'd20;
    B_tb = 16'd20;
    ALU_FUN_tb = 4'b1010;
    
    #T
    
    if(ALU_OUT_tb == 1 && flags == 4'b0010)
        $display(" =  IS PASSED ");
    else
        $display(" =  IS FAILED ");
        
    $display("******** TEST CASE 12 ************\n");
    A_tb = 16'd40;
    B_tb = 16'd20;
    ALU_FUN_tb = 4'b1011;
    
    #T
    
    if(ALU_OUT_tb == 2 && flags == 4'b0010)
        $display(" A > B  IS PASSED ");
    else
        $display(" A > B  IS FAILED ");
        
    $display("******** TEST CASE 13 ************\n");
    A_tb = 16'd40;
    B_tb = 16'd20;
    ALU_FUN_tb = 4'b1100;
    
    #T
    
    if(ALU_OUT_tb == 0 && flags == 4'b0010)
        $display(" A < B IS PASSED ");
    else
        $display(" A < B IS FAILED ");
        
    $display("******** TEST CASE 14 ************\n");
    A_tb = 16'd20;
    B_tb = 16'd20;
    ALU_FUN_tb = 4'b1101;
    
    #T
    
    if(ALU_OUT_tb == (A_tb >>1) && flags == 4'b0001)
        $display(" >>  IS PASSED ");
    else
        $display(" >> IS FAILED ");
        
    $display("******** TEST CASE 15 ************\n");
    A_tb = 16'd20;
    B_tb = 16'd20;
    ALU_FUN_tb = 4'b1110;
    
    #T
    
    if(ALU_OUT_tb == (A_tb <<1) && flags == 4'b0001)
        $display(" << IS PASSED ");
    else
        $display(" <<  IS FAILED ");  
        
    $display("******** TEST CASE 16 *************\n");
    A_tb = 16'b10;
    B_tb = 16'b10;
    ALU_FUN_tb = 4'b1111;
    
    #T
    
    if(ALU_OUT_tb == 16'd0 && flags == 4'b0000)
        $display("def IS PASSED ");
    else
        $display("def IS FAILED");
    
    #100 $finish;
      
end
  
  
endmodule