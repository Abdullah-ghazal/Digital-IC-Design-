module Ass2_tb();
  
  reg [4:0] IN_tb;
  reg Load_tb;
  reg Up_tb;
  reg Down_tb;
  reg CLK_tb;
  wire High_tb;
  wire [4:0] Counter_tb;
  wire Low_tb;
  
  //instance
  Ass2 uut(
    .IN(IN_tb),
    .Load(Load_tb),
    .Up(Up_tb),
    .Down(Down_tb),
    .CLK(CLK_tb),
    .High(High_tb),
    .Counter(Counter_tb),
    .Low(Low_tb)    
  );
  
  
  //clk 
  parameter T = 10;
  always #(T/2) CLK_tb = ~CLK_tb;
  
  initial
  begin
    $dumpfile("Up_Down_Counter");
    $dumpvars;
    //initial values
    IN_tb = 5'd15;
    Load_tb = 1'b0;
    Up_tb = 1'b0;
    Down_tb = 1'b0;
    CLK_tb = 1'b0;
    
    $display("************ TEST CASE 1 ***************"); //load
    #3
    Load_tb = 1'b1;
    Up_tb = 1'b0;
    Down_tb = 1'b0;
    #7
    if(Counter_tb == 5'd15)
        $display(" LOAD PASSED ");
    else
        $display(" LAOD FAILED ");
        
    $display("************ TEST CASE 2 ****************"); //UP
    #3
    Load_tb = 1'b0;
    Up_tb = 1'b1;
    Down_tb = 1'b0;      
    #7
    if(Counter_tb == 5'd16)
        $display(" UP 1 PASSED ");
    else
        $display(" UP 1 FAILED ");
    #10
    if(Counter_tb == 5'd17)
        $display(" UP 2 PASSED ");
    else
        $display(" UP 2 FAILED ");
    #20
    if(Counter_tb == 5'd19)
        $display(" UP 3 PASSED ");
    else
        $display(" UP 4 FAILED ");
		
	$display("*************** TEST CASE 3 *******************"); //Down
	#3
	Load_tb = 1'b0;
  Up_tb = 1'b0;
  Down_tb = 1'b1;     
	#(7+2*T)
	if(Counter_tb == 5'd16)
		$display(" DOWN PASSED ");
	else
		$display(" Down FAILED ");
		
	$display("**************** TEST CASE 4 ***************");//down periorty
	#3
	 Load_tb = 1'b0;
    Up_tb = 1'b1;
    Down_tb = 1'b1;
	#7
	if(Counter_tb == 5'd15)
		$display(" down periorty IS PASSED ");
	else
		$display(" down periorty IS FAILED ");
	
	#100
	$finish; 
     

    
  end
  
endmodule

