`timescale 1us/1us

module ALU_TOP_tb();
  
  // tb parameters
  parameter WIDTH_tb = 16;

  // tb signals
  reg [WIDTH_tb - 1 : 0]A_tb, B_tb;
  reg [3 : 0]ALU_FUN_tb;
  reg CLK_tb, RST_tb;
  wire [2*WIDTH_tb - 1 : 0]Arith_OUT_tb;
  wire Carry_OUT_tb;
  wire Arith_Flag_tb;
  wire [WIDTH_tb - 1 : 0]Logic_OUT_tb;
  wire Logic_Flag_tb;
  wire [1:0]CMP_OUT_tb;
  wire CMP_Flag_tb;
  wire [WIDTH_tb - 1 : 0]SHIFT_OUT_tb;
  wire SHIFT_Flag_tb;
  
  //flags
  wire [3:0]flags;
  assign flags = {Arith_Flag_tb, Logic_Flag_tb, CMP_Flag_tb, SHIFT_Flag_tb};
  // instance of TOP module
  
   ALU_TOP #(.WIDTH(WIDTH_tb)) uut (
  .A(A_tb), .B(B_tb),
  .ALU_FUN(ALU_FUN_tb),
  .CLK(CLK_tb), .RST(RST_tb),
  .Arith_OUT(Arith_OUT_tb),
  .Carry_OUT(Carry_OUT_tb),
  .Arith_Flag(Arith_Flag_tb),
  .Logic_OUT(Logic_OUT_tb),
  .Logic_Flag(Logic_Flag_tb),
  .CMP_OUT(CMP_OUT_tb),
  .CMP_Flag(CMP_Flag_tb),
  .SHIFT_OUT(SHIFT_OUT_tb),
  .SHIFT_Flag(SHIFT_Flag_tb)
);

  //generate clk
  
parameter T = 10;
always  
  begin 
      #(T*0.4) CLK_tb = ~CLK_tb;
      #(T*0.6) CLK_tb = ~CLK_tb;
  end

  //stimulus
  initial
  begin
    $dumpfile("ALU.vcd");
    $dumpvars;
    //initial values
    CLK_tb = 1'b0;
    RST_tb = 1'b1; 
    #T
    RST_tb = 1'b0;//activate
    #T
    RST_tb = 1'b1;
    $display("/////////////////// Arithmatic \\\\\\\\\\\\\\\\\\\\\\\\\n");
    $display("*********** Test case 1 (Addition) ****************");
    //1 + + 
    A_tb = 'd10;
    B_tb = 'd15;
    ALU_FUN_tb = 4'b0000;
    #T
    if(Arith_OUT_tb == 'd25 && flags == 4'b1000)
        $display("+v + +v IS PASSED\n");
    else
        $display("+v + +v IS FAILED\n");
    //2 + - 
    A_tb = 'd10;
    B_tb = -'d15;
    ALU_FUN_tb = 4'b0000;
    #T
    if(Arith_OUT_tb == -'d5 && flags == 4'b1000)
        $display("+v + -v IS PASSED");
    else
        $display("+v + -v IS FAILED");
    //3 - +
    A_tb = -'d10;
    B_tb = 'd15;
    ALU_FUN_tb = 4'b0000;
    #T
    if(Arith_OUT_tb == 'd5 && flags == 4'b1000)
        $display("-v + +v IS PASSED");
    else
        $display("-v + +v IS FAILED");
    // 4 - -
    A_tb = -'d10;
    B_tb = -'d15;
    ALU_FUN_tb = 4'b0000;
    #T
    if(Arith_OUT_tb == -'d25 && flags == 4'b1000)
        $display("-v + -v IS PASSED");
    else
        $display("-v + -v IS FAILED");
    
    $display("*********** Test case 2 (Substraction) ****************");
    //1 +v - +v
    A_tb = 'd10;
    B_tb = 'd5;
    ALU_FUN_tb = 4'b0001;
    #T
    if(Arith_OUT_tb == 'd5 && flags == 4'b1000)
        $display("+v - +v IS PASSED");
    else
        $display("+v - +v IS FAILED");
    //2 +v - -v
    A_tb = 'd15;
    B_tb = -'d10;
    ALU_FUN_tb = 4'b0001;
    #T
    if(Arith_OUT_tb == 'd25 && flags == 4'b1000)
        $display("+v - -v IS PASSED");
    else
        $display("+v - -v IS FAILED");
    //3 -v - +v
    A_tb = -'d15;
    B_tb = 'd10;
    ALU_FUN_tb = 4'b0001;
    #T
    if(Arith_OUT_tb == -'d25 && flags == 4'b1000)
        $display("-v - +v IS PASSED");
    else
        $display("-v - +v IS FAILED");
    //4 -v - -v
    A_tb = -'d10;
    B_tb = -'d30;
    ALU_FUN_tb = 4'b0001;
    #T
    if(Arith_OUT_tb == 'd20 && flags == 4'b1000)
        $display("-v - -v IS PASSED");
    else
        $display("-v - -v IS FAILED");
    $display("*********** Test case 3 (Multiblication) ****************");
    //1 +v * +v
    A_tb = 'd10;
    B_tb = 'd20;
    ALU_FUN_tb = 4'b0010;
    #T
    if(Arith_OUT_tb == 'd200 && flags == 4'b1000)
        $display(" +V * +V IS PASSED");
    else
        $display(" +V * +V IS FAILED");
    //2 +v * -v
    A_tb = 'd10;
    B_tb = -'d15;
    ALU_FUN_tb = 4'b0010;
    #T
    if(Arith_OUT_tb == -'d150 && flags == 4'b1000)
        $display(" +v * -v IS PASSED");
    else
        $display(" +v * -v IS FAILED");
    //3 -v * +v
    A_tb = -'d10;
    B_tb = 'd20;
    ALU_FUN_tb = 4'b0010;
    #T
    if(Arith_OUT_tb == -'d200 && flags == 4'b1000)
        $display(" -v * +v IS PASSED");
    else
        $display(" -v * +v IS FAILED");
    //4 -v * -v
    A_tb = -'d10;
    B_tb = -'d10;
    ALU_FUN_tb = 4'b0010;
    #T
    if(Arith_OUT_tb == 'd100 && flags == 4'b1000)
        $display(" -v * -v IS PASSED");
    else
        $display(" -v * -v IS FAILED");

    $display("*********** Test case 4 (Division) ****************");
    //1 +v / +v
    A_tb = 'd100;
    B_tb = 'd10;
    ALU_FUN_tb = 4'b0011;
    #T
    if(Arith_OUT_tb == 'd10 && flags == 4'b1000)
        $display("+v / +v IS PASSED");
    else
        $display("+v / +v IS FAILED");
    //2 +v / -v
    A_tb = 'd100;
    B_tb = -'d10;
    ALU_FUN_tb = 4'b0011;
    #T
    if(Arith_OUT_tb == -'d10 && flags == 4'b1000)
        $display("+v / -v IS PASSED");
    else
        $display("+v / -v IS FAILED");
    //3 -v / +v
    A_tb = -'d100;
    B_tb = 'd10;
    ALU_FUN_tb = 4'b0011;
    #T
    if(Arith_OUT_tb == -'d10 && flags == 4'b1000)
        $display("-v / +v IS PASSED");
    else
        $display("-v / +v IS FAILED");
    //4 -v / -v
    A_tb = -'d100;
    B_tb = -'d10;
    ALU_FUN_tb = 4'b0011;
    #T
    if(Arith_OUT_tb == 'd10 && flags == 4'b1000)
        $display("-v / -v IS PASSED");
    else
        $display("-v / -v IS FAILED");

    $display("/////////////////// Logical \\\\\\\\\\\\\\\\\\\\\\\\\n");
    $display("*********** Test case 1 (AND) ****************");
    A_tb = 'd10;
    B_tb = 'd20;
    ALU_FUN_tb = 4'b0100;
    #T
    if(Logic_OUT_tb == (10&20) && flags == 4'b0100)
        $display(" & IS PASSED ");
    else
        $display(" & IS FAILED ");
    $display("*********** Test case 2 (OR) ****************");
    A_tb = 'd10;
    B_tb = 'd20;
    ALU_FUN_tb = 4'b0101;
    #T
    if(Logic_OUT_tb == (10|20) && flags == 4'b0100)
        $display(" | IS PASSED");
    else
        $display(" | IS FAILED");
    $display("*********** Test case 3 (NAND) ****************");
    A_tb = 'd10;
    B_tb = 'd20;
    ALU_FUN_tb = 4'b0110;
    #T
    if(Logic_OUT_tb == ~(10 & 20) && flags == 4'b0100)
        $display(" ~& IS PASSED");
    else
        $display(" ~& IS FAILED");
    $display("*********** Test case 4 (NOR) ****************");
    A_tb = 'd10;
    B_tb = 'd20;
    ALU_FUN_tb = 4'b0111;
    #T
    if(Logic_OUT_tb == ~(10|20) && flags == 4'b0100)
        $display(" ~| IS PASSED");
    else
        $display(" ~| IS FAILED");
    $display("/////////////////// CMP \\\\\\\\\\\\\\\\\\\\\\\\\n");
    $display("*********** Test case 1 (NOP) ****************");
    A_tb = 'd10;
    B_tb = 'd20;
    ALU_FUN_tb = 4'b1000;
    #T
    if(CMP_OUT_tb == 2'b0 && flags == 4'b0010)
        $display(" NOP IS PASSED");
    else
        $display(" NOP IS FAILED");
    $display("*********** Test case 2 (A = B) ****************");
    A_tb = 'd10;
    B_tb = 'd10;
    ALU_FUN_tb = 4'b1001;
    #T
    if(CMP_OUT_tb == 2'd1 && flags == 4'b0010)
        $display(" = (1) IS PASSED");
    else
        $display(" = (1) IS FAILED");
    A_tb = 'd10;
    B_tb = 'd15;
    ALU_FUN_tb = 4'b1001;
    #T
    if(CMP_OUT_tb == 2'd0 && flags == 4'b0010)
        $display(" = (0) IS PASSED");
    else
        $display(" = (0) IS FAILED");
    $display("*********** Test case 3 (A > B) ****************");
    A_tb = 'd10;
    B_tb = 'd5;
    ALU_FUN_tb = 4'b1010;
    #T
    if(CMP_OUT_tb == 2'd2 && flags == 4'b0010)
        $display(" > (2) IS PASSED ");  
    else
        $display(" > (2) IS FAILED ");
    A_tb = 'd5;
    B_tb = 'd15;
    ALU_FUN_tb = 4'b1010;
    #T
    if(CMP_OUT_tb == 2'd0 && flags == 4'b0010)
        $display(" > (0) IS PASSED ");  
    else
        $display(" > (0) IS FAILED ");
    $display("*********** Test case 4 (A < B) ****************");
    A_tb = 'd10;
    B_tb = 'd20;
    ALU_FUN_tb = 4'b1011;
    #T
    if(CMP_OUT_tb == 2'd3 && flags == 4'b0010)
        $display(" < (3) IS PASSED");
    else
        $display(" < (3) IS FAILED");
    A_tb = 'd20;
    B_tb = 'd10;
    ALU_FUN_tb = 4'b1011;
    #T
    if(CMP_OUT_tb == 2'd0 && flags == 4'b0010)
        $display(" < (0) IS PASSED");
    else
        $display(" < (0) IS FAILED");
    $display("/////////////////// SHIFT \\\\\\\\\\\\\\\\\\\\\\\\\n");
    $display("*********** Test case 1 (A >> 1) ****************");
    A_tb = 'b0010;
    B_tb = 'b1001;
    ALU_FUN_tb = 4'b1100;
    #T
    if(SHIFT_OUT_tb == (A_tb >> 1) && flags == 4'b0001)
        $display("shift Right (A) IS PASSED ");
    else
        $display("shift Right (A) IS FAILED ");
    $display("*********** Test case 2 (A << 1) ****************");
    A_tb = 'b0010;
    B_tb = 'b1001;
    ALU_FUN_tb = 4'b1101;
    #T
    if(SHIFT_OUT_tb == (A_tb << 1) && flags == 4'b0001)
        $display("shift Lift (A) IS PASSED ");
    else
        $display("shift Lift (A) IS FAILED ");
    $display("*********** Test case 3 (B >> 1) ****************");
    A_tb = 'b0010;
    B_tb = 'b1001;
    ALU_FUN_tb = 4'b1110;
    #T
    if(SHIFT_OUT_tb == (B_tb >> 1) && flags == 4'b0001)
        $display("shift Right (B) IS PASSED ");
    else
        $display("shift Right (B) IS FAILED ");
    $display("*********** Test case 1 (A >> 1) ****************");
    A_tb = 'b0010;
    B_tb = 'b1001;
    ALU_FUN_tb = 4'b1111;
    #T
    if(SHIFT_OUT_tb == (B_tb << 1) && flags == 4'b0001)
        $display("shift Lift (B) IS PASSED ");
    else
        $display("shift Lift (B) IS FAILED ");

    #100 $finish;
    

  end

endmodule
